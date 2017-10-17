var React = require('react');
var DataApi = require('../utils/DataApi');
var CharacterEditor = require('./CharacterEditor');
var RulesProcessor = require('../utils/RulesProcessor');

class CharacterApp extends React.Component {

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
      grantedTags: []
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

  _isLoading(){
    this.state.character == {} || this.state.skills == {}
  }

  _evalCharacterState(){
    if(!(this.state.character.currency_totals === undefined) && Object.keys(this.state.skills).length > 0){
      const options = {
        skillRanks: this.state.skillRanks,
        skillToUpdate: this.state.skills[skillId],
        currencyTotals: this.state.character.currency_totals
      }
      this.setState(RulesProcessor.evalRulesAndSpend(this.state.skills, this.state.character.currency_totals,options))
    }
  }

  _rankChangeHandler(skillId, newRank){

    const options = {
      skillRanks: this.state.skillRanks,
      skillToUpdate: this.state.skills[skillId],
      newRank: newRank,
      currencyTotals: this.state.character.currency_totals
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
      if(skill.rank > 0){
        return true;
      }
      const options = {
        skillRanks: this.state.skillRanks,
        skillToUpdate: skill,
        newRank: 1
      }
      return RulesProcessor.evalRulesAndSpend(this.state.skills, {}, options).errorMessages.length == 0;
    })
  }


  render() {
    if(this._isLoading()){
      return(
        <div className="container">Loading</div>
      )

    }else{
      return (
        <CharacterEditor character={this.state.character} skills={this._getValidSkillList()} skillRanks={this.state.skillRanks} grantedTags={this.state.grantedTags} currencySpend={this.state.currencySpend} sideEffects={this.state.sideEffects} rankChangeHandler={this._rankChangeHandler.bind(this)} acknowledgeMessages={this._acknowledgeMessages.bind(this)}  errorMessages={this.state.errorMessages}/>  
      )
    }
  }

  
}

module.exports = CharacterApp;