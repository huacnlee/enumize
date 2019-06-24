# frozen_string_literal: true

require "test_helper"

class Enumize::ModelTest < ActiveSupport::TestCase
  setup do
    I18n.default_locale = "en"
    @book = Book.new(status: :draft)
  end

  test "status_options" do
    assert_equal [["Drafting", "draft"], ["Published", "published"], ["Archived", "archived"]], Book.status_options
  end

  test "status base from enum" do
    assert_equal({ "draft" => 0, "published" => 1, "archived" => 2 }, Book.statuses)

    @book.status = :draft
    assert_equal "draft", @book.status
    assert_equal true, @book.draft?

    @book.published!
    assert_equal "published", @book.status
    assert_equal false, @book.draft?
    assert_equal true, @book.published?
  end

  test "status extend methods" do
    @book.status = :draft
    assert_equal "draft", @book.status
    assert_equal true, @book.draft?
    assert_equal "Drafting", @book.status_name
    assert_equal "#999999", @book.status_color
    assert_equal 0, @book.status_value

    @book.status = :published
    assert_equal "published", @book.status
    assert_equal true, @book.published?
    assert_equal "Published", @book.status_name
    assert_equal "green", @book.status_color
    assert_equal 1, @book.status_value

    @book.status = :archived
    assert_equal "archived", @book.status
    assert_equal true, @book.archived?
    assert_equal "Archived", @book.status_name
    assert_equal "red", @book.status_color
    assert_equal 2, @book.status_value
  end

  test "with I18n" do
    I18n.default_locale = "zh-CN"

    @book.status = :draft
    assert_equal "草稿", @book.status_name
    assert_equal "#999999", @book.status_color

    @book.status = :published
    assert_equal "已发布", @book.status_name
    assert_equal "green", @book.status_color

    @book.status = :archived
    assert_equal "归档", @book.status_name
    assert_equal "red", @book.status_color
  end
end
