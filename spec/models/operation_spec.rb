require 'rails_helper'

RSpec.describe Operation, type: :model do
  let!(:user) { create(:user) }
  let!(:account) { create(:account, user: user) }
  let!(:account2) { create(:account, user: user) }
  let!(:category) { Category.create(name: 'Test') }

  describe 'when operation is expense' do
    subject { described_class.new(value: 50.00,
                                  operation_type: 'expense',
                                  category: category,
                                  account: account,
                                  user: user) }

    it 'creates new operation' do
      expect { subject.save }.to change { Operation.count }.by(1)
    end

    describe 'created operation' do
      before { subject.save }

      let(:operation) { Operation.last }

      it 'sets proper value' do
        expect(operation.value_cents).to eq(-5000)
      end

      it 'sets proper account balance' do
        expect(operation.account.balance_cents).to eq(-5000)
      end
    end
  end

  describe 'when operation is income' do
    subject { described_class.new(value: 50.00,
                                  operation_type: 'income',
                                  category: category,
                                  account: account,
                                  user: user) }

    it 'creates new operation' do
      expect { subject.save }.to change { Operation.count }.by(1)
    end

    describe 'created operation' do
      before { subject.save }

      let(:operation) { Operation.last }

      it 'sets proper value' do
        expect(operation.value_cents).to eq(5000)
      end

      it 'sets proper account balance' do
        expect(operation.account.balance_cents).to eq(5000)
      end
    end
  end

  describe 'when operation is transfer' do
    context 'target account is present and operation type is transfer' do
      subject { described_class.new(value: 50.00,
                                    operation_type: 'transfer',
                                    category: category,
                                    account: account,
                                    target_account: account2.id,
                                    user: user) }

      it 'creates two operations' do
        expect { subject.save }.to change { Operation.count }.by(2)
      end

      describe 'created operations' do
        before { subject.save }

        let(:operations) { Operation.all.order(created_at: :desc).limit(2) }

        it 'sets proper value' do
          values = operations.map { |operation| operation.value_cents }
          expect(values).to match_array([5000, -5000])
        end

        it 'sets proper operation types' do
          values = operations.map { |operation| operation.operation_type }
          expect(values).to match_array(['expense', 'income'])
        end

        it 'sets proper account1 balance' do
          expect(account.reload.balance_cents).to eq(-5000)
        end

        it 'sets proper account2 balance' do
          expect(account2.reload.balance_cents).to eq(5000)
        end
      end
    end

    context 'target account is present and operation type is not transfer' do
      subject { described_class.new(value: 50.00,
                                    operation_type: 'expense',
                                    category: category,
                                    account: account,
                                    target_account: account2.id,
                                    user: user) }

      it 'does NOT create operations' do
        expect { subject.save }.not_to change { Operation.count }
      end
    end

    context 'target account is not present and operation type is transfer' do
      subject { described_class.new(value: 50.00,
                                    operation_type: 'expense',
                                    category: category,
                                    account: account,
                                    target_account: account2.id,
                                    user: user) }

      it 'does NOT create operations' do
        expect { subject.save }.not_to change { Operation.count }
      end
    end
  end
end
