require 'rspec'
require_relative 'gear_box'

describe GearBox do
  it 'works' do
    rpm = rand(5_000)

    expect { GearBox.new.doit(rpm) }.not_to raise_error
  end

  describe 'gears shift' do
    subject(:shift_gear) do
      -> { gear_box.doit(rpm) }
    end

    let(:gear_box) { described_class.new }

    context 'without rpm' do
      let(:rpm) { nil }

      it 'starts' do
        expect(shift_gear).to change(gear_box, :gear)
          .from(0).to(1)
      end
    end

    context 'when rpm is zero' do
      let(:rpm) { 0 }

      it 'starts' do
        expect(shift_gear).to change(gear_box, :gear)
          .from(0).to(1)
      end
    end

    context 'from 0 to 1' do
      let(:rpm) { 1 }

      it 'shifts gear' do
        expect(shift_gear).to change(gear_box, :gear)
          .from(0).to(1)
      end
    end

    context 'from 1 to 2' do
      let(:rpm) { 2_500 }

      before { shift_gear.() }

      it 'shifts gear' do
        expect(shift_gear).to change(gear_box, :gear)
          .from(1).to(2)
      end
    end

    context 'from 2 to 1' do
      let(:rpm) { 450 }

      before do
        2.times { gear_box.doit(2500) }
      end

      it 'shifts down' do
        expect(shift_gear).to change(gear_box, :gear)
          .from(2).to(1)
      end
    end

    context 'when gear is greater than 6' do
      let(:rpm) { 5_000 }

      before do
        10.times { shift_gear.() }
      end

      it 'does not exceed the upper limit' do
        expect(gear_box.gear).to eq(6)
      end
    end

    context 'when shifts down' do
      let(:rpm) { 200 }

      before do
        10.times { shift_gear.() }
      end

      it 'does not exceed the lower limit' do
        expect(gear_box.gear).to eq(1)
      end
    end
  end
end
