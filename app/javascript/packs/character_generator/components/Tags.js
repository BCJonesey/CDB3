var React = require('react');


class Tags extends React.Component {

 

  render() {
    if(this.props.tags==undefined || this.props.tags.length == 0){
      return null
    }
    return (
        <div className="container">
            {this.props.tags.map( (tag) => {return(<a key={tag.id} href="#" className="badge badge-primary">{tag.name}</a>)})}
        </div>
    )
  }


  
}

module.exports = Tags;