var React = require('react');
var DataApi = require('../utils/DataApi');
var SkillList = require('./SkillList');
var SearchAndFilter = require('./SearchAndFilter');



class CharacterEditor extends React.Component {

  constructor(props){
    super(props);
    this.dataApi = new DataApi(this.props.gameUrl, this.props.characterId);
    this.state = {
      skills: [],
      name: "",
    }
  }

  componentWillMount(){
    this.dataApi.getSkills(this._skillsUpdate.bind(this))
  }

  _skillsUpdate(skills){
    this.setState({skills: skills})
  }



  render() {
    return (
      <div className='container'>
        <p>Character Name!</p>
        <SearchAndFilter />
        <SkillList skills={this.state.skills} />
      </div>
    )
  }

  
}

module.exports = CharacterEditor;