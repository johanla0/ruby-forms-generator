# frozen_string_literal: true

module HexletCode
  class Text
    class << self
      def build(attrs, html_options = {})
        name = attrs[:name]
        value = attrs.fetch(:value, '')
        HexletCode::Tag.build('textarea', { name: }.merge(html_options)) { value }
      end
    end
  end
end
