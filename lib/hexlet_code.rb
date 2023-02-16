# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  PAIRED_TAGS = %w[div form].freeze

  class Error < StandardError; end

  class Tag
    attr_accessor :tag, :attrs, :inner_html

    def initialize(tag, attrs = {}, &block)
      @tag = tag
      @attrs = attrs
      @inner_html = block_given? ? block.call : ""
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

  class Form
    attr_accessor :action, :method, :tags, :attrs, :object

    def initialize(object, attrs = {}, &block)
      @object = object
      @action = attrs.delete(:url) || "#"
      @method = attrs.delete(:method) || "post"
      @attrs = attrs
      @tags = []

      block.call(self) if block_given?
    end

    def input(key, options = {})
      value = @object.public_send(key)
      as = options.delete(:as)
      has_label = options.delete(:label)

      @tags << Tag.new("label", { for: key }) { key.to_s.capitalize } if has_label.nil?
      @tags << if !as.nil? && as.to_sym == :text
                 Tag.new("textarea", { name: key }.merge(options)) { value }
               else
                 Tag.new("input", { name: key, type: "text", value: }.merge(options))
               end
    end

    def submit(value = "Save")
      @tags << Tag.new("input", { type: "submit", value: })
    end

    def to_s
      Tag.build("form", { action: @action, method: @method }.merge(@attrs)) { @tags.map(&:to_s).join }
    end
  end

  class << self
    def form_for(object, options = {}, &)
      form = Form.new(object, options, &)
      form.to_s
    end
  end
end
