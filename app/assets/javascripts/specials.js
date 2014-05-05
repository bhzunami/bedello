// This is a very special function!!!!
// The customer wants, that wen 'Bar (Ware wird abgeholt)' is selected
// the Lieferart dropdwon should be filled out automaticly.
// This function has to be updated if the id's change. STUPID!
function paymentChange() {
	var selected = $('#drop_pay :selected').text();
	if(selected == 'Bar (Ware wird abgeholt)') {
		$('#drop_ship').val(2);
	} else {
		$('#drop_ship').val(1);
	}
	//$("#drop_ship").prop("disabled", true);

}
