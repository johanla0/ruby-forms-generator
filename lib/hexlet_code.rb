# frozen_string_literal: true

require_relative './hexlet_code/version'

HexletCode.autoload :Tag, 'hexlet_code/tag.rb'
HexletCode.autoload :Form, 'hexlet_code/form.rb'
HexletCode.autoload :Html, 'hexlet_code/html.rb'

module HexletCode
  class << self
    def form_for(object, options = {}, &)
      form = HexletCode::Form.new(object, options, &)
      Html.render(form)
    end
  end
end
