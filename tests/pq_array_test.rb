# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/pq_array'
require_relative '../lib/item'

class PQArray1Test < Minitest::Test
  def setup
    @pq = PQArray.new
    @pq.insert(Item.new(label: 'b', priority: 2))
    @pq.insert(Item.new(label: 'x', priority: 6))
    @pq.insert(Item.new(label: 'y', priority: 6))
    @pq.insert(Item.new(label: 'z', priority: 3))
    @pq.insert(Item.new(label: 'w', priority: 3))
    @pq.insert(Item.new(label: 'r', priority: 10))
  end

  def test_an_alias_for_insert # <<
    @pq << Item.new(label: 'm', priority: 20)
    assert_equal 'm', @pq.pull_highest.label
  end

  def test_correctly_inserts_multiple_items
    expect = "b (2), w (3), z (3), y (6), x (6), r (10)"
    assert_equal expect, @pq.to_s
    assert ! @pq.empty?
  end

  def test_correctly_pulls_highest_items_returning_nil_when_empty
    assert_equal 'r', @pq.pull_highest.label
    assert_equal 'x', @pq.pull_highest.label
    assert_equal 'y', @pq.pull_highest.label
    assert_equal 'z', @pq.pull_highest.label
    assert_equal 'w', @pq.pull_highest.label
    assert_equal 'b', @pq.pull_highest.label
    assert_nil    @pq.pull_highest
  end

  def test_find_highest_returns_nil_for_empty_queue
    pq = PQArray.new
    assert_nil pq.find_highest
  end

  def test_find_highest_returns_the_highest_priority_item
    assert_equal 'r', @pq.find_highest.label
    @pq.pull_highest
    assert_equal 'x', @pq.find_highest.label
  end

  def test_identifies_empty_queue
    pq = PQArray.new
    assert pq.empty?
    pq.insert(Item.new(label:'T', priority: 5))
    refute pq.empty?
    pq.pull_highest
    assert pq.empty?
  end

  def test_clear_empties_the_priority_queue
    @pq.clear
    assert @pq.empty?
  end

  def test_returns_correct_queue_size
    assert_equal 6, @pq.size
    @pq.pull_highest
    assert_equal 5, @pq.size
  end

# Extensions tests
  def test_correctly_pulls_lowest_items_returning_nil_when_empty
    assert_equal 'b', @pq.pull_lowest.label
    assert_equal 'w', @pq.pull_lowest.label
    assert_equal 'z', @pq.pull_lowest.label
    assert_equal 'y', @pq.pull_lowest.label
    assert_equal 'x', @pq.pull_lowest.label
    assert_equal 'r', @pq.pull_lowest.label
    assert_nil    @pq.pull_lowest
  end

  def test_can_mix_pull_highest_and_pull_lowest
    assert_equal 'r', @pq.pull_highest.label
    assert_equal 'b', @pq.pull_lowest.label
    assert_equal 'x', @pq.pull_highest.label
    assert_equal 'w', @pq.pull_lowest.label
    assert_equal 'y', @pq.pull_highest.label
    assert_equal 'z', @pq.pull_lowest.label
    assert_nil    @pq.pull_highest
  end

  def test_find_lowest_returns_nil_for_empty_queue
    pq = PQArray.new
    assert_nil pq.find_lowest
  end

  def test_find_lowest_returns_the_lowest_priority_item
    assert_equal 'b', @pq.find_lowest.label
    @pq.pull_lowest
    assert_equal 'w', @pq.find_lowest.label
  end
end
