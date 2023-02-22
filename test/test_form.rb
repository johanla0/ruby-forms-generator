# frozen_string_literal: true

require 'test_helper'

class TestForm < Minitest::Test
  def setup
    @user = User.new name: 'rob', job: 'hexlet', gender: 'm'
  end

  def test_it_builds_form_tag
    form_tag = File.read("#{$LOAD_PATH.first}/form_tag.html")
    result = Form.new @user do |f|
      f.input :name
    end.to_s
    assert_equal form_tag, result
  end

  def test_it_builds_form_tag_method_get
    form_tag_method_get = File.read("#{$LOAD_PATH.first}/form_tag_method_get.html")
    result = Form.new @user, method: 'get', class: 'test-class' do |f|
      f.input :name
    end.to_s
    assert_equal form_tag_method_get, result
  end

  def test_it_builds_form_tag_without_label
    form_tag_without_label = File.read("#{$LOAD_PATH.first}/form_tag_without_label.html")
    result = Form.new @user do |f|
      f.input :name, class: 'user-input', label: false
    end.to_s
    assert_equal form_tag_without_label, result
  end

  def test_it_builds_form_tag_with_submit
    form_tag_with_submit = File.read("#{$LOAD_PATH.first}/form_tag_with_submit.html")
    result = Form.new @user do |f|
      f.input :name, label: false
      f.submit
    end.to_s
    assert_equal form_tag_with_submit, result
  end

  def test_it_builds_form_tag_with_url
    form_tag_with_url = File.read("#{$LOAD_PATH.first}/form_tag_with_url.html")
    result = Form.new @user, url: '/users' do |f|
      f.input :job, as: :text, rows: 50, cols: 50, label: false
    end.to_s
    assert_equal form_tag_with_url, result
  end

  def test_it_throws_undefined_method
    assert_raises NoMethodError do
      Form.new @user, url: '/users' do |f|
        f.input :name
        f.input :age
      end
    end
  end
end
