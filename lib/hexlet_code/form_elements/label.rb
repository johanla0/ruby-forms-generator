# frozen_string_literal: true

module HexletCode
  class Label
    class << self
      def build(attrs)
        has_label = attrs.fetch(:label, true)
        return unless has_label

        name = attrs[:name]
        HexletCode::Tag.build('label', { for: name }) { name.capitalize }
      end
    end
  end
end
