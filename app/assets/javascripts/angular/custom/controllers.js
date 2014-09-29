


var chareditControllers = angular.module('chareditControllers', ['restangular']);


chareditControllers.controller('SkillListCrl', ['$scope','Restangular',
  function($scope, Restangular) {

  	$scope.skills = Restangular.all('skills').getList().$object;
    $scope.filterTags = [];

    $scope.givenTags = function(){
      var allSkillTags = [];
      _.forEach(_.filter($scope.skills,function(skill){return skill.rank>0}),function(skill){allSkillTags.concat(skill.skill_tags)});


    }

    $scope.initCurrencies = function(currencies){
      var retVal = [];
      for (var cur in currencies)
      {
        var newCur = {};
        newCur.shortname = cur;
        newCur.total = currencies[cur];
        newCur.remaining = currencies[cur];
        retVal.push(newCur);
      }
      return retVal;
    }
    $scope.addRank = function(skill) {
      var options = {skill: {prevRank:skill.rank,skill: skill}};
      skill.rank++;
      $scope.validate(options);
    };
    $scope.subtractRank = function(skill) {
      var options = {skill: {prevRank:skill.rank,skill: skill}};
      skill.rank--;
      $scope.validate(options);
    };

    $scope.validate = function(options){
      if(LT.validate(options,$scope)){
        $scope.save(options.skill.skill);
      }
    };

    $scope.save = function(skill){
    	skill.put();
    };

    $scope.getCost = function(skill){
      var options = {};
      if(skill.cost==""){
        return "free";
      }
    	return eval(skill.cost.replace("LT.","LT.printer."));
    };

    $scope.tagFilter = function(skill){

      return $scope.filterTags.length==0 || $scope.filterTags.length == _.reduce(skill.skill_tags, function(memo, skill_tag){ return memo + _.where($scope.filterTags, {id: skill_tag.tag.id}).length ; }, 0); ;
    }

    $scope.showModal = function(skill){
      LT.showModal(skill.name,skill.description);
    };
    $scope.tagClick = function(tag){
      if(_.where($scope.filterTags, {id: tag.id}).length == 0){
        $scope.filterTags.push(tag);
      }
    };
    $scope.tagUnClick = function(tag){
      $scope.filterTags = _.filter($scope.filterTags, function(ftag){ return ftag.id != tag.id; });
    };
    $scope.currencies = $scope.initCurrencies(myCurrencies);
  }]);
