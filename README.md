# HexletCode

## Tests and linter status:
[![Actions Status](https://github.com/johanla0/rails-project-63/workflows/hexlet-check/badge.svg)](https://github.com/johanla0/rails-project-63/actions)

[![Main](https://github.com/johanla0/rails-project-63/actions/workflows/main.yml/badge.svg)](https://github.com/johanla0/rails-project-63/actions/workflows/main.yml)

## What is it

Small gem to create forms. 1st project for the Hexlet Rails course.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add hexlet_code

## Usage

```
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'developer', gender: 'm'

HexletCode.form_for user, url: "/users" do |f|
  f.input :name, class: "user-input"
  f.input :job, as: :text, rows: 50, cols: 50
  f.submit
end
```

Returns:

```
<form action="/users" method="post">
    <input name="name" type="text" value="rob" class="user-input">
    <textarea name="job" rows="50" cols="50">developer</textarea>
    <input type="submit" value="Save">
</form>

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
