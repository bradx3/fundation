document.observe("dom:loaded", function() {
    addDepositTypeListener();
});

function addDepositTypeListener() {
    var depositType = $("deposit_type");
    if (depositType != null) {
	depositType.observe("change", function() {
	    var selected = $F(depositType);
	    var amount = $F("deposit_amount_in_cents");

	    new Ajax.Request("/deposits/accounts", {
		parameters: { type_id: selected, amount: amount },
		method: "get",
		onSuccess: function(transport) {
		    var json = transport.responseText.evalJSON();
		}
	    });
	});
    }
}