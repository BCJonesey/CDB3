var React = require('react');
var DataApi = require('../utils/DataApi');


class CharacterEditor extends React.Component {

  constructor(props){
    super(props);
    this.dataApi = new DataApi(this.props.gameUrl, this.props.characterId);
    this.state = {
      skills: [],
      name: "",

    }
  }


  render() {
    return (
      <p>Not Found! {this.dataApi.getUrl()}</p>  
    )
  }
}

module.exports = CharacterEditor;