# frozen_string_literal: true

module HexletCode
  class Html
    class << self
      def render(form)
        action = form.attrs.fetch(:url, '#')
        method = form.attrs.fetch(:method, 'post')
        form_attrs = { action:, method: }.merge(form.attrs.except(:url, :method))
        HexletCode::Tag.build('form', form_attrs) { inner_html(form) }
      end

      private

      def inner_html(form)
        form.fields.map { |field| get_tags(field) }.join
      end

      def get_tags(attrs)
        html_options = attrs.except(:name, :label, :as, :value)

        tags = []
        tags << get_label(attrs, html_options)
        tags << get_input(attrs, html_options)
        tags.join
      end

      def get_label(attrs, html_options = {})
        has_label = attrs.fetch(:label, true)
        return unless has_label

        name = attrs[:name]
        HexletCode::Tag.build('label', { for: name }.merge(html_options)) { name.capitalize }
      end

      def get_input(attrs, html_options = {})
        name = attrs[:name]
        type = attrs.fetch(:type, 'text')
        value = attrs.fetch(:value, '')
        is_textarea = attrs[:as]&.to_sym == :text
        return HexletCode::Tag.build('textarea', { name: }.merge(html_options)) { value } if is_textarea

        HexletCode::Tag.build('input', { name:, type:, value: }.merge(html_options).compact)
      end
    end
  end
end
