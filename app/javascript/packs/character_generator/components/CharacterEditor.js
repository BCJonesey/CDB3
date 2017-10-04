var React = require('react');
var SkillList = require('./SkillList');
var CharacterDetails = require('./CharacterDetails');
var CharacterStats = require('./CharacterStats');
var StatusMessages = require('./StatusMessages');
var SearchAndFilter = require('./SearchAndFilter');

class CharacterEditor extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      selectedTags: [],
      searchText: ""
    }
  }

  _onTagSelected(tag) {
    if (this.state.selectedTags.filter(obj => obj.id == tag.id).length == 0) {
      this.setState({
        selectedTags: this.state.selectedTags.concat(tag)
      });
    }

  }

  _onTagUnselected(tag) {
    this.setState({
      selectedTags: this.state.selectedTags.filter(obj => obj.id != tag.id)
    });
  }

  _seachTextUpdated(newText) {
    this.setState({
      searchText: newText.toLowerCase()
    });
  }


  render() {
    return (
      <div className='container-fluid character-editor'>
        <div className='row'>
        <CharacterDetails character={this.props.character} currencySpend={this.props.currencySpend} sideEffects={this.props.sideEffects}  />
        </div>
        <div className='row'>
        <div className='col-md-4'>
          <CharacterStats character={this.props.character} currencySpend={this.props.currencySpend} sideEffects={this.props.sideEffects}  />
        </div>
        <div className='col-md-8'>
        <StatusMessages errorMessages={this.props.errorMessages}  acknowledgeMessages={this.props.acknowledgeMessages.bind(this)}/>
        <SearchAndFilter 
              selectedTags = {this.state.selectedTags}
              onTagUnselected = {this._onTagUnselected.bind(this)}
              seachTextUpdated = {this._seachTextUpdated.bind(this)}
            /> 
        <SkillList selectedTags={this.state.selectedTags} searchText={this.state.searchText} skills={this.props.skills} skillRanks={this.props.skillRanks} rankChangeHandler={this.props.rankChangeHandler.bind(this)} onTagSelected = {this._onTagSelected.bind(this)} />
        </div>
        </div>
        
      </div>
    )
  }

  
}

module.exports = CharacterEditor;