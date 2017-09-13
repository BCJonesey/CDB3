
class DataApi{
    
    constructor(gameUrl, characterId) {
        this.gameUrl = gameUrl;
        this.characterId = characterId;
    }
    getSkills(successCallBack){
        $.ajax({
            url: `${game_url}`,
            data: data,
            success: success,
            dataType: dataType
          });
    }

    getUrl(){
        return this.gameUrl
    }



}

module.exports = DataApi;