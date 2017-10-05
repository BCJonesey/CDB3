var React = require('react');
var Modal = require('react-bootstrap4-modal').default;


class DetailMessage extends React.Component {

    _dismiss(){
    this.props.dismiss()
  }

  render() {
    return (
      <Modal visible={true} onClickBackdrop={this._dismiss.bind(this)}>
        <div className="modal-header">
          <h5 className="modal-title">{this.props.skill.name}</h5>
        </div>
        <div className="modal-body">
          <p>
            {this.props.skill.description}
          </p>
        </div>
        <div className="modal-footer">
          <button type="button" className="btn btn-primary" onClick={this._dismiss.bind(this)}>
            your face is a dismiss button
          </button>
        </div>
      </Modal>
      
    )
  }

  
}

module.exports = DetailMessage;