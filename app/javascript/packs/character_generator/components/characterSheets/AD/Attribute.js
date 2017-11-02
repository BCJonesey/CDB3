var React = require('react');

class Attribute extends React.Component {

  render() {
    return (
      <div className="col">
          {this.props.label}: {this.props.value}
      </div>
    );
  }
  
}

module.exports = Attribute;