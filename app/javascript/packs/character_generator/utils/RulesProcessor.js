var LangUtils = require('./LangUtils');


class RulesProcessor {



    static getCostString(skill) {
        var options = {};
        const LN = {
            spend: function (options, cost, currency) {
                return cost + currency;
            }
        }
        if (skill.cost == "") {
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
    static evalRulesAndSpend(skills, evalOptions = {}) {

        // Build out placeholder for result
        result = {
            currencySpend: {},
            errorMessages: [],
            sideEffects: {}
        }

        var grantedTags = {}

        // fuck you scope, ill figure it out later
        skillRanks = Object.assign({}, evalOptions.skillRanks);
        
        if (evalOptions.skillToUpdate != undefined) {
            if(evalOptions.newRank == 0){
                delete skillRanks[evalOptions.skillToUpdate.id]
            }else{
                skillRanks[evalOptions.skillToUpdate.id] = evalOptions.newRank
            }
        }

     

        

        
        currencySpend = {};

        const LN = RulesHelpers.jsToolkit();


        // Loop thru each skill to apply it's granted tags, spend, and side effects to the current state copy
        for (skillId in skillRanks) {

            const skill = skills[skillId]
            const rank = skillRanks[skillId]

            if (rank > 0) {
                skill.skill_tags.filter((skill_tag) => {return skill_tag.gives}).forEach((skillTag)=>{grantedTags[skillTag.tag.id] = skillTag.tag})
                if (skill.cost.length > 0) {
                    var options = {
                        skillRank: rank
                    };
                    try {
                        eval(skill.cost);
                    } catch (e) {
                        result.errorMessages.push(`${skill.name} had an error in the cost, please screenshot this and send it to your GM:  ${e.message}`)
                    }
                }
                if (skill.side_effects != null && skill.side_effects.length > 0) {
                    var options = {
                        skillRank: rank
                    };
                    try {
                        eval(skill.side_effects);
                    } catch (e) {
                        result.errorMessages.push(`${skill.name} had an error in the side effects, please screenshot this and send it to your GM:  ${e.message}`)
                    }
                }
            }
        }

        if(evalOptions.currencyTotals != undefined){
            // make a copy of currencies so we dont fuck with other people's shit
            for(currency in result.currencySpend){
                if(evalOptions.currencyTotals[currency] == undefined || (evalOptions.currencyTotals[currency]-result.currencySpend[currency] < 0)){
                    result.errorMessages.push(`You don't have enough ${currency} to afford that.`)
                }
            }
        }

        // Loop thru each skill to evaluate it's rules
        for (skillId in skillRanks) {
            
            const skill = skills[skillId]
            const rank = skillRanks[skillId]

            if (rank > 0) {
                if (rank > skill.max_rank) {
                    result.errorMessages.push(`You do not meet the requirements for ${skill.name}`);
                } else if(skill.cost.length > 0) {
                    try {
                        const options = {
                            skillRank: rank
                        };
                        if (eval(skill.rule) == false) {
                            result.errorMessages.push(`You do not meet the requirements for ${skill.name}`);
                        }
                    } catch (e) {
                        result.errorMessages.push(`${skill.name} had an error in the rule, please screenshot this and send it to your GM:  ${e.message}`)
                    }


                }
            }
        }
        result.grantedTags = Object.values(grantedTags)
        result.skillRanks = skillRanks;
        return result;

    }

}

module.exports = RulesProcessor;

class RulesHelpers {
    static jsToolkit() {
        return {
            spend: RulesHelpers._spend,
            skillRank: RulesHelpers._skillRank,
            sideEffects: {
                add: RulesHelpers._addSideEffectScalar
            }
        }
    }

    static _spend(options, cost, currency) {
        if (result.currencySpend[currency] === undefined) {
            result.currencySpend[currency] = 0;
        }
        result.currencySpend[currency] = result.currencySpend[currency] + (cost * options.skillRank);
    }

    static _skillRank = function (options, skill_id) {

        if (skillRanks[skill_id] === undefined) {
            return 0;
        }
        return skillRanks[skill_id];
    }

    static _addSideEffectScalar(options, attributeName, amount) {
        if (result.sideEffects[attributeName] === undefined) {
            result.sideEffects[attributeName] = 0;
        }
        result.sideEffects[attributeName] = result.sideEffects[attributeName] + amount;
    }



}