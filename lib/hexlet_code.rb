# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  PAIRED_TAGS = %w[div].freeze

  class Error < StandardError; end

  class Tag
    attr_accessor :tag, :attrs, :inner_html

    def initialize(tag, attrs = {}, &block)
      @tag = tag
      @attrs = attrs
      @inner_html = block_given? ? block.call : ""
      to_s
    end

    def to_s
      line = "<#{@tag}"
      line += " " if @attrs.any?
      line += @attrs.each.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
      line += ">"
      if paired?
        line += inner_html
        line += "</#{@tag}>"
      end
      line
    end

    class << self
      def build(tag, attrs = {}, &)
        tag = new(tag, attrs, &)
        tag.to_s
      end
    end

    private

    def paired?
      PAIRED_TAGS.include?(@tag) || !@inner_html.empty?
    end
  end
end
