

var LT = {};

LT.printer = {};

LT.cache = {};

LT.printer.spend = function(options, cost, currency){
	return cost + currency;
};

LT.clearCache = function(){
	LT.cache = {};
	LT.cache.errors = ""
};

LT.loadCache = function($scope){
	LT.cache.skills = $scope.skills.slice(0);
	LT.cache.skillsToValidate = _.filter(LT.cache.skills,function(skill){return skill.rank>0});
	LT.cache.currencies = {};
	for (var curr in $scope.currencies)
	{
		LT.cache.currencies[$scope.currencies[curr].shortname] = $scope.currencies[curr].total;
	}
	LT.cache.calculations = {};
	LT.cache.calculations.rank = {};
	LT.cache.calculations.spent = {};
};

LT.updateScope = function($scope){
	for (var curr in $scope.currencies)
	{
		$scope.currencies[curr].remaining = LT.cache.currencies[$scope.currencies[curr].shortname];
	}
}

LT.validate = function(options,$scope){
	LT.clearCache();
	LT.loadCache($scope);
	_.each(LT.cache.skillsToValidate,LT.evalSpend);
	_.each(LT.cache.skillsToValidate,LT.evalRule);

	// check to see if there is an enough currency
	for (var curr in $scope.currencies)
	{
		if(LT.cache.currencies[$scope.currencies[curr].shortname] < 0)
		{
			LT.cache.errors += "<li>You do not have enough " + $scope.currencies[curr].shortname + "</li>";
		}
	}
	if(LT.cache.errors.length == 0){
		LT.updateScope($scope);
		return true;
	}
	else{
		options.skill.skill.rank = options.skill.prevRank;
		LT.showModal("Validation Error","<ul>" + LT.cache.errors + "</ul>");
	}


};

LT.evalSpend = function(skill){
	if(skill.cost.length > 0){
		var options = {skill_rank: skill.rank};
		var originalSpendOut = _.extend({}, LT.cache.currencies);
		eval(skill.cost);
		LT.cache.calculations.spent[skill.id] = {};
		_.each(LT.cache.currencies,function (value,index){
			LT.cache.calculations.spent[skill.id][index] = originalSpendOut[index] - LT.cache.currencies[index];
		});
	}
};


LT.evalRule = function(skill){
	if(skill.rule.length > 0){
		var options = {skill_rank: skill.rank};
		if(!eval(skill.rule))
		{
			LT.cache.errors += "<li>You do not meet the requirements for " + skill.name + "</li>";
		}
	}
};

LT.spend = function(options, cost, currency){
	if(LT.cache.currencies[currency] === undefined){
		LT.cache.currencies[currency] = 0;
	}
	LT.cache.currencies[currency] = LT.cache.currencies[currency] - (cost * options["skill_rank"]);
};

LT.skill_rank = function(options, skill_id){
	if(LT.cache.calculations.rank[skill_id] === undefined){
		LT.cache.calculations.rank[skill_id] = _.find(LT.cache.skills, function(skill){ return skill.id == skill_id; }).rank;
	}
	return LT.cache.calculations.rank[skill_id];
};

LT.currencySpentInTags = function(options, tags, currency){
	var skillz = _.filter(LT.cache.skillsToValidate, function (skill){return _.intersection(tags,_.map(skill.skill_tags, function(skill_tag){return skill_tag.tag.id})).length > 0;})
	var sum = _.reduce(skillz, function(sum, skill) {
		if(LT.cache.calculations.spent[skill.id]){
	  	sum = sum + LT.cache.calculations.spent[skill.id][currency];
		}
		return sum;
	},0);
	return sum;

};

LT.showModal = function(title,body){
	$('#more-info-modal #myModalLabel').text(title);
	$('#more-info-modal .modal-body').html(body);
	$('#more-info-modal').modal();
}
