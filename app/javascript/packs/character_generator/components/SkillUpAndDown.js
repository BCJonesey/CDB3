var React = require('react');


class SkillUpAndDown extends React.Component {


  render() {
    return (
        <div className="input-group input-group-quantity" data-toggle="quantity">
            <span className="input-group-btn">
              <input type="button" value="-" className="btn btn-secondary quantity-down" field="quantity"  onClick={this._handleMinusClick.bind(this)} />
            </span>
            <input type="text" name="quantity" value={this.props.value} className="quantity form-control" />
            <span className="input-group-btn">
              <input type="button" value="+" className="btn btn-secondary quantity-up" field="quantity"  onClick={this._handlePlusClick.bind(this)} />
            </span>
          </div>
    )
  }

  _handlePlusClick(){
        this.props.rankChangeHandler(this.props.value + 1);
    }
_handleMinusClick(){
    this.props.rankChangeHandler(this.props.value - 1);
    }

  
}

module.exports = SkillUpAndDown;



