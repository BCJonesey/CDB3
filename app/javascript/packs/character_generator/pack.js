
var React = require('react');
var ReactDOM = require('react-dom');
var CharacterApp = require('./components/CharacterApp');
var Promise = require('promise-polyfill');



// To add to window
if (!window.Promise) {
  window.Promise = Promise;
}

const element = document.getElementById('character-app')
const gameUrl = element.attributes["gameUrl"].value
const characterId = element.attributes["characterId"].value
const isViewOnly = element.attributes["isViewOnly"].value == "true"

ReactDOM.render(
  <CharacterApp gameUrl={gameUrl} characterId={characterId} isViewOnly={isViewOnly} />,
  element
);