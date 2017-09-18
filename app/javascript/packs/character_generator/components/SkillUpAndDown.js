var React = require('react');


class SkillUpAndDown extends React.Component {


  render() {
    return (
      <div className='container'>
          <div className='row'>
          <div className='col' onClick={this._handleMinusClick.bind(this)}>-</div>
          <div className='col'>{this.props.value}</div>
          <div className='col' onClick={this._handlePlusClick.bind(this)}>+</div>
          </div>
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