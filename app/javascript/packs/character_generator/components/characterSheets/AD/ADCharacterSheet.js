var React = require('react');
var SkillGroup = require('./SkillGroup')
var Traits = require('./Traits')
var Attribute = require('./Attribute')

class ADCharacterSheet extends React.Component {


  constructor(props) {
    super(props);
    this.nonSkillTags = ["Attributes", "Tarots", "Humors", "Hobby"];
    this.nonPasiveTags = ["Loam","Brine","Sulphur","Ether", "Salt"].concat(this.nonSkillTags);
  }

  _getStat(statName){
    const val = this.props.sheetProps.sideEffects.stats[statName]
    if(val == undefined){
      return 0
    }else{
      return val
    }
  }

  _getSkillsForTag(selectTag, activeOnly = true){
    return this.props.sheetProps.skills.filter((skill) => {
      const tagList = skill.skill_tags.map((skill_tag) => {return skill_tag.tag.name;});
      if(activeOnly){
        for(i in this.nonSkillTags){
          if(tagList.indexOf(this.nonSkillTags[i]) > -1){
            return false
          }
        }
      }
      if(tagList.indexOf(selectTag) > -1){
        return true;
      }
      return false;
    })
  }

  _getPassiveSkills(){
    return this.props.sheetProps.skills.filter((skill) => {
      const tagList = skill.skill_tags.map((skill_tag) => {return skill_tag.tag.name;});
      for(i in this.nonPasiveTags){
        if(tagList.indexOf(this.nonPasiveTags[i]) > -1){
          return false;
        }
      }
      return true;
    })
  }

  render() {
    return (
      <div className="container ADCharacterSheet">
        <div className='row game-name'>
          <div className="col">
            <div>After Dark</div>
          </div>
        </div>
        <div className='row character-name'>
          <div className="col">
            <div>{this.props.sheetProps.character.name}</div>
          </div>
        </div>
        <div className='row'>
          <Attribute label="Player" value="" />
          <Attribute label="D/I" value="" />
          <Attribute label="Humanity" value={this._getStat("Humanity")} />
        </div>
        <div className='row'>
          <Attribute label="Darkness" value={this._getStat("Darkness")} />
          <Attribute label="Vitality" value={this._getStat("Vitality")} />
          <Attribute label="Armor" value={this._getStat("Armor")} />
        </div>
        <Traits traits={this.props.sheetProps.sideEffects.traits}/>
        <div className='row section-header'>
          <div className="col">
            <h3 className="title-divider"><span>Affinity</span></h3>
          </div>
        </div>
        <div className='row'>
          <div className="col">
            <div className="row">
              {this._getSkillsForTag("Humors", false).map((skill) => {return ( <div className="col" key={skill.id}>{skill.name}</div>)} )}
              {this._getSkillsForTag("Tarots", false).map((skill) => {return ( <div className="col" key={skill.id}>{skill.name}</div>)} )} 
            </div>
            <div className="row">
              {this._getSkillsForTag("Hobby", false).map((skill) => {return ( <div className="col" key={skill.id}>{skill.name}</div>)} )}
            </div>
          </div>
        </div>
        <div className='row'>
          <div className="col">
            <h3 className="title-divider"><span>Power</span></h3>
          </div>
        </div>
        <div className='row'>
          <Attribute label="Salt" value={this._getStat("Salt")} />
          <Attribute label="Loam" value={this._getStat("Loam")} />
          <Attribute label="Brine" value={this._getStat("Brine")} />
          <Attribute label="Sulphur" value={this._getStat("Sulphur")} />
          <Attribute label="Ether" value={this._getStat("Ether")} />
        </div>
        <div className='row'>
          <SkillGroup title="Salt" skills={this._getSkillsForTag("Salt")} />
        </div>
        <div className='row'>
          <SkillGroup title="Loam" skills={this._getSkillsForTag("Loam")} />
        </div>
        <div className='row'>
          <SkillGroup title="Brine" skills={this._getSkillsForTag("Brine")} />
        </div>
        <div className='row'>
          <SkillGroup title="Sulphur" skills={this._getSkillsForTag("Sulphur")} />
        </div>
        <div className='row'>
          <SkillGroup title="Ether" skills={this._getSkillsForTag("Ether")} />
        </div>
        <div className='row'>
          <SkillGroup title="Pasive" skills={this._getPassiveSkills()} />
        </div>
      </div>
    );
  }
  
}

module.exports = ADCharacterSheet;