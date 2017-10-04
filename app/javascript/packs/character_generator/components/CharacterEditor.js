var React = require('react');
var DataApi = require('../utils/DataApi');
var SkillList = require('./SkillList');
var CharacterDetails = require('./CharacterDetails');
var StatusMessages = require('./StatusMessages');
var RulesProcessor = require('../utils/RulesProcessor');
var LangUtils = require('../utils/LangUtils');

class CharacterEditor extends React.Component {

  constructor(props){
    super(props);
    this.dataApi = new DataApi(this.props.gameUrl, this.props.characterId);
    this.state = {
      skills: {},
      character: {},
      currencySpend: {},
      sideEffects: {},
      errorMessages: [],
      skillCache: {}
    }
  }

  componentWillMount(){
    this.dataApi.getSkills(this._skillsUpdate.bind(this))
    this.dataApi.getCharacterData(this._characterUpdate.bind(this))
  }

  _acknowledgeMessages(){
    this.setState({errorMessages: []})
  }

 

  _skillsUpdate(skills){
    this.setState({skills: skills})
    this._evalCharacterState()
  }

  _characterUpdate(characterData){
    this.setState({character: characterData})
    this._evalCharacterState()
  }

  _evalCharacterState(){
    if(!(this.state.character.currency_totals === undefined) && Object.keys(this.state.skills).length > 0){
      this.setState(RulesProcessor.evalRulesAndSpend(this.state.skills, this.state.character.currency_totals))
    }
  }

  _rankChangeHandler(skillId, newRank){
    var skillCopy = LangUtils.deepCopy(this.state.skills);
    skillCopy[skillId].rank = newRank
    var result = RulesProcessor.evalRulesAndSpend(skillCopy, this.state.character.currency_totals)
    if(result.errorMessages.length == 0){
      this.dataApi.updateSkillRank(skillId, newRank, this._skillsUpdate.bind(this));
      result.skills = skillCopy
    }

    this.setState(result)
    
  }

  _getValidSkillList(){
    return Object.values(this.state.skills).filter((skill) => {
      if(skill.rank > 0 || RulesProcessor.evalRulesAndSpend(this.state.skills, {}, skill.id).errorMessages.length == 0){
        return true;
      }
      return false;
    })
  }


  render() {
    return (
      <div className='container-fluid character-editor'>
        <div className='row'>
        <CharacterDetails character={this.state.character} currencySpend={this.state.currencySpend} sideEffects={this.state.sideEffects}  />
        </div>
        <div className='row'>
        <div className='col'>
        <StatusMessages errorMessages={this.state.errorMessages}  acknowledgeMessages={this._acknowledgeMessages.bind(this)}/>
        <SkillList skills={this._getValidSkillList()} rankChangeHandler={this._rankChangeHandler.bind(this)} />
        </div>
        </div>
        
      </div>
    )
  }

  
}

module.exports = CharacterEditor;