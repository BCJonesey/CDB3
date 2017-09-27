var React = require('react');
var SkillUpAndDown = require('./SkillUpAndDown');
var Tags = require('./Tags');
var RulesProcessor = require('../utils/RulesProcessor');

class Skill extends React.Component {

  _getTags(){
    return this.props.skill.skill_tags.map(function(skill_tag){return skill_tag.tag})
  }

  render() {
    return (
        [<tr key='body'>
        <td>
        <SkillUpAndDown value={this.props.skill.rank} skill={this.props.skill} rankChangeHandler={this._rankChangeHandler.bind(this)}/>
        </td>
        
        <td> <span className="font-weight-bold">{this.props.skill.name}</span> </td>
        <td>{RulesProcessor.getCostString(this.props.skill)}</td>
        <td className="text-center">
        {this.props.skill.summary}
        </td>
      </tr>,
      <tr key='tags'>
        <td colSpan='4'> 
          <Tags tags={this._getTags()} />
        </td>
      </tr>])
  }

  _rankChangeHandler(newValue){
      this.props.rankChangeHandler(this.props.skill.id,newValue);
  }

  
}

module.exports = Skill;




