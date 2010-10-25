# Gol Processing
require 'lib/gol'


class GolProcessing < Processing::App
  WIDTH       = 1024
  HEIGHT      = 1024
  VIDEOSCALE  = 6

  def setup
    @grid = game_from_lifewiki_text_file "/Users/light/Downloads/gunstar.cells"
    @cols = WIDTH / VIDEOSCALE
    @rows = HEIGHT / VIDEOSCALE
    @gen = 0

    text_font create_font("Helvetica", 24), 24

    color_mode RGB, 1.0
    frame_rate 30
    smooth
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
    fill 0.3
    text "Gen: #{@gen}", 10, HEIGHT - 30, 200, 20
    @gen += 1
    @grid = @grid.next_state
  end

  def white_out
    fill 1.0, 1.0
    rect 0, 0, WIDTH, HEIGHT
  end
end

GolProcessing.new :title => "Gol Processing", :width => 1024, :height => 1024
