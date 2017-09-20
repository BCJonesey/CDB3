var React = require('react');
var Skill = require('./Skill');


class SkillList extends React.Component {


  render() {
    return (
      <div className="container">
      <div className="cart-content">
        <table className="table table-responsive mb-0 cart-table">

          <tbody >
          {Object.keys(this.props.skills).map( (skillId) => {return(<Skill rankChangeHandler={this.props.rankChangeHandler.bind(this)} skill={this.props.skills[skillId]} key={skillId} />)} )}
          </tbody>
        </table>
        </div>
    </div>
    )
  }


  
}

module.exports = SkillList;

