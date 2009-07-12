document.observe("dom:loaded", function() {
    addDepositTypeListener();
});

function addDepositTypeListener() {
    var depositType = $("deposit_type");
    if (depositType != null) {
	depositType.observe("change", function() {
	    var selected = $F(depositType);
	    var amount = $F("deposit_amount_in_cents");

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
}

function updateDepositValues(id, values) {
    var account = $("account_" + id).up(".account");
    var amount = account.down(".amount");
    var percentage = account.down(".percentage");

    amount.value = values["amount"];
    percentage.value = values["percentage"];
}