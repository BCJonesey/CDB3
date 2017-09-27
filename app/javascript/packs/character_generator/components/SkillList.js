var React = require('react');
var Skill = require('./Skill');
var RulesProcessor = require('../utils/RulesProcessor');

class SkillList extends React.Component {

  _getValidSkillsIdList(){
    return Object.keys(this.props.skills).filter((skillId) => {
      skill = this.props.skills[skillId]
      if(skill.rank > 0 || RulesProcessor.evalRulesAndSpend(this.props.skills, {}, skillId).errorMessages.length == 0){
        return true;
      }
      return false;
    });
  }


  render() {
    return (
      <div className="container">
      <div className="cart-content">
        <table className="table table-responsive mb-0 cart-table">

          <tbody >
          {this._getValidSkillsIdList().map( (skillId) => {return(<Skill rankChangeHandler={this.props.rankChangeHandler.bind(this)} skill={this.props.skills[skillId]} key={skillId} />)} )}
          </tbody>
        </table>
        </div>
    </div>
    )
  }


  
}

module.exports = SkillList;

