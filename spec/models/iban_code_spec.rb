require 'rails_helper'
RSpec.describe Iban, type: :model do
  subject { Iban.new }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
end
