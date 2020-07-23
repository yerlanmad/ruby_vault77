RSpec.describe CargoCar do
  let!(:railcar) { CargoCar.new(5_000) }
  
  before { railcar.fill(3_000) }
  
  describe '#capacity' do
    it 'returns capacity' do
      expect(railcar.capacity).to eq 5_000
    end
  end

  describe '#type' do
    it 'returns type' do
      expect(railcar.type).to eq 'Cargo'
    end
  end

  describe '#occupied_volume' do
    it 'returns occuped volume' do
      expect(railcar.occupied_volume).to eq 3_000
    end
  end
  
  describe '#fill' do
    it 'fills railcar' do
      railcar.fill(1_000)

      expect(railcar.occupied_volume).to eq 4_000
    end
  end

  describe '#empty_volume' do
    it 'returns empty volume' do
      expect(railcar.empty_volume).to eq 2_000
    end
  end
end
