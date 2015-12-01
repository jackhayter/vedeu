require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_clear_view_).must_equal(true) }
    it { Vedeu.bound?(:_clear_view_content_).must_equal(true) }
  end

  module Interfaces

    describe Clear do

      let(:described) { Vedeu::Interfaces::Clear }
      let(:instance)  { described.new(_name, options) }
      let(:options)   {
        {
          content_only: false,
          direct:       false,
        }
      }
      let(:_name)     { 'Vedeu::Interfaces::Clear' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.render' do
        it { described.must_respond_to(:by_name) }
        it { described.must_respond_to(:clear_by_name) }
        it { described.must_respond_to(:render) }
      end

      describe '#render' do
        let(:interface) {
          Vedeu::Interfaces::Interface.new(name: _name, visible: visible)
        }
        let(:visible)   { true }
        let(:geometry)  {
          Vedeu::Geometries::Geometry.new(name: _name, x: 1, y: 1, xn: 2, yn: 2)
        }
        let(:output) {
          [
            [
              Vedeu::Views::Char.new(name: _name, value: ' ', position: [1, 1]),
              Vedeu::Views::Char.new(name: _name, value: ' ', position: [1, 2]),
            ], [
              Vedeu::Views::Char.new(name: _name, value: ' ', position: [2, 1]),
              Vedeu::Views::Char.new(name: _name, value: ' ', position: [2, 2]),
            ]
          ]
        }

        before do
          Vedeu.interfaces.stubs(:by_name).returns(interface)
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          Vedeu.stubs(:render_output).returns(output)
        end

        subject { instance.render }

        it { subject.must_be_instance_of(Array) }
        it do
          Vedeu.expects(:render_output).with(output)
          subject
        end
        it { subject.must_equal(output) }
      end

    end # Clear

  end # Interfaces

end # Vedeu
