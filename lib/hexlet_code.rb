# frozen_string_literal: true

PATH = File.expand_path('.', __dir__)
autoload :HexletCode, "#{PATH}/hexlet_code/version"
# autoload :Form, "#{PATH}/hexlet_code/form"
# autoload :Tag, "#{PATH}/hexlet_code/tag"

require_relative './hexlet_code/form'
require_relative './hexlet_code/tag'

module HexletCode
  class << self
    def form_for(object, options = {}, &)
      form = Form.new(object, options, &)
      content = form.fields.map { |field| get_tag(field) }
      Tag.new(:form, form.attrs) { content.join }.to_s
    end

    private

    def get_tag(field)
      tags = []
      tags << Tag.new(:label, { for: field.attrs[:name] }) if field.attrs.fetch(:label, true)
      tags << Tag.new(field.type, field.attrs)
      tags.map(&:to_s).join
    end
  end
end
