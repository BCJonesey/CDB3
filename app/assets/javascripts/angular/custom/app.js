var chareditApp = angular.module('chareditApp', [  
	'chareditControllers', 'restangular']).
  config(function(RestangularProvider) {


RestangularProvider.setBaseUrl(skillsUrl);





});