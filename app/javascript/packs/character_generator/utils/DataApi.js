
var Fetch = require('whatwg-fetch');

class DataApi{
    
    constructor(gameUrl, characterId) {
        this.gameUrl = gameUrl;
        this.characterId = characterId;
    }
    getSkillData(successCallBack){

        fetch(`${this.gameUrl}/characters/${this.characterId}/skills.json`,{
            credentials: 'same-origin'
          }).then(function(response) {
          return response.json()
        }).then(function(json) {
            successCallBack(json);
        }).catch(function(ex) {
          console.log('parsing failed', ex)
        })


    }

    getCharacterData(successCallBack){
        fetch(`${this.gameUrl}/characters/${this.characterId}.json`,{
            credentials: 'same-origin'
          }).then(function(response) {
          return response.json()
        }).then(function(json) {
            successCallBack(json);
        }).catch(function(ex) {
          console.log('parsing failed', ex)
        })
    }

 
    updateSkillRank(skillId, newRank, failureCallBack){
        fetch(`${this.gameUrl}/characters/${this.characterId}/skills/${skillId}.json`, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json'
            },
            credentials: 'same-origin',
            body: JSON.stringify({
                character_skill: {
                    rank: newRank
                }
            })
        }).then(function(response) {
            if (response.status >= 200 && response.status < 300) {
                return response
            } else {
                var error = new Error(response.statusText)
                error.response = response
                throw error
            }
        }).catch(function(ex) {
            failureCallBack(ex);
        })
    }

    getUrl(){
        return this.gameUrl
    }



}

module.exports = DataApi;