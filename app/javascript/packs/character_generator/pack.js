
var React = require('react');
var ReactDOM = require('react-dom');
var CharacterEditor = require('./components/CharacterEditor');
var Promise = require('promise-polyfill');



// To add to window
if (!window.Promise) {
  window.Promise = Promise;
}

var element = document.getElementById('character-generator')
var gameUrl = element.attributes["gameUrl"].value
var characterId = element.attributes["characterId"].value

ReactDOM.render(
  <CharacterEditor gameUrl={gameUrl} characterId={characterId} />,
  element
);