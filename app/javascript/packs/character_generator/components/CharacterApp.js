var React = require('react');
var DataApi = require('../utils/DataApi');
var CharacterEditor = require('./CharacterEditor');
var CharacterSheet = require('./CharacterSheet')
var RulesProcessor = require('../utils/RulesProcessor');

class CharacterApp extends React.Component {

  constructor(props) {
    super(props);
    this.dataApi = new DataApi(this.props.gameUrl, this.props.characterId);
    this.state = {
      skills: {},
      skillRanks: {},
      character: {},
      errorMessages: []
    }
  }


  componentWillMount() {
    this.dataApi.getSkillData(this._skillsUpdate.bind(this))
    this.dataApi.getCharacterData(this._characterUpdate.bind(this))
  }


  _isViewOnly(){
    return this.props.isViewOnly;
  }

  _acknowledgeMessages() {
    this.setState({ errorMessages: [] })
  }

  _skillsUpdate(skillData) {
    this.setState(skillData)
  }

  _characterUpdate(characterData) {
    this.setState({ character: characterData })
  }

  _isLoading() {
    return Object.keys(this.state.character).length == 0 || Object.keys(this.state.skills).length == 0
  }

  _evalCharacterState() {
    const options = {
      skillRanks: this.state.skillRanks,
      currencyTotals: this.state.character.currency_totals,
      gameSideEffects: this.state.character.game_rules.side_effects
    }

    return RulesProcessor.evalRulesAndSpend(this.state.skills, options);
  }

  _rankChangeHandler(skillId, newRank) {

    const options = {
      skillRanks: this.state.skillRanks,
      skillToUpdate: this.state.skills[skillId],
      newRank: newRank,
      currencyTotals: this.state.character.currency_totals,
      gameSideEffects: this.state.character.game_rules.side_effects
    }
    var result = RulesProcessor.evalRulesAndSpend(this.state.skills, options)
    if (result.errorMessages.length == 0) {
      this.dataApi.updateSkillRank(skillId, newRank, this._apiError.bind(this));
      this.setState({ skillRanks: result.skillRanks })
    } else {
      this.setState({ errorMessages: result.errorMessages })
    }
  }

  _apiError(error) {
    console.log(error)
    this.setState({ errorMessages: ["Shit got fucked up, you shoudl just reload the page....."] })
  }

  _getValidSkillList(characterState) {
    const costOptions = {
      skillRanks: this.state.skillRanks,
      characterState: characterState,
      skills: this.state.skills
    }
    return Object.values(this.state.skills).filter((skill) => {
      if (this.state.skillRanks[skill.id] > 0) {
        return true;
      } else if(this._isViewOnly()){
        return false;
      }
      const options = {
        skillRanks: this.state.skillRanks,
        skillToUpdate: skill,
        newRank: 1
      }
      return RulesProcessor.evalRulesAndSpend(this.state.skills, options).errorMessages.length == 0;
    }).map((skill) => {
      skill.displayCost = RulesProcessor.getCostString(skill.id, costOptions);
      return skill;
    }).sort(function (a, b) {
      return a.weight - b.weight;
    });
  }


  render() {
    if(this._isLoading()){
      return(
        <div className="container">Loading</div>
      )

    }else{
      
      const characterState = this._evalCharacterState();
      const validSkillList = this._getValidSkillList(characterState)
      if(this._isViewOnly()){
        return(
        <CharacterSheet 
        character={this.state.character} 
        skills={validSkillList} 
        skillRanks={this.state.skillRanks}
        currencySpend={characterState.currencySpend} 
        sideEffects={characterState.sideEffects}
        />
        )
      }else{
        return (
          <CharacterEditor 
          character={this.state.character}
          workspace={characterState.workspace} 
          skills={validSkillList} 
          skillRanks={this.state.skillRanks} 
          grantedTags={characterState.grantedTags} 
          currencySpend={characterState.currencySpend} 
          sideEffects={characterState.sideEffects}
          errorMessages={this.state.errorMessages}
          rankChangeHandler={this._rankChangeHandler.bind(this)} 
          acknowledgeMessages={this._acknowledgeMessages.bind(this)}  
          />  
        )
      }
    }
  }

  
}

module.exports = CharacterApp;