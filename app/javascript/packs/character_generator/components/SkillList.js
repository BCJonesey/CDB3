var React = require('react');
var Skill = require('./Skill');
var SearchAndFilter = require('./SearchAndFilter');

class SkillList extends React.Component {

    constructor(props) {
      super(props);
      this.state = {
        selectedTags: [],
        searchText: ""
      }
    }

    _getValidSkills() {
      const checkTags = this.state.selectedTags.length > 0
      const selectedTags = this.state.selectedTags.map(function (tag) {
        return tag.id
      });
      const checkSearch = this.state.searchText.length > 0
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
          if (!(skill.name.toLowerCase().includes(this.state.searchText))) {
            return false
          }
        }

        return true;
      });
    }



    _onTagSelected(tag) {
      if (this.state.selectedTags.filter(obj => obj.id == tag.id).length == 0) {
        this.setState({
          selectedTags: this.state.selectedTags.concat(tag)
        });
      }

    }

    _onTagUnselected(tag) {
      this.setState({
        selectedTags: this.state.selectedTags.filter(obj => obj.id != tag.id)
      });
    }

    _seachTextUpdated(newText) {
      this.setState({
        searchText: newText.toLowerCase()
      });
    }


    render() {
        return ( <div className = "container" >
            <div className = "row" >
            <SearchAndFilter selectedTags = {
              this.state.selectedTags
            }
            onTagUnselected = {
              this._onTagUnselected.bind(this)
            }
            seachTextUpdated = {
              this._seachTextUpdated.bind(this)
            }
            /> 
            </div> 
            <div className = "row" >
            <div className = "container" > {
              this._getValidSkills().map((skill) => {
                  return ( < Skill rankChangeHandler = {
                      this.props.rankChangeHandler.bind(this)
                    }
                    skill = {
                      skill
                    }
                    key = {
                      skill.id
                    }
                    onTagSelected = {
                      this._onTagSelected.bind(this)
                    }
                    />)} )} 
              </div> 
              </div> 
              </div>
    )
  }
}

module.exports = SkillList;