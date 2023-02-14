# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, keyword_init: true)

class TestHexletCode < Minitest::Test
  def setup
    @user = User.new name: "rob"
  end

  def test_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_builds_unpaired_empty_tag
    result = ::HexletCode::Tag.build('br')
    assert_equal '<br>', result
  end

  def test_it_builds_unpaired_tag_with_attributes
    result = HexletCode::Tag.build('input', type: 'submit', value: 'Save')
    assert_equal "<input type=\"submit\" value=\"Save\">", result
  end

  def test_it_builds_paired_tag_with_content
    result = HexletCode::Tag.build('label') { 'Email' }
    assert_equal "<label>Email</label>", result
  end

  def test_it_builds_paired_empty_tag
    result = HexletCode::Tag.build('div')
    assert_equal "<div></div>", result
  end

  def test_it_builds_form_tag
    result = HexletCode.form_for @user do |f|
    end
    assert_equal "<form action=\"#\" method=\"post\"></form>", result
  end

  def test_it_builds_form_tag_with_url
    result = HexletCode.form_for @user, url: '/users' do |f|
    end
    assert_equal "<form action=\"/users\" method=\"post\"></form>", result
  end
end
