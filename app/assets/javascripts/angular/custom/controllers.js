


var chareditControllers = angular.module('chareditControllers', ['restangular']);


chareditControllers.controller('SkillListCrl', ['$scope','Restangular',
  function($scope, Restangular) {

  	$scope.skills = Restangular.all('skills').getList().$object;
    $scope.filterTags = [];
    
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
      skill.rank++;
      $scope.validate();
      $scope.save(skill);
    };
    $scope.subtractRank = function(skill) {
      skill.rank--;
      $scope.validate();
      $scope.save(skill);
    };
    
    $scope.validate = function(){
      return LT.validate($scope);
    };

    $scope.save = function(skill){
    	skill.put();
    };

    $scope.getCost = function(skill){
    	return eval(skill.cost.replace("LT.","LT.printer."));
    };

    $scope.tagFilter = function(skill){

      return $scope.filterTags.length==0 || $scope.filterTags.length == _.reduce(skill.skill_tags, function(memo, skill_tag){ return memo + _.where($scope.filterTags, {id: skill_tag.tag.id}).length ; }, 0); ;
    }

    $scope.showModal = function(skill){
    	$('#more-info-modal #myModalLabel').text(skill.name);
    	$('#more-info-modal .modal-body').html(skill.description);
    	$('#more-info-modal').modal();
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
