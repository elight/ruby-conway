require 'helper'

class RulesTest < Test::Unit::TestCase
  def self.assert_process_rule_on(args = {})
    current_state = args[:cell_that_is]
    num_neighbors = args[:with_number_of_alive_neighbors]
    expected_next_state = args[:should_be]

    context "A #{current_state} cell with #{num_neighbors} alive neighbors" do
      should "be #{expected_next_state}" do
        next_state = run_rule :with_cell_state => current_state, :and_num_neighbors => num_neighbors
        assert_equal expected_next_state, next_state
      end
    end
  end
 
  assert_process_rule_on :cell_that_is => 1, 
                         :with_number_of_alive_neighbors => 1, 
                         :should_be => 0

  assert_process_rule_on :cell_that_is => 1,
                         :with_number_of_alive_neighbors => 2, 
                         :should_be => 1

  assert_process_rule_on :cell_that_is => 1, 
                         :with_number_of_alive_neighbors => 3, 
                         :should_be => 1

  assert_process_rule_on :cell_that_is => 1, 
                         :with_number_of_alive_neighbors => 4, 
                         :should_be => 0

  assert_process_rule_on :cell_that_is => 0, 
                         :with_number_of_alive_neighbors => 2, 
                         :should_be => 0

  assert_process_rule_on :cell_that_is => 0, 
                         :with_number_of_alive_neighbors => 3, 
                         :should_be => 1
end

class GameTest < Test::Unit::TestCase
  context "A 3x3 game" do
    setup do
      @game = game [
        [1, 1, 0],
        [1, 0, 0],
        [0, 0, 0]
      ]
    end

    should "be able to transition to its next expected state" do
      expected = [
        [1, 1, 0],
        [1, 1, 0],
        [0, 0, 0]
      ]
      assert_equal expected, @game.next_state
    end

    [[-1, 0], [0, -1], [3, 0], [0, 3]].each do |coords|
      should "know that #{coords.inspect} is out of bounds" do
        assert !@game.is_inbound(*coords)
      end
    end

    [[0, 0], [2, 2]].each do |coords|
      should "know that #{coords.inspect} is out of bounds" do
        assert @game.is_inbound(*coords)
      end
    end


    should "know that the number of neighbors at 0,0 is 2" do
      assert_equal 2, @game.num_living_neighbors_at(0,0)
    end
  end

  context "A 5x5 game" do
    setup do
      @game = game [
        [1, 1, 0, 1, 1],
        [1, 0, 0, 0, 1],
        [0, 0, 0, 0, 0],
        [1, 1, 0, 0, 1],
        [1, 0, 0, 0, 0]
      ]
    end

    should "be able to transition to its next expected state" do
      expected = [
        [1, 1, 0, 1, 1],
        [1, 1, 0, 1, 1],
        [1, 1, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 0, 0, 0]
      ]
      assert_equal expected, @game.next_state
    end
  end
end
