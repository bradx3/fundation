document.observe("dom:loaded", function() {
    if ($("deposit") != null) {
	addDepositTemplateListener();
	addDepositAmountListener();
	addDepositPercentageListener();
	addDepositFundAmountListener();
	
	updateAmountsFromPercentages();
	updateUnallocated();
    }
    else if ($("deposit_template") != null) {
	addDepositTemplatePercentageListener();
	updateDepositTemplateAllocated();
    }
    else if ($("created_at_after") != null) {
	addDateListeners();
    }
});

function addDepositTemplateListener() {
    var depositType = $("deposit_template");
    if (depositType == null) { return; }

    depositType.observe("change", function() {
	var selected = $F(depositType);
	useDepositTemplate(selected);
    });
}
function useDepositTemplate(selected) {
    var amount = $F("deposit_dollars");

    new Ajax.Request("/deposits/funds.json", {
	parameters: { type_id: selected, amount: amount },
	method: "get",
	onSuccess: function(transport) {
	    var json = transport.responseText.evalJSON();
	    for (var id in json) {
		var values = json[id];
		updateDepositValues(id, values);
	    }
	    updateAmountsFromPercentages();
	    updateUnallocated();
	}
    });
}

function updateDepositValues(id, values) {
    var fund = $("fund_" + id).up(".fund");
    var amount = fund.down(".amount");
    var percentage = fund.down(".percentage");

    percentage.value = values["percentage"].toFixed(2);
}

function addDepositAmountListener() {
    var amount = $("deposit_dollars");
    if (amount == null) { return; }

    amount.observe("keyup", function(event) {
	if (isNumberKey(event)) {
	    updateAmountsFromPercentages();
	    updateUnallocated();
	}
    });
}
function updateAmountsFromPercentages() {
    var dollars = floatVal("deposit_dollars");

    $$(".percentage").each(function(percentageElem) {
	var fund = percentageElem.up(".fund");
	var percentage = floatVal(percentageElem) / 100.0;
	var acctAmmount = fund.down(".amount");
	
	acctAmmount.value = (percentage * dollars).toFixed(2);
    });
}

/*
  Returns a float value for the given elements value.
  Returns 0 if the value is bad or empty
*/
function floatVal(element) {
    var res = $F(element);
    res = parseFloat(res);
    if (isNaN(res)) { res = 0; }

    return res;
}

function isNumberKey(event) {
    var code = event.keyCode;
    var res = (code >= 48 && code <= 57);
    res = res || (code == 8)
    return res;
}
function addDepositPercentageListener() {
    $$(".percentage").each(function(elem) {
	elem.observe("keyup", function(event) {
	    if (isNumberKey(event)) {
		updateFundAmountFromPercentage(elem);
	    }
	});
    });
}
function updateFundAmountFromPercentage(percentageElem) {
    var amount = floatVal("deposit_dollars");
    var percentage = floatVal(percentageElem) / 100.0;
    var fund = percentageElem.up(".fund");
    var acctAmount = fund.down(".amount");
    
    acctAmount.value = (percentage * amount).toFixed(2);
    updateUnallocated();
}

function addDepositFundAmountListener() {
    $$(".amount").each(function(elem) {
	elem.observe("keyup", function(event) {
	    if (isNumberKey(event)) {
		updatePercentageFromFundAmount(elem);
	    }
	});
    });
}
function updatePercentageFromFundAmount(amountElem) {
    var amount = floatVal("deposit_dollars");
    var acctAmount = floatVal(amountElem);
    var fund = amountElem.up(".fund");
    var percentage = fund.down(".percentage");

    percentage.value = (acctAmount * 100.0 / amount).toFixed(2);
    updateUnallocated();
}

function fixRoundingErrors() {
    var amount = floatVal("deposit_dollars");
    var diff = amount - amountTotal();

    if (percentageTotal() == 100.0 && diff != 0.0) {
	var amounts = $$(".amount");

	for (var i = 0; i < amounts.length; i++) {
	    var toUpdate = amounts[i];
	    if (floatVal(toUpdate) != 0) {
		toUpdate.value = (floatVal(toUpdate) + diff).toFixed(2);
		break;
	    }
	}
    }
}

function percentageTotal() {
    var total = 0;
    $$(".percentage").each(function(e) {
	total += floatVal(e);
    });
    return total;
}

function amountTotal() {
    var total = 0;
    $$(".amount").each(function(elem) {
	total += floatVal(elem);
    });
    return total;
}
function updateUnallocated() {
    fixRoundingErrors();

    var amount = floatVal("deposit_dollars");
    var total = amountTotal();

    var unallocated = $("unallocated");
    unallocated.update("$" + total.toFixed(2));
    if (total.toFixed(2) != amount.toFixed(2)) {
	unallocated.addClassName("incorrect");
    }
    else {
	unallocated.removeClassName("incorrect");
    }
}


function addDepositTemplatePercentageListener() {
    $$(".percentage").each(function(elem) {
	elem.observe("keyup", function(event) {
	    if (isNumberKey(event)) {
		updateDepositTemplateAllocated();
	    }
	});
    });
}
function updateDepositTemplateAllocated() {
    var total = 0;
    $$(".percentage").each(function(elem) {
	total += floatVal(elem);
    });

    var unallocated = $("unallocated");
    unallocated.update(total.toFixed(2) + "%");
    if (total.toFixed(2) != 100.00) {
	unallocated.addClassName("incorrect");
    }
    else {
	unallocated.removeClassName("incorrect");
    }
}

function addDateListeners() {
    var opts = {
        // The ID of the associated form element
        id:"created_at_after",
        // The date format to use
        format:"d-sl-m-sl-Y",
        // Days to highlight (starts on Monday)
        highlightDays:[0,0,0,0,0,1,1],
        // Days of the week to disable (starts on Monday)
        disabledDays:[0,0,0,0,0,0,0],
        // Dates to disable (YYYYMMDD format, "*" wildcards excepted)
        disabledDates:{
                "20090601":"20090612", // Range of dates
                "20090622":"1",        // Single date
                "****1225":"1"         // Wildcard example 
                },
        // Date to always enable
        enabledDates:{},
        // Don't fade in the datepicker
        // NOTE: Only relevant if "staticPos" is set to false
        noFadeEffect:false,
        // Is it inline or popup
        staticPos:false,
        // Do we hide the associated form element on create
        hideInput:false,
        // Do we hide the today button
        noToday:true,
        // Do we show weeks along the left hand side
        showWeeks:true,
        // Is it drag disabled
        // NOTE: Only relevant if "staticPos" is set to false
        dragDisabled:true,
        // Positioned the datepicker within a wrapper div of your choice (requires the ID of the wrapper element)
        // NOTE: Only relevant if "staticPos" is set to true
        positioned:"",
        // Do we fill the entire grid with dates
        fillGrid:true,
        // Do we constrain dates not within the current month so that they cannot be selected
        constrainSelection:true,
        // Callback Object
        callbacks:{"create":[createSpanElement], "dateselect":[showEnglishDate]},
        // Do we create the button within a wrapper element of your choice (requires the ID of the wrapper element)
        // NOTE: Only relevant if staticPos is set to false
        buttonWrapper:"",
        // Do we start the cursor on a specific date (YYYYMMDD format string)
        cursorDate:""      
      };
      datePickerController.createDatePicker(opts);
}