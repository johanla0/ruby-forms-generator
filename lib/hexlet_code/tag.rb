# frozen_string_literal: true

module HexletCode
  class Tag
    VOID_TAGS = %w[area base br col command embed hr img input keygen link meta param source track wbr].freeze

    class << self
      def build(tag_name, attrs = {}, &block)
        return "<#{tag_name}#{attrs_html(attrs)}>" if void_tag?(tag_name)

        inner_html = block_given? ? block.call : ''
        "<#{tag_name}#{attrs_html(attrs)}>#{inner_html}</#{tag_name}>"
      end

      private

      def void_tag?(tag_name)
        VOID_TAGS.include?(tag_name)
      end

      def attrs_html(attrs)
        attrs.each.map { |k, v| " #{k}=\"#{v}\"" }.join
      end
    end
  end
end
