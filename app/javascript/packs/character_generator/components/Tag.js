var React = require('react');


class Tag extends React.Component {

   _onClick(){
    this.props.onTagSelected(this.props.tag)
   }

  _className(){
    const iconName = this.props.action == "remove" ? "times" : "plus"
    return "fa fa-" + iconName + "-circle";
  }

  render() {
    return (
        <a href="#" onClick={this._onClick.bind(this)} className="badge badge-primary skill-tag">
        {this.props.tag.name}
        <i className={this._className()} aria-hidden="true"></i>
        </a>
       
    )
  }


  
}

module.exports = Tag;