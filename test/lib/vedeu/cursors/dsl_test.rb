require 'test_helper'

module Vedeu

  module Cursors

    describe DSL do

      let(:described) { Vedeu::Cursors::DSL }

      # describe '#cursor' do
      #   let(:_value) {}

      #   before { Vedeu.cursors.reset }

      #   subject { instance.cursor(_value) }

      #   it do
      #     subject
      #     Vedeu.cursors.find('actinium').visible?.must_equal(false)
      #   end

      #   context 'when the value is false' do
      #     let(:_value) { false }

      #     it do
      #       subject
      #       Vedeu.cursors.find('actinium').visible?.must_equal(false)
      #     end
      #   end

      #   context 'when the value is nil' do
      #     let(:_value) {}

      #     it do
      #       subject
      #       Vedeu.cursors.find('actinium').visible?.must_equal(false)
      #     end
      #   end

      #   context 'when the value is :show' do
      #     let(:_value) { :show }

      #     it do
      #       subject
      #       Vedeu.cursors.find('actinium').visible?.must_equal(true)
      #     end
      #   end

      #   context 'when the value is true' do
      #     let(:_value) { true }

      #     it do
      #       subject
      #       Vedeu.cursors.find('actinium').visible?.must_equal(true)
      #     end
      #   end

      #   context 'when the value is :yes' do
      #     let(:_value) { :yes }

      #     it do
      #       subject
      #       Vedeu.cursors.find('actinium').visible?.must_equal(true)
      #     end
      #   end
      # end

      # describe '#cursor!' do
      #   subject { instance.cursor! }

      #   it do
      #     subject
      #     Vedeu.cursors.find('actinium').visible?.must_equal(true)
      #   end
      # end

      # describe '#no_cursor!' do
      #   subject { instance.no_cursor! }

      #   it do
      #     subject
      #     Vedeu.cursors.find('actinium').visible?.must_equal(false)
      #   end
      # end

    end # DSL

  end # Cursors

end # Vedeu
