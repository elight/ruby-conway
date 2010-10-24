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
