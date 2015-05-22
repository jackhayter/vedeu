require 'test_helper'

module Vedeu

  describe Groups do

    let(:described) { Vedeu::Groups }

    describe '.groups' do
      subject { described.groups }

      it { subject.must_be_instance_of(described) }
    end

    describe '#by_name' do
      let(:_name) { 'carbon' }

      subject { described.groups.by_name(_name) }

      context 'when the group exists' do
        before do
          Vedeu.group 'carbon' do
          end
        end
        after { Vedeu.groups.reset }

        it { subject.must_be_instance_of(Vedeu::Group) }
      end

      context 'when the group does not exist' do
        let(:_name) { 'nitrogen' }

        it { subject.must_be_instance_of(Vedeu::Group) }
      end
    end

  end # Groups

end # Vedeu