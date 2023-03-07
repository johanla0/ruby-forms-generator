# frozen_string_literal: true

require_relative './hexlet_code/version'

HexletCode.autoload :Form, 'hexlet_code/form.rb'
HexletCode.autoload :Html, 'hexlet_code/html.rb'
HexletCode.autoload :Tag, 'hexlet_code/tag.rb'
HexletCode.autoload :Input, 'hexlet_code/form_elements/input.rb'
HexletCode.autoload :Label, 'hexlet_code/form_elements/label.rb'
HexletCode.autoload :Text, 'hexlet_code/form_elements/text.rb'

module HexletCode
  class << self
    def form_for(object, options = {}, &)
      form = HexletCode::Form.new(object, options, &)
      HexletCode::Html.render(form)
    end
  end
end
