var React = require('react');
var Tag = require('./Tag');

class Tags extends React.Component {

 

  render() {
    if(this.props.tags==undefined || this.props.tags.length == 0){
      return null
    }
    return (
        <div className="container">
            {this.props.tags.map( (tag) => {return(<Tag key={tag.id} tag={tag} action={this.props.action} onTagSelected={this.props.onTagSelected.bind(this)} />)})}
        </div>
    )
  }


  
}

module.exports = Tags;