@BEDELLO.website_settings = 

	edit: ->
		new InitalizeDatePickerSettings()

	update: ->
		new InitalizeDatePickerSettings()

class @InitalizeDatePickerSettings
	constructor: ->
		@setupDatePicker()

	formateDate:(date) ->
		date = new Date(date)
		return $.datepicker.formatDate("dd/mm/yy", date)

	setupDatePicker: ->
		$("#website_settings_webstoreOpen").datepicker dateFormat: "dd/mm/yy"
		$("#website_settings_webstoreClose").datepicker dateFormat: "dd/mm/yy"

		unless $("#website_settings_webstoreOpen").val() is ''
			$("#website_settings_webstoreOpen").val @formateDate($("#website_settings_webstoreOpen").val())
		unless $("#website_settings_webstoreClose").val() is ''
			$("#website_settings_webstoreClose").val @formateDate($("#website_settings_webstoreClose").val())