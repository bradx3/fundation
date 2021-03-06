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

    addTableRowListeners();
    addSidebarCheckboxLiListeners();
    addSidebarCheckboxListeners();

    Calendar.setup({ dateField : 'f_created_after' });
    Calendar.setup({ dateField : 'f_created_before' });
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

function deleteObject(sender) {
    var group = $(sender).up(".group");
    if (group) {
	var del = group.down(".delete");
	if (del) {
	    del.value = "1";
	    group.hide();
	}
    }
}

function addTableRowListeners() {
    var rows = $$("table.table tr");
    rows.each(function(row) {
	row.observe("click", function(e) {
	    var link = row.down("a");
	    if (link) {
		document.location = link.href;
	    }
	});
    });
}

function addSidebarCheckboxLiListeners() {
    var lis = $$("#sidebar li.checkbox");
    lis.each(function(li) {
	li.observe("click", function(e) {
	    var checkBox = li.down(".checkbox");
	    checkBox.checked = !checkBox.checked;
	    submitFilterForm();
	});
    });
}

function addSidebarCheckboxListeners() {
    var checkboxes = $$("#sidebar li.checkbox .checkbox");
    checkboxes.each(function(checkBox) {
	checkBox.observe("click", submitFilterForm);
    });
}

function submitFilterForm() {
    $("sidebar").down("form").submit();
}