require 'test_helper'

class GemInfoTest < Test::Unit::TestCase
  def setup
    @gem = GemStats::GemInfo.new('get_or_build')
  end

  def test_fetch
    assert_not_nil @gem.info
  end

  def test_dependencies
    assert_equal [], @gem.dependencies
    assert_equal ["actionpack", "activerecord", "rake", "sqlite3"].sort, @gem.dependencies(:development).sort
    assert_equal [], @gem.dependencies(:runtime)
  end

  def test_clients
    assert_equal [], @gem.clients.to_a
    assert_equal [], @gem.clients(:development).to_a
  end
end
