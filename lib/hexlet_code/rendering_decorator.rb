# frozen_string_literal: true

module HexletCode
  class RenderingDecorator < Form
    attr_accessor :form

    def initialize(form)
      @form = form
    end

    def to_s
      @form.to_s
    end
  end
end
