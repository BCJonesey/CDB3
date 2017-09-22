var React = require('react');
var Currencies = require('./Currencies');


class CharacterDetails extends React.Component {

    componentWillMount(){
        window.ben = this.props
    }


  render() {
    return (
      <div className='container'>
          <div className='row'>
              <div className='col'>{this.props.character.name}</div>
              </div>
              <div className='row'>
              <Currencies currencySpend={this.props.currencySpend} currency_totals={this.props.character.currency_totals} />
              </div>
      </div>
    )
  }

  
}

module.exports = CharacterDetails;