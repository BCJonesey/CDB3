var React = require('react');
var SkillUpAndDown = require('./SkillUpAndDown');

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
            <div className="col">{this.props.skill.summary}</div>
            </div>
        </div>
    )
  }

  _rankChangeHandler(newValue){
      console.log(this.props.skill.name)
      console.log(newValue)
  }

  
}

module.exports = Skill;




