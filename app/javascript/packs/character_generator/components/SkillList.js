var React = require('react');
var Skill = require('./Skill');

class SkillList extends React.Component {

    

    _getValidSkills() {
      const checkTags = this.props.selectedTags.length > 0
      const selectedTags = this.props.selectedTags.map(function (tag) {
        return tag.id
      });
      const checkSearch = this.props.searchText.length > 0
      const searchText = this.props.searchText.toLowerCase()
      return this.props.skills.filter((skill) => {


        if (checkTags) {
          if (skill.skill_tags.length == 0) {
            return false;
          } else {
            const tags = skill.skill_tags.map(function (skill_tag) {
              return skill_tag.tag.id
            });
            for(i in selectedTags){
              if(tags.indexOf(selectedTags[i]) == -1){
                return false
              }
            }
          }
        }
        if (checkSearch) {
          if (!(skill.name.toLowerCase().includes(searchText))) {
            return false
          }
        }

        return true;
      });
    }



  

    render() {
        return ( <div className = "container" >
          <div className = "row">
            <div className = "col-md-2" >
            
            </div> 
            <div className = "col-md-8" >
            <div className = "container" > {
              this._getValidSkills().map((skill) => {
                  return ( < Skill 
                    rankChangeHandler = {this.props.rankChangeHandler.bind(this)}
                    skill = {skill}
                    key = {skill.id}
                    rank={this.props.skillRanks[skill.id]}
                    onTagSelected = {this.props.onTagSelected.bind(this)}
                    />)} )} 
              </div> 
              </div> 
              </div>
              </div>
    )
  }
}

module.exports = SkillList;