require 'rails_helper'

describe HappeningTemplatesController do

  describe '#index' do

    let(:user) { User.create! }
    let(:selected_user) { user }
    let(:current_user) { user }

    before do
      allow(session).to receive(:[]).with('flash').and_call_original
      allow(session).to receive(:[]).with(:_turbolinks_location).and_call_original

      allow(session).to receive(:[]).with(:selected_user_id).and_return(selected_user)
      allow(session).to receive(:[]).with(:current_user_id).and_return(current_user)
    end

    context 'without a current_user' do
      let(:current_user) { nil }

      it 'redirects' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    context 'without a selected_user' do
      let(:selected_user) { nil }
      it 'redirects' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    it "shows the selected-user's happening_templates" do
      happening_template = HappeningTemplate.create!
      user.happening_templates << happening_template

      # expect_any_instance_of(described_class).to receive(:selected_user).and_return(user)
      # expect_any_instance_of(described_class).to receive(:current_user).and_return(user)

      # allow(session).to receive('flash').and_call_original

      name

      get :index
      expect(response).to be_successful
    end
  end
end
