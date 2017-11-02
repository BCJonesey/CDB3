var React = require('react');

class Skill extends React.Component {

  render() {
    return (
      <div className="container skill">
        <div className="row">
          <div className="col-3 name">{this.props.skill.name}</div>
          <div className="col summary">{this.props.skill.summary}</div>
        </div>
      </div>
    );
  }
  
}

module.exports = Skill;