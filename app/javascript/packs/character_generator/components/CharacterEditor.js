var React = require('react');
var DataApi = require('../utils/DataApi');
var Skill = require('./Skill');


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
      <div>
      <p>Character Name! {this.state.skills.length}</p>
      {this.state.skills.map( (skill) => {return(<Skill skill={skill} />)} )}
      </div>
    )
  }

  
}

module.exports = CharacterEditor;