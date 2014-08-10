require 'test_helper'

require 'vedeu/models/composition'
require 'vedeu/models/attributes/interface_collection'
require 'vedeu/api/store'


module Vedeu
  describe InterfaceCollection do
    describe '#coerce' do
      before { API::Store.reset }

      it 'returns an empty collection when there are no interfaces' do
        composition = Composition.new
        composition.interfaces.must_equal([])
      end

      it 'returns a collection when there is a single interface' do
        Vedeu.interface('dumb') {}

        composition = Composition.new(
          {
            interfaces: { name: 'dumb' }
          }
        )
        composition.interfaces.first.must_be_instance_of(Interface)
      end

      it 'returns a collection when there are multiple interfaces' do
        Vedeu.interface('dumb')   {}
        Vedeu.interface('dumber') {}

        composition = Composition.new(
          {
            interfaces: [
              { name: 'dumb' },
              { name: 'dumber' }
            ]
          }
        )
        composition.interfaces.size.must_equal(2)
      end
    end
  end
end
