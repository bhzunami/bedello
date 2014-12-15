// This is a very special function!!!!
// The customer wants, that wen 'Bar (Ware wird abgeholt)' is selected
// the Lieferart dropdwon should be filled out automaticly.
// This function has to be updated if the id's change. STUPID!
var DEFAULT_SHIPMENT_COSTS = 16.00;
var recal = false;
function paymentChange() {
	var selected = $('#drop_pay :selected').text();
	if(selected == 'Bar (Ware wird abgeholt)') {
		$('#drop_ship').val(1);
		$('#drop_ship option:selected').attr('disabled', 'disabled');
		$('#drop_ship').val(2);
		// remove Lieferkosten when exist
		$('#shipment').hide();

		$('#total_price').find("strong").replaceWith( reCalculateTotalCosts( $('#total_price').find("strong").html(), true) );
	} else {
		$('#drop_ship').val(2);
		$('#drop_ship option:selected').attr('disabled', 'disabled');
		$('#drop_ship').val(1);
		$('#shipment').show();
		$('#total_price').find("strong").replaceWith( reCalculateTotalCosts( $('#total_price').find("strong").html(), false) );
	}
	//$("#drop_ship").prop("disabled", true);

}


function reCalculateTotalCosts(actualCost, minus) {
	price = Number(actualCost.replace(/[^0-9\.]+/g,""));
	
	if( recal == false && minus == false) {
		return printPrice(price);
	}
	if( minus ) {
		price -= DEFAULT_SHIPMENT_COSTS;
		recal = true

	} else {
		price += DEFAULT_SHIPMENT_COSTS;
		recal = false
	}
	return printPrice(price);
	
}

function printPrice(price) {
	price = $.number( price, 2, '.' );
	return("<strong> CHF "+price +"</strong>")	
}
