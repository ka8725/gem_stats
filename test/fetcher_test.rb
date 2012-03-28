require 'test_helper'

class FetcherTest < Test::Unit::TestCase
  include GemStats

  def test_fetch_list_gems
    assert_not_nil Fetcher.list
  end

  def test_size_of_fetcher_list
    assert_equal Fetcher.list.count, Fetcher.list_names.count
  end

  def test_fetch_and_save
    Fetcher.fetch_and_safe
  end
end
