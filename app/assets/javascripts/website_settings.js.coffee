@BEDELLO.website_settings = 

	edit: ->
		new InitalizeDatePickerSettings()

	update: ->
		new InitalizeDatePickerSettings()

class @InitalizeDatePickerSettings
	constructor: ->
		@setupDatePicker()

	setupDatePicker: ->
		$("#website_settings_webstoreOpen").datepicker dateFormat: "dd/mm/yy"
		$("#website_settings_webstoreClose").datepicker dateFormat: "dd/mm/yy"
	
		$(".datepicker").each (i) ->
			unless $(this).val() is ''
				date = new Date( $(this).val() )
				$(this).val $.datepicker.formatDate("dd/mm/yy", date)