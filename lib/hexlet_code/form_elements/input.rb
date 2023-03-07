# frozen_string_literal: true

module HexletCode
  class Input
    class << self
      def build(attrs, html_options = {})
        name = attrs[:name]
        type = attrs.fetch(:type, 'text')
        value = attrs.fetch(:value, '')
        HexletCode::Tag.build('input', { name:, type:, value: }.merge(html_options).compact)
      end
    end
  end
end
