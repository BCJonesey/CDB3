var React = require('react');
var SkillUpAndDown = require('./SkillUpAndDown');
var RulesProcessor = require('../utils/RulesProcessor');

class Skill extends React.Component {

    
  render() {
    return (
        <tr>
        <td>
        <SkillUpAndDown value={this.props.skill.rank} rankChangeHandler={this._rankChangeHandler.bind(this)}/>
        </td>
        
        <td> <span className="font-weight-bold">{this.props.skill.name}</span> </td>
        <td>{RulesProcessor.getCostString(this.props.skill)}</td>
        <td className="text-center">
        {this.props.skill.summary}
        </td>
      </tr>


    )
  }

  _rankChangeHandler(newValue){
      this.props.rankChangeHandler(this.props.skill.id,newValue);
  }

  
}

module.exports = Skill;




