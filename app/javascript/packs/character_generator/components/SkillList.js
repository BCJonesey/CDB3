var React = require('react');
var Skill = require('./Skill');


class SkillList extends React.Component {


  render() {
    return (
      <div className='container'>
          {this.props.skills.map( (skill) => {return(<Skill skill={skill} key={skill.id} />)} )}
      </div>
    )
  }

  
}

module.exports = SkillList;