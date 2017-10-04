var React = require('react');
var Currencies = require('./Currencies');


class CharacterStats extends React.Component {

    componentWillMount(){
        window.ben = this.props
    }


  render() {
    return (
      <div className='container'>
              <div className='row'>
              <Currencies currencySpend={this.props.currencySpend} currency_totals={this.props.character.currency_totals} />
              </div>
              <div className='row'>
              <Currencies currencySpend={{}} currency_totals={this.props.sideEffects} />
              </div>
      </div>
    )
  }

  
}

module.exports = CharacterStats;