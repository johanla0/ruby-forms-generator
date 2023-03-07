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
        tags << get_label(attrs)
        tags << get_input(attrs, html_options)
        tags.join
      end

      def get_label(attrs)
        HexletCode::Label.build(attrs)
      end

      def get_input(attrs, html_options = {})
        as = attrs.fetch(:as, :input).capitalize
        klass = HexletCode.const_get(as)
        klass.build(attrs, html_options)
      end
    end
  end
end
