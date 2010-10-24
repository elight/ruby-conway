require 'helper'

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
