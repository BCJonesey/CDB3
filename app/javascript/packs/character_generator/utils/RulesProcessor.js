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
    static evalRulesAndSpend(skrills, currencies_original, idToAdd) {
        // Build out placeholder for result
        result = {
            currencySpend: {},
            errorMessages: [],
            sideEffects: {}
        }

        // fuck you scope, ill figure it out later
        skills = LangUtils.deepCopy(skrills);

        if (idToAdd != undefined) {
            skills[idToAdd].rank = 1
        }



        // make a copy of currencies so we dont fuck with other people's shit
        currencies = LangUtils.deepCopy(currencies_original);
        currencySpend = {};

        const LN = RulesHelpers.jsTollkit();


        // Loop thru each skill to apply it's spend and side effects to the current state copy
        for (skillId in skills) {

            var skill = skills[skillId]
            if (skill.rank > 0) {
                if (skill.cost.length > 0) {
                    var options = {
                        skillRank: skill.rank
                    };
                    try {
                        eval(skill.cost);
                    } catch (e) {
                        result.errorMessages.push(`${skill.name} had an error in the cost, please screenshot this and send it to your GM:  ${e.message}`)
                    }
                }
                if (skill.side_effects != null && skill.side_effects.length > 0) {
                    var options = {
                        skillRank: skill.rank
                    };
                    try {
                        eval(skill.side_effects);
                    } catch (e) {
                        result.errorMessages.push(`${skill.name} had an error in the side effects, please screenshot this and send it to your GM:  ${e.message}`)
                    }
                }
            }
        }

        // Loop thru each skill to evaluate it's rules
        for (skillId in skills) {
            var skill = skills[skillId]

            if (skill.rank > 0) {
                var options = {
                    skillRank: skill.rank
                };
                if (skill.rank > skill.max_rank) {
                    result.errorMessages.push(`You do not meet the requirements for ${skill.name}`);
                } else {
                    try {
                        if (eval(skill.cost) == false) {
                            result.errorMessages.push(`You do not meet the requirements for ${skill.name}`);
                        }
                    } catch (e) {
                        result.errorMessages.push(`${skill.name} had an error in the rule, please screenshot this and send it to your GM:  ${e.message}`)
                    }


                }
            }
        }
        return result;

    }

}

module.exports = RulesProcessor;

class RulesHelpers {
    static jsTollkit() {
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

        if (skills[skill_id] === undefined) {
            return 0;
        }
        return skills[skill_id].rank;
    }

    static _addSideEffectScalar(options, attributeName, amount) {
        if (result.sideEffects[attributeName] === undefined) {
            result.sideEffects[attributeName] = 0;
        }
        result.sideEffects[attributeName] = result.sideEffects[attributeName] + amount;
    }



}