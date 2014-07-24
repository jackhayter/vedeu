require 'test_helper'
require 'vedeu/support/builder'

module Vedeu
  describe Builder do
    it 'creates and stores a new interface' do
      interface = Builder.build('widget') do
                    colour  foreground: '#ff0000', background: '#5f0000'
                    cursor  false
                    width   10
                    height  2
                    centred true
                  end
      interface.must_be_instance_of(Interface)
    end

    it 'overrides x and y when centred is true' do
      IO.console.stub :winsize, [10, 40] do
        interface = Builder.build('widget') do
                      colour  foreground: '#ff0000', background: '#5f0000'
                      cursor  false
                      centred true
                      width   10
                      height  2
                      x       5
                      y       5
                    end
        interface.x.must_equal(15)
        interface.y.must_equal(4)
      end
    end

    it 'uses x and y when centred is false' do
      interface = Builder.build('widget') do
                    colour  foreground: '#ff0000', background: '#5f0000'
                    cursor  false
                    centred false
                    width   10
                    height  2
                    x       5
                    y       5
                  end
      interface.x.must_equal(5)
      interface.y.must_equal(5)
    end

    it 'allows interfaces to share behaviour' do
      IO.console.stub :winsize, [10, 40] do
        main =    Builder.build('main') do
                    colour  foreground: '#ff0000', background: '#000000'
                    cursor  false
                    centred true
                    width   10
                    height  2
                  end
        status =  Builder.build('status') do
                    colour  foreground: 'aadd00', background: '#4040cc'
                    cursor  true
                    centred true
                    width   10
                    height  1
                    y       main.geometry.bottom
                    x       main.geometry.left
                  end

        main.x.must_equal(15)
        main.y.must_equal(4)
        status.x.must_equal(15)
        status.y.must_equal(5)
      end
    end
  end
end
