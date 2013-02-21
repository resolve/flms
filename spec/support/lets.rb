def test_helpers
  let(:user_1) { create :user }
  let(:user_2) { create :user }
  let(:page_1) { create :page }

  let(:default_access_granted_check) { response.success? }
end
