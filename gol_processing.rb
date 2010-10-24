# Gol Processing
require 'lib/gol'


class GolProcessing < Processing::App
  WIDTH       = 1024
  HEIGHT      = 1024
  VIDEOSCALE  = 16

  def setup
    @grid = game_from_lifewiki_text_file "/Users/light/Downloads/newgun2.cells"
    @cols = WIDTH / VIDEOSCALE
    @rows = HEIGHT / VIDEOSCALE
    @prev_state = nil

    color_mode RGB, 1.0
    frame_rate 3
    smooth

    white_out
  end
  
  def draw
    white_out

    @cols.times do |col_num|
      next if col_num >= @grid.length
      @rows.times do |row_num|
        next if row_num >= @grid[col_num].length
        next unless @grid[col_num][row_num] == 1
        fill 1.0, 1.0
        if col_num < @grid.length && @grid[col_num][row_num] == 1
          fill 0.3
        end
        x = col_num * VIDEOSCALE
        y = row_num * VIDEOSCALE
        rect x, y, VIDEOSCALE, VIDEOSCALE
      end
    end
    @prev_state = @grid
    @grid = @grid.next_state
  end

  def changed?(x, y)
    @prev_state && 
    @prev_state[x][y] != @grid[x][y]
  end

  def white_out
    fill 1.0, 1.0
    rect 0, 0, WIDTH, HEIGHT
  end
end

GolProcessing.new :title => "Gol Processing", :width => 1024, :height => 1024
