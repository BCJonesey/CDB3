var LangUtils = require('./LangUtils');


class RulesProcessor{

    
    
    static getCostString(skill){
        var options = {};
        const LN = {
            spend: function(options, cost, currency){return cost + currency;}
        }
        if(skill.cost==""){
            return "free";
        }
        return eval(skill.cost);

    }


    // Returns:
    // {
    //  currencySpend:{"currency": spend_amount}
    //  errorMessages: ["its crap", "you are too poor"]
    // }
    // Order of operations:
    // Run all spend analysis
    // Evaluate all rules
    static evalRulesAndSpend(skrills, currencies_original, idToAdd){
        // Build out placeholder for result
        result = {
            currencySpend:{},
            errorMessages: []
        }

        // fuck you scope, ill figure it out later
        skills = LangUtils.deepCopy(skrills);

        if(idToAdd != undefined){
            skills[idToAdd].rank = 1
        }

        

        // make a copy of currencies so we dont fuck with other people's shit
        currencies = LangUtils.deepCopy(currencies_original);
        currencySpend = {};
        
        const LN = RulesHelpers.jsTollkit();

        // Loop thru each skill to apply it's spend to the current state copy
        for(skillId in skills){
            var skill = skills[skillId]
            if(skill.cost.length > 0){
                var options = {skillRank: skill.rank};
                eval(skill.cost);
            }
        }

        // Loop thru each skill to evaluate it's rules
        for(skillId in skills){
            var skill = skills[skillId]
            
            if(skill.rank > 0){
                var options = {skillRank: skill.rank};
                if(skill.rank > skill.max_rank || (eval(skill.rule) === false))
                {
                    result.errorMessages.push( `You do not meet the requirements for ${skill.name}` )
                }
            }
        }
        return result;

    }

}

module.exports = RulesProcessor;

class RulesHelpers{
    static jsTollkit(){
        return {
            spend: RulesHelpers._spend,
            skillRank: RulesHelpers._skillRank
        }
    }

    static _spend(options, cost, currency){
        if(result.currencySpend[currency] === undefined){
            result.currencySpend[currency] = 0;
        }
        result.currencySpend[currency] = result.currencySpend[currency] + (cost * options.skillRank);
    }

    static _skillRank = function(options, skill_id){

        if(skills[skill_id] === undefined){
            return 0;
        }
        return skills[skill_id].rank;
    }

}


