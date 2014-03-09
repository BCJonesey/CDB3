

var LT = {};

LT.printer = {};

LT.cache = {};

LT.printer.spend = function(options, cost, currency){
	return cost + currency;
};

LT.clearCache = function(){
	LT.cache = {};
};

LT.loadCache = function($scope){
	LT.cache.currencies = {};
	for (var curr in $scope.currencies)
	{
		LT.cache.currencies[$scope.currencies[curr].shortname] = $scope.currencies[curr].total;
	}
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
	LT.cache.skills = $scope.skills;
	LT.cache.skillsToValidate = _.filter($scope.skills,function(skill){return skill.rank>0});
	_.each(LT.cache.skillsToValidate,LT.evalSpend);
	

	var errorBody = "";
	// check to see if there is an enough currency
	for (var curr in $scope.currencies)
	{
		if(LT.cache.currencies[$scope.currencies[curr].shortname] < 0)
		{
			errorBody += "<li>You do not have enough " + $scope.currencies[curr].shortname + "</li>"
		}
	}
	if(errorBody.length == 0){
		LT.updateScope($scope);
	}
	else{
		options.skill.skill.rank = options.skill.prevRank;
		LT.showModal("Validation Error","<ul>" + errorBody + "</ul>");
	}


};

LT.evalSpend = function(skill){
	if(skill.cost.length > 0){
		var options = {skill_rank: skill.rank};
		eval(skill.cost);
	}
};

LT.spend = function(options, cost, currency){
	if(LT.cache.currencies[currency] === undefined){
		LT.cache.currencies[currency] = 0;
	}
	LT.cache.currencies[currency] = LT.cache.currencies[currency] - (cost * options["skill_rank"]);
};

LT.showModal = function(title,body){
	$('#more-info-modal #myModalLabel').text(title);
	$('#more-info-modal .modal-body').html(body);
	$('#more-info-modal').modal();
}
