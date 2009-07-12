document.observe("dom:loaded", function() {
    addDepositTypeListener();

    addDepositAmountListener();
    addDepositPercentageListener();
    addDepositAccountAmountListener();
});

function addDepositTypeListener() {
    var depositType = $("deposit_type");
    if (depositType == null) { return; }

    depositType.observe("change", function() {
	var selected = $F(depositType);
	var amount = $F("deposit_dollars");

	new Ajax.Request("/deposits/accounts.json", {
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
    var account = $("account_" + id).up(".account");
    var amount = account.down(".amount");
    var percentage = account.down(".percentage");

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
		var account = percentageElem.up(".account");
		var percentage = floatVal(percentageElem) / 100.0;
		var acctAmmount = account.down(".amount");
		
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
		updateAccountAmountFromPercentage(elem);
	    }
	});
    });
}
function updateAccountAmountFromPercentage(percentageElem) {
    var amount = floatVal("deposit_dollars");
    var percentage = floatVal(percentageElem) / 100.0;
    var account = percentageElem.up(".account");
    var acctAmount = account.down(".amount");
    
    acctAmount.value = (percentage * amount).toFixed(2);
    updateUnallocated();
}

function addDepositAccountAmountListener() {
    $$(".amount").each(function(elem) {
	elem.observe("keyup", function(event) {
	    if (isNumberKey(event)) {
		updatePercentageFromAccountAmount(elem);
	    }
	});
    });
}
function updatePercentageFromAccountAmount(amountElem) {
    var amount = floatVal("deposit_dollars");
    var acctAmount = floatVal(amountElem);
    var account = amountElem.up(".account");
    var percentage = account.down(".percentage");

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
