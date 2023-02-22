# frozen_string_literal: true

require 'test_helper'

class TestTag < Minitest::Test
  def test_it_builds_unpaired_empty_tag
    result = Tag.build('br')
    assert_equal '<br>', result
  end

  def test_it_builds_unpaired_tag_with_attributes
    result = Tag.build('input', type: 'submit', value: 'Save')
    assert_equal '<input type="submit" value="Save">', result
  end

  def test_it_builds_paired_tag_with_content
    result = Tag.build('label') { 'Email' }
    assert_equal '<label>Email</label>', result
  end

  def test_it_builds_paired_empty_tag
    result = Tag.build('div')
    assert_equal '<div></div>', result
  end
end
