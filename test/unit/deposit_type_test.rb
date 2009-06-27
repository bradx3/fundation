require 'test_helper'

class DepositTypeTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :deposit_type_accounts


  context "an existing deposit type" do
    setup do 
      Factory.create(:deposit_type)
    end

    should_validate_uniqueness_of :name
  end

end
