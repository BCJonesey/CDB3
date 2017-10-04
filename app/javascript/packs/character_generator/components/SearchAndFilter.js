var React = require('react');
var Tags = require('./Tags');
var {DebounceInput} = require('react-debounce-input');

class SearchAndFilter extends React.Component {

 
  
  render() {
    return (
      <div className='container'>
        <div className="row">
          <DebounceInput onChange={event => this.props.seachTextUpdated(event.target.value)} element="input" type="search" className="form-control ds-input" id="search-input" placeholder="Search..." aria-label="Search for..." spellCheck="false" role="combobox" aria-autocomplete="list" aria-expanded="false" aria-labelledby="search-input"/>
        </div>
        <div className="row">
          <Tags tags={this.props.selectedTags} onTagSelected={this.props.onTagUnselected.bind(this)} />
        </div>
      </div>
    )
  }

  
}

module.exports = SearchAndFilter;



