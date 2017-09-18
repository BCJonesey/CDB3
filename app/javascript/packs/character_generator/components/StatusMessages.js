var React = require('react');


class StatusMessages extends React.Component {


  render() {
    return (
      <div className='container'>
          {this.props.errorMessages.map( (message, index) => {return(<div key={index} className='row'>{message}</div>)} )}
      </div>
    )
  }

  
}

module.exports = StatusMessages;