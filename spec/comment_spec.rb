require 'rails_helper'
describe Comment do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :picture }
end
