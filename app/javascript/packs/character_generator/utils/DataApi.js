
var Fetch = require('whatwg-fetch');

class DataApi{
    
    constructor(gameUrl, characterId) {
        this.gameUrl = gameUrl;
        this.characterId = characterId;
    }
    getSkills(successCallBack){

        fetch(`${this.gameUrl}/characters/${this.characterId}/skills.json`,{
            credentials: 'same-origin'
          })
        .then(function(response) {
          return response.json()
        }).then(function(json) {
            successCallBack(json);
          console.log('parsed json', json);
        }).catch(function(ex) {
          console.log('parsing failed', ex)
        })


    }

    getUrl(){
        return this.gameUrl
    }



}

module.exports = DataApi;