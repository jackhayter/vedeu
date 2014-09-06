require 'test_helper'

module Vedeu
  describe Line do
    let(:line)       { Line.new(attributes) }
    let(:attributes) {
      {
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        streams: [],
        style:   'normal',
        parent:  nil,
      }
    }

    describe '#initialize' do
      it 'returns an instance of itself' do
        Line.new(attributes).must_be_instance_of(Line)
      end
    end

    describe '#attributes' do
      it 'returns the attributes' do
        line.attributes.must_equal(attributes)
      end
    end

    describe '#streams' do
      it 'has a streams attribute' do
        line.streams.must_equal([])
      end
    end

    describe '#to_s' do
      it 'returns a String' do
        line.to_s.must_equal(
          "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
          "\e[24m\e[22m\e[27m"
        )
      end
    end
  end
end
