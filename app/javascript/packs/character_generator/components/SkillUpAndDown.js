var React = require('react');


class SkillUpAndDown extends React.Component {

  _plusButton(){
    const className = "input-group-btn " + (this.props.skill.max_rank > this.props.rank ? "visible" : "invisible")
   
      return(
        <span className={className}>
        <input type="button" value="+" className="btn btn-secondary quantity-up" onClick={this._handlePlusClick.bind(this)} />
      </span>
      )
    
  }

  _minusButton(){
    const className = "input-group-btn " + (this.props.rank>0 ? "visible" : "invisible")
      return(
    <span className={className}>
    <input type="button" value="-" className="btn btn-secondary quantity-down"  onClick={this._handleMinusClick.bind(this)} />
  </span>
   )
  
  }
  render() {
    return (
        <div className="input-group input-group-quantity skill-spinner" data-toggle="quantity">
            {this._minusButton()}
            <span className="quantity" >{this.props.rank} </span>
            {this._plusButton()}
            
            
          </div>
    )
  }

  _handlePlusClick(){
      if(this.props.skill.max_rank > this.props.rank){
          this.props.rankChangeHandler(this.props.rank + 1);
      }
    }
_handleMinusClick(){
    if(this.props.rank>0){
      this.props.rankChangeHandler(this.props.rank - 1);
    }
    }

  
}

module.exports = SkillUpAndDown;



