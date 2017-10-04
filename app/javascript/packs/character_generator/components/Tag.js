var React = require('react');


class Tag extends React.Component {

   _onClick(){
    this.props.onTagSelected(this.props.tag)
   }

  render() {
    return (
        <a href="#" onClick={this._onClick.bind(this)} className="badge badge-primary">{this.props.tag.name}</a>
       
    )
  }


  
}

module.exports = Tag;