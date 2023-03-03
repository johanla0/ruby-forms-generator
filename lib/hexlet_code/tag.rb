# frozen_string_literal: true

module HexletCode
  class Tag
    VOID_TAGS = %i[area base br col command embed hr img input keygen link meta param source track wbr].freeze

    attr_accessor :tag_name, :attrs, :inner_html

    def initialize(tag_name, attrs = {}, &)
      @tag_name = tag_name
      @attrs = prepare_attributes(attrs)
      @inner_html = prepare_inner_html(attrs, &)
    end

    def to_s
      return "<#{@tag_name}#{attrs_html}>" if void_tag?

      "<#{@tag_name}#{attrs_html}>#{@inner_html}</#{@tag_name}>"
    end

    alias to_html to_s

    class << self
      def build(tag_name, attrs = {}, &)
        new(tag_name, attrs, &).to_s
      end
    end

    private

    def void_tag?
      VOID_TAGS.include?(@tag_name)
    end

    def attrs_html
      @attrs.each.map { |k, v| " #{k}=\"#{v}\"" }.join
    end

    def prepare_attributes(attrs)
      case @tag_name
      when :form
        action = attrs.fetch(:url, '#')
        method = attrs.fetch(:method, 'post')
        { action:, method: }.merge(attrs.except(:url, :method))
      when :textarea
        attrs.except(:label, :as, :value)
      when :label
        attrs.except(:name)
      else
        attrs.except(:label, :as)
      end
    end

    def prepare_inner_html(attrs, &block)
      return block.call if block_given?

      case @tag_name
      when :textarea
        attrs.fetch(:value, '')
      when :label
        attrs.fetch(:for, '').to_s.capitalize
      else
        ''
      end
    end
  end
end
