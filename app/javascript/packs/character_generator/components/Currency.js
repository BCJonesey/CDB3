var React = require('react');


class Currency extends React.Component {

    _amountRemaining(){
        var earned = this.props.earned
        var spent = this.props.spent
        if(this.props.earned === undefined){
            earned = 0
        }
        if(this.props.spent === undefined){
            spent = 0
        }
        return (earned - spent)
    }


  render() {
    return (
      <div className='container'>
          <div className='row'>
                  {this._amountRemaining()}
              </div>
              <div className='row'>
                {this.props.shortName}
              </div>
      </div>
    )
  }

  
}

module.exports = Currency;