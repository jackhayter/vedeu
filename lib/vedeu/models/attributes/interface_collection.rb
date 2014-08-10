require 'virtus'

require 'vedeu/api/store'

# Todo: mutation (persistence)

module Vedeu
  class InterfaceCollection < Virtus::Attribute
    def coerce(values)
      return [] if values.nil? || values.empty?

      [values].flatten.map do |buffer_attributes|
        interface_attributes = API::Store.query(buffer_attributes[:name])

        Interface.new(buffer_attributes.merge!(interface_attributes))
      end
    end
  end
end
