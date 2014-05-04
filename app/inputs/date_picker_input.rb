# class DatePickerInput < SimpleForm::Inputs::StringInput 
#   def input                    
#     value = object.send(attribute_name) if object.respond_to? attribute_name
#     input_html_options[:value] ||= I18n.localize(value) if value.present?
#     input_html_classes << "datepicker"

#     super # leave StringInput do the real rendering
#   end
# end


    # class DatePickerInput < SimpleForm::Inputs::StringInput
    #   def input_html_options
    #     value = object.send(attribute_name)
    #     options = {
    #       value: value.nil?? nil : I18n.localize(value),
    #       data: { behaviour: 'datepicker' }  # for example
    #     }
    #     # add all html option you need...
    #     super.merge options
    #   end
    # end
