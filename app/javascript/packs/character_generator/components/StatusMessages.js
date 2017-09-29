var React = require('react');
var Modal = require('react-bootstrap4-modal').default;


class StatusMessages extends React.Component {

  _acknowledgeMessages(){
    this.props.acknowledgeMessages()
  }

  _isVisible(){
    return this.props.errorMessages.length > 0
  }

  render() {
    return (
      <Modal visible={this._isVisible()} onClickBackdrop={this._acknowledgeMessages.bind(this)}>
        <div className="modal-header">
          <h5 className="modal-title">Nice Try, Buddy....</h5>
        </div>
        <div className="modal-body">
          <div className='container'>
            <div key='-1' className='row'>Making that change would cause the following issue(s):</div>
            {this.props.errorMessages.map( (message, index) => {return(<div key={index} className='row'>{message}</div>)} )}
          </div>
        </div>
        <div className="modal-footer">
          <button type="button" className="btn btn-primary" onClick={this._acknowledgeMessages.bind(this)}>
            OK, you caught me.
          </button>
        </div>
      </Modal>
      
    )
  }

  
}

module.exports = StatusMessages;