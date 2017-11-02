var React = require('react');

class Traits extends React.Component {

  render() {
    return (
      <div className='row'>
        {Object.keys(this.props.traits).map((trait) => {return ( <div className="col" key={trait}><span className='badge badge-secondary'>{trait}</span></div>)} )}
      </div>
    );
  }
  
}

module.exports = Traits;