require 'test_helper'

class FetcherTest < Test::Unit::TestCase
  include GemStats

  def test_fetch_list_gems
    assert_not_nil Fetcher.list
  end

  def test_fetch_and_save
    assert_equal true, Fetcher.respond_to?(:fetch_and_safe)
  end

  def test_bulk_number
    assert_equal 50, Fetcher.bulk_number
    Fetcher.bulk_number = 100
    assert_equal 100, Fetcher.bulk_number
  end
end
