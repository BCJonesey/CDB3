function currency_spent_in_group(currency,group,recursive)
  {
    tempCurrencyPack = jQuery.extend(true, {}, currencyPack);

    spend_group(group,recursive);
    amount = tempCurrencyPack[currency] - currencyPack[currency]

    currencyPack = jQuery.extend(true, {}, tempCurrencyPack);
    return amount;
  }


  function spend_group(group,recursive)
  {

    jQuery.each(groups[group], function(index, value) {
      if(skill_rank(value)>0)
      {
        for(j=0;j<skill_rank(value);j++)
        {
          eval(allSkills[value].cost)
        }
        if(recursive && allSkills[value].is_group)
        {
          spend_group(value,currency,recursive)
        }
      }
    });


  }
  function skill_rank(skill_id)
  {
	var retVal = 0;
    if(typeof skills.get(skill_id) === 'undefined')
    {
      retVal =  0;
    }
    else
    {
      retVal =  skills.get(skill_id).getCharSkill().get("rank");
    }
    return retVal;
  }
  function group_rank(groupId,recursive)
  {
      
    rank=0;
    jQuery.each(groups[groupId], function(index, value) {
      rank=rank+ skill_rank(value);
      if(recursive && allSkills[value].is_group && skill_rank(value)>0)
      {
        rank = rank + group_rank(value,recursive)
      }
    });
    return rank;

  }
  function group_skill_count(groupId,recursive)
  {

    rank=0;
    jQuery.each(groups[groupId], function(index, value) {
      if(skill_rank(value)>0)
      {
        rank++;
      }
      if(recursive && allSkills[value].is_group && skill_rank(value)>0)
      {
        rank = rank + group_rank(value,recursive)
      }
    });
    return rank;

  }


  function is_valid_character()
  {
	var retVal = true;
	/*
    // Spend the cash
    for(var i in skillPack)
    {
      for(j=0;j<skill_rank(i);j++)
      {
        eval(allSkills[i].cost)
      }
      
    }
    //check to see if this gives you a negitive balance
    for(var i in currencyPack)
    {
   
      if(currencyPack[i]<0)
      {
        errorAlert("Validation Error","That would give you a "+currencyPack[i]+i+" balance.");
        return false;
      }
    }
    
    //check to see if the pre-reqs of the open headers are met
    for(var i in groups)
    {
      ERROR_ALERT = '';
      if(allSkills[i].parent==null && !(eval(allSkills[i].prereq)))
      {
        errorAlert("Validation Error","You do not meet the requirements of "+allSkills[i].name+"</br>"+ERROR_ALERT);
        return false;
      }
    }
	*/
    //check to see if all of the pre-reqs of the puchaced skills are met
    skills.each(function(skill){
    
      ERROR_ALERT = '';
      if(!((skill.get("rule") == null ? true:eval(skill.get("rule"))) && (skill.getCharSkill().get("rank"))<=skill.get("max_rank")))
      {
        errorAlert("Validation Error","You do not meet the requirements of "+skill.get("name")+"</br>"+ERROR_ALERT);
        retVal = false;
		return false;
      }
    });
	
    return retVal;
  }


 


  function SPEND(amount,currency)
  {
    currencyPack[currency]=currencyPack[currency] - amount;
  }
  function SPEND_COMBO(amount,currency1,currency2)
  {
    if(currencyPack[currency1]>=amount)
    {
      currencyPack[currency1]=currencyPack[currency1] - amount;
    }
    else if(currencyPack[currency1]>0)
    {
      currencyPack[currency2]=currencyPack[currency2] - (amount-currencyPack[currency1]);
      currencyPack[currency1] = 0;
    }
    else
    {
      currencyPack[currency2]=currencyPack[currency2] - amount;
    }


  }



  function errorAlert(title,body)
  {
    $('<div class="modal hide fade">  <div class="modal-header">    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>    <h3>Modal header</h3>  </div>  <div class="modal-body">    <p>One fine body</p>  </div>  <div class="modal-footer">    <a href="#" class="btn">Close</a>    <a href="#" class="btn btn-primary">Save changes</a>  </div></div>').modal();
  }