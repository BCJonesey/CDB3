var React = require('react');
var SkillList = require('./SkillList');
var CharacterDetails = require('./CharacterDetails');
var CharacterStats = require('./CharacterStats');
var StatusMessages = require('./StatusMessages');
var DetailMessage = require('./DetailMessage');
var SearchAndFilter = require('./SearchAndFilter');
var Tags = require('./Tags');

class CharacterEditor extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      selectedTags: [],
      searchText: "",
      detailSkill: null
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

  _renderDetails(){
    if(this.state.detailSkill == null){
      return null
    }else{
      return(
      <DetailMessage skill={this.state.detailSkill}  dismiss={()=>{this.setState({detailSkill: null})}} />
      )
    }
  }

  _showDetail(skill){
    this.setState({detailSkill: skill})
  }


  render() {
    return (
      <div className='container character-editor'>
        <div className='row'>
        <CharacterDetails character={this.props.character} currencySpend={this.props.currencySpend} sideEffects={this.props.sideEffects}  />
        </div>
        <div className='row'>
        <div className='col-md-4'>
          <div className='container'>
            <div className='row'>
            <h3>Attributes</h3>
              <CharacterStats character={this.props.character} currencySpend={this.props.currencySpend} sideEffects={this.props.sideEffects}  />
            </div>
            <div className='row'>
              <h3>Quick Tags</h3>
              <Tags tags={this.props.grantedTags} onTagSelected = {this._onTagSelected.bind(this)} />
            </div>
          </div>
        </div>
        <div className='col-md-8'>
        <StatusMessages errorMessages={this.props.errorMessages}  acknowledgeMessages={this.props.acknowledgeMessages.bind(this)}/>
        {this._renderDetails()}
        <SearchAndFilter 
              selectedTags = {this.state.selectedTags}
              onTagUnselected = {this._onTagUnselected.bind(this)}
              seachTextUpdated = {this._seachTextUpdated.bind(this)}
            /> 
        <SkillList selectedTags={this.state.selectedTags} searchText={this.state.searchText} skills={this.props.skills} skillRanks={this.props.skillRanks} rankChangeHandler={this.props.rankChangeHandler.bind(this)} onTagSelected = {this._onTagSelected.bind(this)} showDetail={this._showDetail.bind(this)} />
        </div>
        </div>
        
      </div>
    )
  }

  
}

module.exports = CharacterEditor;