var React = require('react');

class Traits extends React.Component {

 

  render() {
    if(this.props.traits==undefined || Object.keys(this.props.traits).length == 0){
      return null
    }
    return (
        <div className="container">
            <h4>Traits</h4>
            { Object.keys(this.props.traits).map( (trait) => {return(<div key={trait}>{trait}</div>)})}
        </div>
    )
  }


  
}

module.exports = Traits;