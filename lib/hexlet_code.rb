# frozen_string_literal: true

require_relative './hexlet_code/version'

HexletCode.autoload :Tag, 'hexlet_code/tag.rb'
HexletCode.autoload :Form, 'hexlet_code/form.rb'
HexletCode.autoload :FormComponent, 'hexlet_code/form_component.rb'
HexletCode.autoload :RenderingDecorator, 'hexlet_code/rendering_decorator.rb'
HexletCode.autoload :HtmlRenderer, 'hexlet_code/html_renderer.rb'

module HexletCode
  class << self
    def form_for(object, options = {}, &)
      form = HexletCode::FormComponent.new(object, options, &)
      HtmlRenderer.new(form).to_s
    end
  end
end
