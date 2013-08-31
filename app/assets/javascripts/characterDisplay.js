var Skill = Backbone.Model.extend({urlRoot: function(){return consts.game_url+'/skills'},
getCharSkill: function(){
		var retCharSkill = charSkills.findWhere({skill_id:this.get("id")})
		if(typeof retCharSkill === 'undefined'){
			retCharSkill = new CharSkill({skill_id: this.get("id")});
			charSkills.add(retCharSkill);
		}
		return retCharSkill;
	}
});
var SkillView = Backbone.View.extend({
	initialize: function(){
		this.model.on('change', this.render, this);
		this.model.on('destroy', this.remove, this);
	},
	render: function(){
		var charSkillView = new CharSkillView({model: this.model.getCharSkill()});
		charSkillView.render();
		var html = "<div class='skill-controls'></div>" + "<div class='skill-info'>"+ 
		"	<span class='skill-info-cost'>13CP</span>"+
		"	<span class='skill-info-name'>"+this.model.get("name")+"</span>"+
		"	<span class='skill-info-shortDescription'>"+this.model.get("summary")+"</span>"+
		"	<span class='skill-info-moreInfo'>"+
		"   <a href='#skill_"+this.model.get("id")+"_modal'  data-toggle='modal'><i class='icon-info-sign'></i></a></span>"+
		"</div>"+
		"<div class='skill-tags'>";
		for(var tag in this.model.get("tags")) { 
			html += "<a href='#' tagId='"+this.model.get("tags")[tag].id+"' class='label tagLink'>"+this.model.get("tags")[tag].name+"</a>";
        }
		html += "</div>";
		
		html += "<div id='skill_"+this.model.get("id")+"_modal' class='modal hide fade' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>"+
				"  <div class='modal-header'>"+
				"    <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>X</button>"+
				"    <h3 id='myModalLabel'>"+this.model.get("name")+"</h3>"+
				"  </div>"+
				"  <div class='modal-body'>"+
				"    <p>"+this.model.get("description")+"</p>"+
				"  </div>"+
				"  <div class='modal-footer'>"+
				"    <button class='btn' data-dismiss='modal' aria-hidden='true'>Close</button>"+
				"  </div>"+
				"</div>";
		return this.$el.html(html).find(".skill-controls").append(charSkillView.el);
	},
	remove: function(){
		this.$el.remove();
	}
});
var Skills = Backbone.Collection.extend({model: Skill, url: function(){return consts.game_url+'/skills'}});
var SkillsView = Backbone.View.extend({
	addOne: function(skill){
		if(skill.get("name").toLowerCase().indexOf($( "#search" ).val().toLowerCase()) != -1){
			var skillView = new SkillView({model: skill});
			skillView.render();
			this.$el.append(skillView.el);
		}
	},
	addAll: function(){
		if(typeof charSkills !== 'undefined'){
		this.collection.forEach(this.addOne, this);
		}
	},
	render: function(){
		this.addAll();
	}
});
var skills = new Skills();
var skillsView = new SkillsView({collection: skills});
skills.fetch();
var Tag  = Backbone.Model.extend({urlRoot: function(){return consts.game_url+'/tags'},defaults: {selected: false}});
var Tags = Backbone.Collection.extend({model: Tag, url: function(){return consts.game_url+'/tags'}});
var tags = new Tags();
tags.fetch();
var CharSkill = Backbone.Model.extend({urlRoot: function(){return consts.game_url+'/character_skills'},
	defaults: function(){
		return {
			character_version_id: character.attributes.character_version.id,
			rank: 0
			}
	},
	changeRank: function(newRank){
		var oldRank = this.get("rank");
		this.set("rank",newRank);
		if(is_valid_character()){
			this.save();
		}
		else{
			this.set("rank",oldRank);
		}
	}
	});  
var CharSkillView  = Backbone.View.extend({
	tagName: 'span',
	className: 'skill-controls-span',
	events: {
	'change input': 'changeRank'
	},
	changeRank: function(){
		$(".skill-controls-span input").attr("disabled", "disabled");
		this.model.changeRank(this.$el.find('input').first().val());
		$(".skill-controls-span input").removeAttr("disabled");
	},
	initialize: function(){
		this.model.on('change', this.render, this);
		this.model.on('destroy', this.remove, this);
	},
	render: function(){
		var html = "<input type='number' max='40' value='"+this.model.get("rank")+"'/>";
		return this.$el.html(html);
	},
	remove: function(){
		this.$el.remove();
	}
});
var CharSkills= Backbone.Collection.extend({model: CharSkill, url: function(){return consts.game_url+'/character_skills'}});;
var charSkills; 
var Character  = Backbone.Model.extend({urlRoot: function(){return consts.game_url+'/characters'},initialize:function(){this.once("sync",setUpCharSkills)}});
var character;
var CharacterView = Backbone.View.extend({
	events: {
	'change input#character_name': 'updateChar'
	},
	updateChar: function(){
		this.model.set("name",this.$el.find('input#character_name').first().val());		
		this.model.save();
	},
	initialize: function(){
		this.model.on('change', this.render, this);
	},
	render: function(){
		var html = '<input class="text_field" id="character_name" name="character[name]" size="30" type="text" value="'+this.model.get("name")+'">';
		return this.$el.html(html);
	},
	remove: function(){
		this.$el.remove();
	}
});
var characterView;
var setUpCharSkills= function(){
	charSkills = new CharSkills();
	charSkills.on("reset",renderUI);
	charSkills.reset(typeof character.attributes.character_version === 'undefined' ? {} : character.attributes.character_version.character_skills);
}


var renderUI = function(){
	skillsView.render();
	$('#skillList').html(skillsView.el);
	$( ".tagLink" ).click(tagClicked);
};

var tagClicked = function(){
	tags.get(this.attributes["tagId"].value).set("selected",true);

};


$(function(){
$( "#search" ).keyup(function() {
	skillsView = new SkillsView({collection: skills});
	renderUI();
});

character= new Character({id:consts.charId});
characterView = new CharacterView({model:character});
characterView.render();
$('#characteInfo').html(characterView.el);
character.fetch();

})
