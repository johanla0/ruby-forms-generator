# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestHexletCode < Minitest::Test
  def setup
    @user = User.new name: "rob", job: "hexlet", gender: "m"
  end

  def test_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_builds_unpaired_empty_tag
    result = ::HexletCode::Tag.build("br")
    assert_equal "<br>", result
  end

  def test_it_builds_unpaired_tag_with_attributes
    result = HexletCode::Tag.build("input", type: "submit", value: "Save")
    assert_equal "<input type=\"submit\" value=\"Save\">", result
  end

  def test_it_builds_paired_tag_with_content
    result = HexletCode::Tag.build("label") { "Email" }
    assert_equal "<label>Email</label>", result
  end

  def test_it_builds_paired_empty_tag
    result = HexletCode::Tag.build("div")
    assert_equal "<div></div>", result
  end

  def test_it_builds_form_tag
    result = HexletCode.form_for @user do |f|
      f.input :name
    end
    assert_equal "<form action=\"#\" method=\"post\"><label for=\"name\">Name</label><input name=\"name\" type=\"text\" value=\"rob\"></form>", result
  end

  def test_it_builds_form_tag_method_get
    result = HexletCode.form_for @user, method: "get" do |f|
      f.input :name
    end
    assert_equal "<form action=\"#\" method=\"get\"><label for=\"name\">Name</label><input name=\"name\" type=\"text\" value=\"rob\"></form>", result
  end

  def test_it_builds_form_tag_without_label
    result = HexletCode.form_for @user do |f|
      f.input :name, class: "user-input", label: false
    end
    assert_equal "<form action=\"#\" method=\"post\"><input name=\"name\" type=\"text\" value=\"rob\" class=\"user-input\"></form>", result
  end

  def test_it_builds_form_tag_with_submit
    result = HexletCode.form_for @user do |f|
      f.input :name, label: false
      f.submit
    end
    assert_equal "<form action=\"#\" method=\"post\"><input name=\"name\" type=\"text\" value=\"rob\"><input type=\"submit\" value=\"Save\"></form>", result
  end

  def test_it_builds_form_tag_with_url
    result = HexletCode.form_for @user, url: "/users" do |f|
      f.input :job, as: :text, rows: 50, cols: 50, label: false
    end
    assert_equal "<form action=\"/users\" method=\"post\"><textarea name=\"job\" rows=\"50\" cols=\"50\">hexlet</textarea></form>", result
  end

  def test_it_throws_undefined_method
    assert_raises NoMethodError do
      HexletCode.form_for @user, url: "/users" do |f|
        f.input :name
        f.input :age
      end
    end
  end
end
