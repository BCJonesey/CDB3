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
              <h2 className="mx-auto">{this.props.character.name}</h2>
          </div>
      </div>
    )
  }

  
}

module.exports = CharacterDetails;