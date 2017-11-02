var React = require('react');
var ADCharacterSheet = require('./characterSheets/AD/ADCharacterSheet')

class CharacterSheet extends React.Component {
  render() {
    return (
        <ADCharacterSheet sheetProps={this.props} />
    );
  }
}

module.exports = CharacterSheet;