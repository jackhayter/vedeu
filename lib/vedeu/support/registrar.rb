module Vedeu

  class Registrar

    include Common

    # @param attributes [Hash]
    # @return [TrueClass|]
    def self.record(attributes = {})
      new(attributes).record
    end

    # @param attributes [Hash]
    # @return [Registrar]
    def initialize(attributes = {})
      @attributes = attributes
    end

    # @return [TrueClass|MissingRequired]
    def record
      validate_attributes!

      Vedeu::Buffers.add(attributes)

      Vedeu::Interfaces.add(attributes)
      Vedeu::Refresh.add_interface(attributes)

      Vedeu::Groups.add(attributes)
      Vedeu::Refresh.add_group(attributes)

      Vedeu::Focus.add(attributes)

      true
    end

    private

    attr_reader :attributes

    # At present, validates that attributes has a `:name` key that is not nil or
    # empty.
    #
    # @api private
    # @return [TrueClass|MissingRequired]
    def validate_attributes!
      return exception unless attributes.key?(:name)
      return exception unless defined_value?(attributes[:name])

      true
    end

    # Raises the MissingRequired exception.
    #
    # @see Vedeu::MissingRequired
    def exception
      fail MissingRequired, 'Cannot store data without a name attribute.'
    end

  end

end
