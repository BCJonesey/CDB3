var React = require('react');
var Currency = require('./Currency');


class CharacterDetails extends React.Component {

    componentWillMount(){
        window.ben = this.props
    }

    _currencies(){
        if(this.props.character.currency_totals === undefined){
            return
        }
        return Object.keys(this.props.character.currency_totals).map( (currencyId) => {
            return(
            <Currency key={currencyId} shortName={currencyId} spent={this.props.currencySpend[currencyId]} earned={this.props.character.currency_totals[currencyId]} />
            )
        } )
    }
  render() {
    return (
      <div className='container'>
          <div className='row'>
              <div className='col'>{this.props.character.name}</div>
              </div>
              <div className='row'>
              {this._currencies()}
              </div>
      </div>
    )
  }

  
}

module.exports = CharacterDetails;