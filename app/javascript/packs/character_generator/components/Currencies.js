var React = require('react');
var Currency = require('./Currency');


class Currencies extends React.Component {


  render() {
    if(this.props.currency_totals === undefined){
        return(<div/>)
    }
    return (
      <div className='card-deck'>
          {Object.keys(this.props.currency_totals).map( (currencyId) => {return(<Currency key={currencyId} shortName={currencyId} spent={this.props.currencySpend[currencyId]} earned={this.props.currency_totals[currencyId]} />)})}
      </div>
    )
  }

  
}

module.exports = Currencies;