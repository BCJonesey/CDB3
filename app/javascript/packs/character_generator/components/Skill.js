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
      <div className="row skill">
        <div className="col">
        <div className="container">
          <div className="row">
          <SkillUpAndDown value={this.props.skill.rank} skill={this.props.skill} rankChangeHandler={this._rankChangeHandler.bind(this)}/>
            </div>
            <div className="row">
            {RulesProcessor.getCostString(this.props.skill)}
            </div>
          </div>
        </div>
        <div className="col">
        <div className="container">
          <div className="row">
          <span className="font-weight-bold">{this.props.skill.name}</span> 
            </div>
            <div className="row">
            <Tags tags={this._getTags()} onTagSelected={this.props.onTagSelected.bind(this)} />
            </div>
          </div>
        
        </div>
        <div className="col">
        {this.props.skill.summary}
        </div>
      </div>
    )
  }

  _rankChangeHandler(newValue){
      this.props.rankChangeHandler(this.props.skill.id,newValue);
  }

  
}

module.exports = Skill;




