def test_helpers
  let(:block_1) { create :block }
  let(:block_2) { create :block }
  let(:page_1) { create :page }
  let(:user_1) { create :user }
  let(:user_2) { create :user }

  let(:default_access_granted_check) { response.success? }
end
