

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
	LT.cache.skills = $scope.skills;
	LT.cache.skillsToValidate = _.filter($scope.skills,function(skill){return skill.rank>0});
	LT.cache.currencies = {};
	for (var curr in $scope.currencies)
	{
		LT.cache.currencies[$scope.currencies[curr].shortname] = $scope.currencies[curr].total;
	}
	LT.cache.calculations = {};
	LT.cache.calculations.rank = {};
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
	}
	else{
		options.skill.skill.rank = options.skill.prevRank;
		LT.showModal("Validation Error","<ul>" + LT.cache.errors + "</ul>");
	}


};

LT.evalSpend = function(skill){
	if(skill.cost.length > 0){
		var options = {skill_rank: skill.rank};
		eval(skill.cost);
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

LT.showModal = function(title,body){
	$('#more-info-modal #myModalLabel').text(title);
	$('#more-info-modal .modal-body').html(body);
	$('#more-info-modal').modal();
}
