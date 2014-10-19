require 'test_helper'

module Vedeu
  describe Area do
    let(:area)   { Area.new(attributes) }
    let(:attributes) {
      {
        y_min:  1,
        x_min:  1,
        height: 3,
        width:  3,
      }
    }

    describe '#initialize' do
      it 'returns an instance of itself' do
        area.must_be_instance_of(Area)
      end
    end

    describe '#y_range' do
      let(:attributes) { { y_min: 7, x_min: 1, height: 4, width: 3 } }

      it 'returns the actual y range' do
        area.y_range.must_equal([7, 8, 9, 10])
      end

      context 'when the height is 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 0, width: 3 } }

        it 'returns an empty range' do
          area.y_range.must_equal([])
        end
      end
    end

    describe '#x_range' do
      let(:attributes) { { y_min: 1, x_min: 4, height: 3, width: 10 } }

      it 'returns the actual x range' do
        area.x_range.must_equal([4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
      end

      context 'when the width is 0' do
        let(:attributes) { { y_min: 1, x_min: 4, height: 3, width: 0 } }

        it 'returns an empty range' do
          area.x_range.must_equal([])
        end
      end
    end

    describe '#y_indices' do
      let(:attributes) { { y_min: 7, x_min: 1, height: 4, width: 3 } }

      it 'returns the indices for y' do
        area.y_indices.must_equal([0, 1, 2, 3])
      end

      context 'when the height is 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 0, width: 3 } }

        it { area.y_indices.must_be_empty }
      end

      context 'when the height is less than 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: -3, width: 3 } }

        it { area.y_indices.must_be_empty }
      end
    end

    describe '#x_indices' do
      let(:attributes) { { y_min: 1, x_min: 4, height: 3, width: 10 } }

      it 'returns the indices for x' do
        area.x_indices.must_equal([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
      end

      context 'when the width is 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 3, width: 0 } }

        it { area.x_indices.must_be_empty }
      end

      context 'when the width is less than 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 3, width: -2 } }

        it { area.x_indices.must_be_empty }
      end
    end

    describe '#y_max' do
      context 'when the height is > 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 3, width: 6 } }

        it { area.y_max.must_equal(10) }
      end

      context 'when the height is 0 or negative' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 0, width: 6 } }

        it { area.y_max.must_equal(0) }
      end
    end

    describe '#x_max' do
      context 'when the width is > 0' do
        let(:attributes) { { y_min: 9, x_min: 1, height: 3, width: 6 } }

        it { area.x_max.must_equal(7) }
      end

      context 'when the width is 0 or negative' do
        let(:attributes) { { y_min: 9, x_min: 1, height: 3, width: 0 } }

        it { area.x_max.must_equal(0) }
      end
    end

    describe '#y_max_index' do
      context 'when the height is > 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 3, width: 6 } }

        it { area.y_max_index.must_equal(2) }
      end

      context 'when the height is 0' do
        let(:attributes) { { y_min: 7, x_min: 1, height: 0, width: 6 } }

        it { area.y_max_index.must_equal(0) }
      end

      context 'when the height is < 0' do
        let(:attributes) { { y_min: 9, x_min: 1, height: -3, width: 6 } }

        it { area.y_max_index.must_equal(0) }
      end
    end

    describe '#x_max_index' do
      context 'when the width is > 0' do
        let(:attributes) { { y_min: 9, x_min: 1, height: 3, width: 6 } }

        it { area.x_max_index.must_equal(5) }
      end

      context 'when the width is 0' do
        let(:attributes) { { y_min: 9, x_min: 1, height: 3, width: 0 } }

        it { area.x_max_index.must_equal(0) }
      end

      context 'when the width is < 0' do
        let(:attributes) { { y_min: 9, x_min: 1, height: 3, width: -2 } }

        it { area.x_max_index.must_equal(0) }
      end
    end

    describe '#y_index' do
      let(:attributes) { { y_min: 7, x_min: 4, height: height, width: 10, x: 8, y: y } }
      let(:height) { 3 }
      let(:y) { 8 }

      it 'returns the offset index of the cursors y position' do
        area.y_index.must_equal(1)
      end

      context 'when the area height is 0' do
        let(:height) { 0 }

        it { area.y_index.must_equal(0) }
      end

      context 'when the cursor y is less than or equal to the area y_min' do
        let(:y) { 6 }

        it { area.y_index.must_equal(0) }
      end

      context 'when the cursor y is more than or equal to the area y_max' do
        let(:y) { 20 }

        it 'returns the last y coordinate as an index' do
          area.y_index.must_equal(2)
        end
      end
    end

    describe '#x_index' do
      let(:attributes) { { y_min: 7, x_min: 4, height: 3, width: width, x: x, y: 8 } }
      let(:x) { 8 }
      let(:width) { 10 }

      it 'returns the offset index of the cursors x position' do
        area.x_index.must_equal(4)
      end

      context 'when the area width is 0' do
        let(:width) { 0 }

        it { area.x_index.must_equal(0) }
      end

      context 'when the cursor x is less than or equal to the area x_min' do
        let(:x) { 3 }

        it { area.x_index.must_equal(0) }
      end

      context 'when the cursor x is more than or equal to the area x_min' do
        let(:x) { 20 }

        it 'returns the last x coordinate as an index' do
          area.x_index.must_equal(9)
        end
      end
    end

    describe '#y_position' do
      context 'when the index is less than or equal to 0' do
        it 'returns #y_min' do

        end
      end

      context 'when the index is greater than or equal to y_max_index' do
        it 'returns #y_max' do

        end
      end

      context 'when the index is in range' do
        it 'returns the associated real position' do

        end
      end
    end

  end
end