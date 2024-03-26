require "rails_helper"

RSpec.describe Vendor, type: :model do 
	describe "relationships" do 
		it { should have_many(:market_vendors) }
		it { should have_many(:markets).through(:market_vendors)  }
	end

	describe "validations" do 
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:description) }
		it { should validate_presence_of(:contact_name) }
		it { should validate_presence_of(:contact_phone) }
		it { should validate_inclusion_of(:credit_accepted).in_array([true, false]) }
		# it { should validate_presence_of(:credit_accepted) }
	end
end

# >>>>> GETTING ERROR WHEN VALIDATING `PRESENCE_OF` :CREDIT_ACCEPTED AND EXECUTION STOPS <<<<<<
# >>>>> GET WARNING WHEN USING `INCLUSION_OF, BUT TEST PASSES AND PROGRAM CONTINUES EXECUTION <<<<<<
# >>>>> MY QUESTION IS...WTF?? <<<<<<


# *************************************************************************
# Got the below warning when I used `validate_inclusion_of` to test if boolean

# Warning from shoulda-matchers:

# You are using `validate_inclusion_of` to assert that a boolean column
# allows boolean values and disallows non-boolean ones. Be aware that it
# is not possible to fully test this, as boolean columns will
# automatically convert non-boolean values to boolean ones. Hence, you
# should consider removing this test.
# ************************************************************************