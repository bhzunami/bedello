# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@BEDELLO.properties = 
	new: ->
		$('.destroy_propertyItem_form').click (e) ->
			$(this).closest('.propertyItem').find('.hidden_field').val('1')
			$(this).closest('.propertyItem').slideUp().hide();

	edit: ->
		$('.destroy_propertyItem_form').click (e) ->
			$(this).closest('.propertyItem').find('.hidden_field').val('1')
			$(this).closest('.propertyItem').slideUp().hide();

		$('.add_propertyItem_form').click (e) ->
			lastNestedForm = $('.propertyItem').last()
			newNestedForm  = $('.propertyItem').last().clone()
			formsOnPage    = $('.propertyItem').length

			$(newNestedForm).find('label').each ->
				oldLabel = $(this).attr 'for'
				newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
				$(this).attr 'for', newLabel

			$(newNestedForm).find('select, input').each ->
				oldId = $(this).attr 'id'
				newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
				$(this).attr 'id', newId

				oldName = $(this).attr 'name'
				newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[#{formsOnPage}]")
				$(this).attr 'name', newName

			newNestedForm.find('.property_propertyItems_name').val('asdf')
			last = lastNestedForm.find('.items_name').val('asdf')
			item = newNestedForm.find('.property_propertyItems_name')
			$( newNestedForm ).insertAfter( lastNestedForm )