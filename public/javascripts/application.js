document.observe("dom:loaded", function() {
    addDepositTypeListener();

    addDepositAmountListener();
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

    amount.value = values["amount"];
    percentage.value = values["percentage"];
}

function addDepositAmountListener() {
    var amount = $("deposit_dollars");
    if (amount == null) { return; }

    amount.observe("keyup", function() {
	var dollars = floatVal(amount);

	$$(".percentage").each(function(percentageElem) {
	    var account = percentageElem.up(".account");
	    var percentage = floatVal(percentageElem) / 100.0;
	    var acctAmmount = account.down(".amount");
	    
	    acctAmmount.value = (percentage * dollars).toFixed(2);
	});
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