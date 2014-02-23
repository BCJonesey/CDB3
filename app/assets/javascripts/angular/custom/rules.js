

var LT = {};

LT.printer = {};

LT.printer.spend = function(cost, currency){
	return cost + currency
};

LT.clearCache = function(){
	LT.cache = {};
	LT.cache.currencies = {};
}

LT.validate = function($scope){
	LT.clearCache();
	LT.cache.skills = $scope.skills;
	LT.cache.skillsToValidate = _.filter($scope.skills,function(skill){return skill.rank>0});
	_.each(LT.cache.skillsToValidate,LT.evalSpend);
};

LT.evalSpend = function(skill){
	if(skill.cost.length > 0){
		eval(skill.cost);
	}
};

LT.spend = function(cost, currency){
	if(LT.cache.currencies[currency] === undefined){
		LT.cache.currencies[currency] = 0;
	}
	LT.cache.currencies[currency] = LT.cache.currencies[currency] - cost
};
