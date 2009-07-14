document.observe("dom:loaded", function() {
    addDepositTemplateListener();

    addDepositAmountListener();
    addDepositPercentageListener();
    addDepositFundAmountListener();
});

function addDepositTemplateListener() {
    var depositType = $("deposit_template");
    if (depositType == null) { return; }

    depositType.observe("change", function() {
	var selected = $F(depositType);
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
	    }
	});
    });
}

function updateDepositValues(id, values) {
    var fund = $("fund_" + id).up(".fund");
    var amount = fund.down(".amount");
    var percentage = fund.down(".percentage");

    amount.value = values["amount"].toFixed(2);
    percentage.value = values["percentage"].toFixed(2);
    updateUnallocated();
}

function addDepositAmountListener() {
    var amount = $("deposit_dollars");
    if (amount == null) { return; }

    amount.observe("keyup", function(event) {
	if (isNumberKey(event)) {
	    var dollars = floatVal(amount);

	    $$(".percentage").each(function(percentageElem) {
		var fund = percentageElem.up(".fund");
		var percentage = floatVal(percentageElem) / 100.0;
		var acctAmmount = fund.down(".amount");
		
		acctAmmount.value = (percentage * dollars).toFixed(2);
		updateUnallocated();
	    });
	}
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

function updateUnallocated() {
    var amount = floatVal("deposit_dollars");
    var total = 0;
    $$(".amount").each(function(elem) {
	total += floatVal(elem);
    });

    var unallocated = $("unallocated");
    unallocated.update("$" + total.toFixed(2));
    if (total != amount) {
	unallocated.addClassName("incorrect");
    }
    else {
	unallocated.removeClassName("incorrect");
    }
}
