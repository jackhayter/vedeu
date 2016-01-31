# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    describe Border do

      let(:described) { Vedeu::DSL::Border }
      let(:instance)  { Class.include(described).new }
      let(:_name)     { :vedeu_dsl_border }

      describe '#border' do
        subject { instance.border(_name) {} }

        context 'when the name is not given' do
          let(:_name) {}

          it 'uses the name of the model' do
            # @todo Add more tests.
          end
        end

        context 'when the name is given' do
          # @todo Add more tests.
        end

        context 'when the block is not given' do
          subject { instance.border(_name) }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the block is given' do
          subject { instance.border { } }

          # @todo Add more tests.
        end
      end

      describe '#border!' do
        subject { instance.border! }

        # @todo Add more tests.
      end

    end # Border

  end # DSL

end # Vedeu