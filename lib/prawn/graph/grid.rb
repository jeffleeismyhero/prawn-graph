module Prawn
  module Chart
    
    # Prawn::Chart::Grid represents the area whcih your data will be plotted. It
    # is drawn before your data is plotted and serves to mark where the axes of
    # your plot will be and to give an indication of scale.
    #
    class Grid

      attr_accessor :width, :height, :point, :spacing, :marker_points, :document

      def initialize(grid_x_start, grid_y_start, grid_width, grid_height, spacing, marker_points, document, theme, reverse_y=false)
        @point = [grid_x_start, grid_y_start]
        @width = grid_width
        @height = grid_height
        @spacing = spacing
        @marker_points = marker_points
        @document = document
        @theme = theme
        @reverse_y = reverse_y
      end

      def start_x; @point.first; end
      def start_y; @point.last; end

      # Draws the Grid on the specified Prawn::Document
      #
      def draw
        @document.stroke_color @theme.marker_colour
        if @theme.stroke_grid_markers?
          if @marker_points
            @marker_points.each do |offset_fraction|
              offset = offset_fraction * self.height
              offset = @height - offset if @reverse_y
              @document.move_to [@point.first, (@point.last + offset)]
              @document.line_width(0.25)
              @document.stroke_line_to([(@point.first + @width), (@point.last + offset)])
            end
          else
            (@height / @spacing).times do |x|
              offset = @spacing * (x + 1)
              offset = @height - offset if @reverse_y
              @document.move_to [@point.first, (@point.last + offset)]
              @document.line_width(0.5)
              @document.stroke_line_to([(@point.first + @width), (@point.last + offset)])
            end
          end
        end
        @document.move_to @point
        @document.line_width(1)
        @document.stroke_line_to([@point.first, @point.last + @height])
        @document.move_to @reverse_y ? [@point.first, @point.last + @height] : @point
        @document.line_width(1)
        @document.stroke_line_to([(@point.first + @width), @reverse_y ? (@point.last + @height) : @point.last])
        @document.move_to @point.first, (@point.last + height)
        @document.stroke_color '000000'
        @document.line_width(0.5)
        @document.move_to @point
      end

    end
  end
end
