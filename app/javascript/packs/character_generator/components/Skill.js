var React = require('react');
var SkillUpAndDown = require('./SkillUpAndDown');
var RulesProcessor = require('../utils/RulesProcessor');

class Skill extends React.Component {


  render() {
    return (
        <div className="container">
            <div className="row">
            <div className="col"><h4 className="card-title">{this.props.skill.name}</h4></div>
                
            </div>
            <div className="row">
            <div className="col">
                <SkillUpAndDown value={this.props.skill.rank} rankChangeHandler={this._rankChangeHandler.bind(this)}/>
            </div>
            <div className="col">{RulesProcessor.getCostString(this.props.skill)}</div>
            <div className="col">{this.props.skill.summary}</div>
            </div>
        </div>
    )
  }

  _rankChangeHandler(newValue){
      this.props.rankChangeHandler(this.props.skill.id,newValue);
  }

  
}

module.exports = Skill;




