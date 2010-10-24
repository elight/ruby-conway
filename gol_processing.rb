# Gol Processing
require 'lib/gol'


class GolProcessing < Processing::App
  WIDTH       = 1024
  HEIGHT      = 1024
  VIDEOSCALE  = 4

  def setup
    @grid = game [
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
      [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1]
    ]
    @cols = WIDTH / VIDEOSCALE
    @rows = HEIGHT / VIDEOSCALE

    color_mode RGB, 1.0
    frame_rate 5
    fill 0.8, 0.6
    smooth
  end
  
  def draw
    @cols.times do |col_num|
      @rows.times do |row_num|
        fill 0.9
        x = col_num * VIDEOSCALE
        y = row_num * VIDEOSCALE
        stroke 0.0, 0.8
        if row_num < @grid.length && @grid[row_num][col_num] == 1
          fill 0.3
        end
        rect x, y, VIDEOSCALE, VIDEOSCALE
      end
    end
    @grid = @grid.next_state
  end
end

GolProcessing.new :title => "Gol Processing", :width => 1024, :height => 1024
