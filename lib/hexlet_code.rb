# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'form'

module HexletCode
  class << self
    def form_for(object, options = {}, &)
      Form.new(object, options, &).to_s
    end
  end
end
