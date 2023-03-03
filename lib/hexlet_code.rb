# frozen_string_literal: true

require_relative './hexlet_code/version'

HexletCode.autoload :Form, 'hexlet_code/form.rb'
HexletCode.autoload :Tag, 'hexlet_code/tag.rb'

module HexletCode
  class << self
    def form_for(object, options = {}, &)
      form = HexletCode::Form.new(object, options, &)
      content = form.fields.map { |field| get_tag(field) }
      HexletCode::Tag.new(:form, form.attrs) { content.join }.to_s
    end

    private

    def get_tag(field)
      tags = []
      tags << HexletCode::Tag.new(:label, { for: field.attrs[:name] }) if field.attrs.fetch(:label, true)
      tags << HexletCode::Tag.new(field.type, field.attrs)
      tags.map(&:to_s).join
    end
  end
end
