var React = require('react');

class Skill extends React.Component {

  render() {
    return (
      <div className="container skill">
        <div className="row">
          <div className="col-4 name font-weight-bold">{this.props.skill.name}</div>
          <div className="col summary">{this.props.skill.summary}</div>
        </div>
      </div>
    );
  }
  
}

module.exports = Skill;