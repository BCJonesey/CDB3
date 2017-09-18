

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


     

LT.spend = function(options, cost, currency){
	if(LT.cache.currencies[currency] === undefined){
		LT.cache.currencies[currency] = 0;
	}
	LT.cache.currencies[currency] = LT.cache.currencies[currency] - (cost * options["skill_rank"]);
};




