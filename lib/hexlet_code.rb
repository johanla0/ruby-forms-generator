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

  class Form
    attr_accessor :action, :method, :tags, :object

    def initialize(object, action, &block)
      action ||= "#"
      @object = object
      @action = action
      @method = "post"
      @tags = []

      block.call(self) if block_given?
    end

    def input(key, options = {})
      value = @object.public_send(key)
      as = options.delete(:as)
      has_label = options.delete(:label)

      @tags << Tag.build("label", { for: key }) { key.to_s.capitalize } if has_label.nil?
      @tags << if !as.nil? && as.to_sym == :text
                 Tag.build("textarea", { name: key }.merge(options)) { value }
               else
                 Tag.build("input", { name: key, type: "text", value: }.merge(options))
               end
    end

    def submit(value = "Save")
      @tags << Tag.build("input", { type: "submit", value: })
    end

    def to_s
      Tag.build("form", action: @action, method: @method) { @tags.join }
    end
  end

  class << self
    def form_for(object, options = {}, &)
      form = Form.new(object, options[:url], &)
      form.to_s
    end
  end
end
