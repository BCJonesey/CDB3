var LangUtils = require('./LangUtils');


class RulesProcessor {



    static getCostString(skillId, costOptions) {
        // fuck you scope, ill figure it out later
        skillRanks = Object.assign({}, costOptions.skillRanks);
        result = costOptions.characterState
        var options = {
            skillRank: costOptions.skillRanks[skillId]|| 0,
            forDisplay: true
        };
        const skill = costOptions.skills[skillId];
        LN = RulesHelpers.jsToolkit();
        
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
            sideEffects: {
                traits: {},
                stats: {}
            },
            workspace: {},
            tagRanks: {}
        }

        var grantedTags = {}
        var grantedTraits = {}
        

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

        LN = RulesHelpers.jsToolkit();


        if (evalOptions.gameSideEffects != undefined) {
            var options = {}
            try {
                eval(evalOptions.gameSideEffects);
            } catch (e) {
                result.errorMessages.push(`We had an error in the game side effects, please screenshot this and send it to your GM:  ${e.message}`)
            }
        }


        // Loop thru each skill to apply it's granted tags, spend, and side effects to the current state copy
        for (skillId in skillRanks) {

            const skill = skills[skillId]
            const rank = skillRanks[skillId]

            if (rank > 0) {
                skill.skill_tags.forEach((skillTag)=>{
                    if(skillTag.gives){
                        grantedTags[skillTag.tag.id] = skillTag.tag;
                    }
                    if(result.tagRanks[skillTag.tag.id] == undefined){
                        result.tagRanks[skillTag.tag.id] = {} 
                    }
                    result.tagRanks[skillTag.tag.id][skill.id] = rank

                })
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
                } else if(skill.rule.length > 0) {
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
        result.grantedTraits = Object.values(grantedTraits)
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
            skillCountInTag: RulesHelpers._skillCountInTag,
            rankCountInTag: RulesHelpers.rankCountInTag,
            sideEffects: {
                addStat: RulesHelpers._addStat,
                addTrait: RulesHelpers._addTrait,
                statValue: RulesHelpers._statValue
            },
            workspace: {
                helpers: {
                    hobbySpend: (options, cost) => {
                        if(LN.skillRank(options, 296) == 0){
                            return LN.spend(options, cost, "CP"); 
                        }else{
                            if(result.workspace.hobbyCosts == undefined){
                                result.workspace.hobbyCosts = []
                            }
                            
                    
                            const dynoCost = result.workspace.hobbyCosts.length == 0 ? 0 : Math.min.apply(null, result.workspace.hobbyCosts.concat(cost))
                            if(!options.forDisplay){
                                result.workspace.hobbyCosts.push(cost);
                                if(result.workspace.hobbyCosts.length == 0){
                                    result.workspace.hobbyCosts.splice(result.workspace.hobbyCosts.indexOf(dynoCost), 1);
                                }
                            }
                            
                            return LN.spend(options, dynoCost, "CP");  
                        }
                    },
                    hobbyRule: (options) => {
                        if((LN.skillRank(options, 140) + LN.skillRank(options, 152) + LN.skillRank(options, 164) + LN.skillRank(options, 177) + LN.skillRank(options, 190) + LN.skillRank(options, 128) + LN.skillRank(options, 190)) + LN.skillRank(options, 296) > 0){
                            if(LN.skillRank(options, 296) > 0){
                                return LN.skillCountInTag(options, "10") < 4;
                            }else{
                                return LN.skillCountInTag(options, "10") < 2;
                            }
                        }
                        return false;
                    }
                }
            }
        }
    }

    static _spend(options, cost, currency) {
        if(options.forDisplay === true){
            if(options.displayCost != undefined){
                return options.displayCost;
            } else if(cost == 0){
                return "free";
            }
            return cost + currency;
        }else{
            if (result.currencySpend[currency] === undefined) {
                result.currencySpend[currency] = 0;
            }
            result.currencySpend[currency] = result.currencySpend[currency] + cost;
        }
    }

    static _skillRank = function (options, skill_id) {

        if (skillRanks[skill_id] === undefined) {
            return 0;
        }
        return skillRanks[skill_id];
    }

    static _addStat(options, attributeName, amount) {
        if (result.sideEffects.stats[attributeName] === undefined) {
            result.sideEffects.stats[attributeName] = 0;
        }
        result.sideEffects.stats[attributeName] = result.sideEffects.stats[attributeName] + amount;
    }

    static _statValue(options, attributeName) {
        if (result.sideEffects.stats[attributeName] === undefined) {
            return 0;
        }
        return result.sideEffects.stats[attributeName];
    }

    static _addTrait(options, attributeName) {
        if (result.sideEffects.traits[attributeName] === undefined) {
            result.sideEffects.traits[attributeName] = 0;
        }
    }
    static _skillCountInTag(options, tagId){
        return Object.keys(result.tagRanks[tagId]).length;
    }
    static _rankCountInTag(options, tagId){
        return Object.values(result.tagRanks[tagId]).reduce((a, b) => a + b, 0);
    }


}