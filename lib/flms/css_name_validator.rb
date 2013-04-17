module Flms
  class CssNameValidator < ActiveModel::EachValidator
    def validate_each object, attribute, value
      unless value =~ /^[_a-zA-Z]+[_a-zA-Z0-9-]*$/
        object.errors[attribute] << (options[:message] || 'must be a valid CSS name')
      end
    end
  end
end