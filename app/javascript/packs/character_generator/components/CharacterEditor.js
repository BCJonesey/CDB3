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
      skillRanks: {},
      character: {},
      currencySpend: {},
      sideEffects: {},
      errorMessages: [],
    }
  }

  componentWillMount(){
    this.dataApi.getSkillData(this._skillsUpdate.bind(this))
    this.dataApi.getCharacterData(this._characterUpdate.bind(this))
  }

  _acknowledgeMessages(){
    this.setState({errorMessages: []})
  }

 

  _skillsUpdate(skillData){
    this.setState(skillData)
    this._evalCharacterState()
  }

  _characterUpdate(characterData){
    this.setState({character: characterData})
    this._evalCharacterState()
  }

  _evalCharacterState(){
    if(!(this.state.character.currency_totals === undefined) && Object.keys(this.state.skills).length > 0){
      this.setState(RulesProcessor.evalRulesAndSpend(this.state.skills, this.state.character.currency_totals,{skillRanks: this.state.skillRanks}))
    }
  }

  _rankChangeHandler(skillId, newRank){

    const options = {
      skillRanks: this.state.skillRanks,
      skillToUpdate: this.state.skills[skillId],
      newRank: newRank
    }
    var result = RulesProcessor.evalRulesAndSpend(this.state.skills, this.state.character.currency_totals, options)
    if(result.errorMessages.length == 0){
      this.dataApi.updateSkillRank(skillId, newRank, this._apiError.bind(this));
      this.setState(result)
    }else{
      this.setState({errorMessages: result.errorMessages})
    }


    
    
  }

  _apiError(error){
    console.log(error)
    this.setState({errorMessages: ["Shit got fucked up, you shoudl just reload the page....."]})
  }

  _getValidSkillList(){
    return Object.values(this.state.skills).filter((skill) => {
      const options = {
        skillRanks: this.state.skillRanks,
        skillToUpdate: skill,
        newRank: 1
      }
      if(skill.rank > 0 || RulesProcessor.evalRulesAndSpend(this.state.skills, {}, options).errorMessages.length == 0){
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
        <SkillList skills={this._getValidSkillList()} skillRanks={this.state.skillRanks} rankChangeHandler={this._rankChangeHandler.bind(this)} />
        </div>
        </div>
        
      </div>
    )
  }

  
}

module.exports = CharacterEditor;