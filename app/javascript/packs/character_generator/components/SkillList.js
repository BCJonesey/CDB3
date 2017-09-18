var React = require('react');
var Skill = require('./Skill');


class SkillList extends React.Component {


  render() {
    return (
      <div className='container'>
          {Object.keys(this.props.skills).map( (skillId) => {return(<Skill rankChangeHandler={this.props.rankChangeHandler.bind(this)} skill={this.props.skills[skillId]} key={skillId} />)} )}
      </div>
    )
  }


  
}

module.exports = SkillList;


