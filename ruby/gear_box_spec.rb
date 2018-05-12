require 'rspec'
require_relative 'gear_box'

describe GearBox do
  let(:gear_box) { described_class.new(gears) }

  describe '#initialize' do
    context 'without gears' do
      let(:gears) { [] }

      it do
        expect { described_class.new(gears) }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe 'gears shift' do
    subject(:shift_gear) do
      -> { gear_box.doit(rpm) }
    end

    let(:gears) do
      6.times.map { Gear.new(lower_bound: 500, upper_bound: 2000) }
    end

    context 'without rpm' do
      let(:rpm) { nil }

      it 'starts' do
        expect(shift_gear).to change(gear_box, :gear_number)
          .from(0).to(1)
      end
    end

    context 'when rpm is zero' do
      let(:rpm) { 0 }

      it 'starts' do
        expect(shift_gear).to change(gear_box, :gear_number)
          .from(0).to(1)
      end
    end

    context 'from 0 to 1' do
      let(:rpm) { 1 }

      it 'shifts gear' do
        expect(shift_gear).to change(gear_box, :gear_number)
          .from(0).to(1)
      end
    end

    context 'from 1 to 2' do
      let(:rpm) { 2_500 }

      before { shift_gear.() }

      it 'shifts gear' do
        expect(shift_gear).to change(gear_box, :gear_number)
          .from(1).to(2)
      end
    end

    context 'from 2 to 1' do
      let(:rpm) { 450 }

      before do
        2.times { gear_box.doit(2500) }
      end

      it 'shifts down' do
        expect(shift_gear).to change(gear_box, :gear_number)
          .from(2).to(1)
      end
    end

    context 'when gear is greater than 6' do
      let(:rpm) { 5_000 }

      before do
        10.times { shift_gear.() }
      end

      it 'does not exceed the upper limit' do
        expect(gear_box.gear_number).to eq(6)
      end
    end

    context 'when shifts down' do
      let(:rpm) { 200 }

      before do
        10.times { shift_gear.() }
      end

      it 'does not exceed the lower limit' do
        expect(gear_box.gear_number).to eq(1)
      end
    end
  end
end
