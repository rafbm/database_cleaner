RSpec.shared_examples_for "a database_cleaner strategy" do
  it { is_expected.to respond_to(:db)  }
  it { is_expected.to respond_to(:db=)  }
  it { is_expected.to respond_to(:start) }
  it { is_expected.to respond_to(:clean) }
  it { is_expected.to respond_to(:cleaning) }
end

RSpec.shared_examples_for "a database_cleaner adapter" do
  it { expect(described_class).to respond_to(:available_strategies) }
  it { expect(described_class).to respond_to(:default_strategy) }

  it 'default_strategy should be part of available_strategies' do
    expect(described_class.available_strategies).to include(described_class.default_strategy)
  end

  describe 'all strategies should adhere to a database_cleaner strategy interface' do
    described_class.available_strategies.each do |strategy|
      subject { described_class.const_get(strategy.to_s.capitalize).new }

      it_behaves_like 'a database_cleaner strategy'
    end
  end
end
