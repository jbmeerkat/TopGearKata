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
    let(:rpm) { nil }

    context 'from 0 to 1' do
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
  end
end
