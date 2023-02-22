# frozen_string_literal: true

require 'test_helper'

class TestForm < Minitest::Test
  def setup
    @user = User.new name: 'rob', job: 'hexlet', gender: 'm'
  end

  def test_it_builds_form_tag
    result = Form.new @user do |f|
      f.input :name
    end.to_s
    assert_equal '<form action="#" method="post">' \
                 '<label for="name">Name</label><input name="name" type="text" value="rob">' \
                 '</form>',
                 result
  end

  def test_it_builds_form_tag_method_get
    result = Form.new @user, method: 'get', class: 'test-class' do |f|
      f.input :name
    end.to_s
    assert_equal '<form action="#" method="get" class="test-class">' \
                 '<label for="name">Name</label><input name="name" type="text" value="rob">' \
                 '</form>',
                 result
  end

  def test_it_builds_form_tag_without_label
    result = Form.new @user do |f|
      f.input :name, class: 'user-input', label: false
    end.to_s
    assert_equal '<form action="#" method="post"><input name="name" type="text" value="rob" class="user-input"></form>',
                 result
  end

  def test_it_builds_form_tag_with_submit
    result = Form.new @user do |f|
      f.input :name, label: false
      f.submit
    end.to_s
    assert_equal '<form action="#" method="post">' \
                 '<input name="name" type="text" value="rob"><input type="submit" value="Save">' \
                 '</form>',
                 result
  end

  def test_it_builds_form_tag_with_url
    result = Form.new @user, url: '/users' do |f|
      f.input :job, as: :text, rows: 50, cols: 50, label: false
    end.to_s
    assert_equal '<form action="/users" method="post">' \
                 '<textarea name="job" rows="50" cols="50">hexlet</textarea>' \
                 '</form>',
                 result
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
