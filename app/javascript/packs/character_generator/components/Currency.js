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
      <div className='card'>
          <div className='card-body'>
                  
                  <h4 className="card-title text-primary">{this._amountRemaining()}</h4>
                  <h4 className="card-title">{this.props.shortName}</h4>

        </div>
      </div>
    )
  }

  
}

module.exports = Currency;

