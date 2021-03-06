def run_rule(args = {})
  state = args[:with_cell_state]
  neighbor_cnt = args[:and_num_neighbors]

  return 0 unless neighbor_cnt == 3 || 
                  neighbor_cnt == 2 && state == 1
  1
end

module GameOfLife
  def next_state
    x = 0
    self.map { |row|
      y = 0
      new_row = row.map do |cell|
        new_state = run_rule(:with_cell_state => self[x][y],
                             :and_num_neighbors => num_living_neighbors_at(x, y))
        y += 1
        new_state
      end
      x += 1
      new_row
    }.tap do |game|
      game.extend GameOfLife
    end
  end

  def num_living_neighbors_at(x, y)
    result = 0
    (-1..1).each do |x1|
      (-1..1).each do |y1|
        next if (x1 == 0 && y1 == 0) || !is_inbound(x + x1, y + y1)
        result += 1 if self[x + x1][y + y1] == 1
      end
    end
    result
  end

  def is_inbound(x, y)
    (x_in_bounds = x >= 0 && x < self.length) &&
    (y_in_bounds = y >= 0 && y < self[x].length)
  end
end

def game(initial_state)
  initial_state.tap do |board|
    board.extend GameOfLife
  end
end

def game_from_lifewiki_text_file(filename)
  lines = nil
  File.open(filename) do |file|
    lines = file.readlines
  end
  lines = lines.reject { |l| l =~ /^\!/ }
  num_rows = lines.length + 2
  num_cols = lines.inject("") { |max, l| max = l if l.length > max.length; max }.chop.length + 2
  Array.new(num_cols) { Array.new(num_rows) { 0 } }.tap do |grid|
    lines.each_with_index do |line, y|
      line.chop!
      line.length.times do |x| 
        if line[x].chr == "O"
          grid[x+1][y+1] = 1
        end
      end
    end
    grid.extend GameOfLife
  end
end

