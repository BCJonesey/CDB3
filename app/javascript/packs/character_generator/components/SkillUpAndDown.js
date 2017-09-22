var React = require('react');


class SkillUpAndDown extends React.Component {

  _plusButton(){
    if(this.props.skill.max_rank > this.props.skill.rank){
      return(
        <span className="input-group-btn">
        <input type="button" value="+" className="btn btn-secondary quantity-up" onClick={this._handlePlusClick.bind(this)} />
      </span>
      )
    }
  }

  _minusButton(){
    if(this.props.skill.rank>0){
      return(
     
    <span className="input-group-btn">
    <input type="button" value="-" className="btn btn-secondary quantity-down"  onClick={this._handleMinusClick.bind(this)} />
  </span>
   )
  }
  }
  render() {
    return (
        <div className="input-group input-group-quantity" data-toggle="quantity">
            {this._minusButton()}
            <span type="text" className="quantity form-control" >{this.props.skill.rank} </span>
            {this._plusButton()}
            
            
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



