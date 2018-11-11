require 'rails_helper'

RSpec.describe OperationsHelper, type: :helper do
  let!(:operation) { create(:operation) }

  describe '#sanitize_params' do
    it "returns proper hash" do
      result = {
        "comment"=> "My Comment",
        "operation_type"=> "expense",
        "user_id"=> operation.user_id,
        "account_id"=> operation.account_id,
        "category_id"=> operation.category_id,
        "paid_at"=> Date.current,
        "value"=> "100.0"
      }
      expect(helper.sanitize_params(operation)).to eq(result)
    end
  end
end
