var React = require('react');
var Skill = require('./Skill')

class SkillGroup extends React.Component {

  render() {
    if(this.props.skills.length == 0){
      return(null)
    }
    return (
      <div className="container skillgroup">
        <h3 className="title-divider"><span>{this.props.title}</span></h3>
        {this.props.skills.map((skill) => {return ( < Skill key={skill.id} skill = {skill} />)} )} 
      </div>
    );
  }
  
}

module.exports = SkillGroup;