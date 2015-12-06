module Vedeu

  module Borders

    # When a {Vedeu::Borders::Border} has a title, truncate it if the
    # title is longer than the interface is wide, and pad with a space
    # either side.
    #
    # The title is displayed within the top border of the interface/
    # view.
    #
    # @api private
    #
    class Title

      include Vedeu::Common

      # @param (see #initialize)
      # @return (see #render)
      def self.render(name, value = '', horizontal = [])
        new(name, value, horizontal).render
      end

      # Returns a new instance of Vedeu::Borders::Title or
      # Vedeu::Borders::Caption.
      #
      # @param name [String|Symbol]
      # @param value [String|Vedeu::Borders::Title|
      # @param horizontal [Array<Vedeu::Cells::Horizontal>]
      #   Vedeu::Borders::Caption]
      # @return [Vedeu::Borders::Title|Vedeu::Borders::Caption]
      def initialize(name, value = '', horizontal = [])
        @name       = name
        @value      = value
        @horizontal = horizontal
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Borders::Title|Vedeu::Borders::Caption]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # Overwrite the border from
      # {Vedeu::Borders::Border#build_horizontal} on the top border to
      # include the title if given.
      #
      # @return [Array<Vedeu::Cells::Horizontal|Vedeu::Cells::Char>]
      def render
        return horizontal if empty?

        horizontal[start_index..(start_index + (size - 1))] = chars

        horizontal
      end

      # Convert the value to a string.
      #
      # @return [String]
      def to_s
        value.to_s
      end
      alias_method :to_str, :to_s

      # Return the value (a title or a caption) or an empty string.
      #
      # @return [String]
      def value
        @value || ''
      end
      alias_method :title, :value
      alias_method :caption, :value

      protected

      # @!attribute [r] horizontal
      # @return [Array<Vedeu::Cells::Horizontal>] An array of border
      #   characters.
      attr_reader :horizontal

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      private

      # @param char [String]
      # @param x [Fixnum]
      # @return [Hash<Symbol => void>]
      def attributes(char, x)
        @_attributes ||= border.attributes

        @_attributes.merge!(position: Vedeu::Geometries::Position.new(y, x),
                            value:    char)
      end

      # @return [Vedeu::Borders::Border]
      def border
        @_border ||= Vedeu.borders.by_name(name)
      end

      # @return [Array<Vedeu::Cells::Horizontal|Vedeu::Cells::Char>]
      def chars
        characters.each_with_index.map do |char, index|
          Vedeu::Cells::Char.new(attributes(char, x + index))
        end
      end

      # Return the padded, truncated value as an Array of String.
      #
      # @return [Array<String>]
      def characters
        pad.chars
      end

      # Return boolean indicating whether the value is empty.
      #
      # @return [Boolean]
      def empty?
        value.empty?
      end

      # @return [Vedeu::Geometries::Geometry]
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # Pads the value with a single whitespace either side.
      #
      # @example
      #   value = 'Truncated!'
      #   width = 20
      #   # => ' Truncated! '
      #
      #   width = 10
      #   # => ' Trunca '
      #
      # @return [String]
      # @see #truncate
      def pad
        truncate.center(truncate.size + 2)
      end

      # Return the size of the padded, truncated value.
      #
      # @return [Fixnum]
      def size
        pad.size
      end

      # @return [Fixnum]
      def start_index
        1
      end

      # Truncates the value to the width of the interface, minus
      # characters needed to ensure there is at least a single
      # character of horizontal border and a whitespace on either side
      # of the value.
      #
      # @example
      #   value = 'Truncated!'
      #   width = 20
      #   # => 'Truncated!'
      #
      #   width = 10
      #   # => 'Trunca'
      #
      # @return [String]
      def truncate
        @_truncate ||= value.chomp.slice(0...(width - 4))
      end

      # Return the size of the horizontal border given.
      #
      # @return [Fixnum]
      def width
        horizontal.size
      end

      # @return [Fixnum]
      def x
        @_x ||= geometry.bx + start_index
      end

      # @return [Fixnum]
      def y
        @_y ||= geometry.y
      end

    end # Title

  end # Borders

end # Vedeu