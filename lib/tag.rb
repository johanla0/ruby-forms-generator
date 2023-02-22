# frozen_string_literal: true

VOID_TAGS = %w[area base br col command embed hr img input keygen link meta param source track wbr].freeze

class Tag
  attr_accessor :tag_name, :attrs, :children

  def initialize(tag_name, attrs = {}, &)
    @tag_name = tag_name
    @attrs = attrs
    @children = []

    add_children(self, &) if block_given?
  end

  def to_s
    return "<#{@tag_name}#{attrs_html}>" if void_tag?

    "<#{@tag_name}#{attrs_html}>#{inner_html}</#{@tag_name}>"
  end

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

  def inner_html
    return @children if @children.is_a? String

    @children.present? ? @children.join : ''
  end

  def add_children(obj, &block)
    block_result = block.call(obj)

    if block_result.is_a? Tag
      @children << block_result
    else
      @children = block_result
    end
  end
end
