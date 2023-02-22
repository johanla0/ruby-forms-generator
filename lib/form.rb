# frozen_string_literal: true

require_relative 'tag'

class Form < Tag
  attr_accessor :object

  def initialize(object, attrs = {}, &)
    @object = object
    action = attrs[:url] || '#'
    method = attrs[:method] || 'post'
    form_attrs = { action:, method: }.merge(attrs.except(:url, :method))
    super('form', form_attrs, &)
  end

  def input(key, options = {})
    value = @object.public_send(key)

    has_label = options[:label]
    add_label(key) if has_label.nil? || has_label

    as = options[:as]

    html_options = options.except(:label, :as)
    if !as.nil? && as.to_sym == :text
      add_textarea({ name: key }.merge(html_options), value)
    else
      add_input({ name: key, type: 'text', value: }.merge(html_options))
    end
  end

  def submit(value = 'Save')
    @children << Tag.new('input', { type: 'submit', value: })
  end

  def add_label(key)
    @children << Tag.new('label', { for: key }) { key.to_s.capitalize }
  end

  def add_input(options)
    @children << Tag.new('input', options)
  end

  def add_textarea(options, value)
    @children << Tag.new('textarea', options) { value }
  end
end
