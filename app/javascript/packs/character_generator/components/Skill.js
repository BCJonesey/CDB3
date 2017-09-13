var React = require('react');


class Skill extends React.Component {



  render() {
    return (
        <div>
            <span>
                {this.props.skill.name}
            </span>
        </div> 
    )
  }

  
}

module.exports = Skill;