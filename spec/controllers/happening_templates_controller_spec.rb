require 'rails_helper'

describe HappeningTemplatesController do

  let(:user) { User.create! }
  let(:selected_user) { user }
  let(:current_user) { user }

  before do
    allow(session).to receive(:[]).with('flash').and_call_original
    allow(session).to receive(:[]).with(:_turbolinks_location).and_call_original

    allow(session).to receive(:[]).with(:selected_user_id).and_return(selected_user&.id)
    allow(session).to receive(:[]).with(:current_user_id).and_return(current_user&.id)
  end

  describe '#index' do

    it 'renders' do
      get :index
      expect(response).to be_successful
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
  end

  describe "#create" do
    it 'creates a HappeningTemplate on the selected user' do
      params = { 'happening_template' => { "user_id" => selected_user.id, "name" => "derp", "kind" => "good_habit", "point_value" => "1", "description" => "", "show_success_button" => "1", "show_pass_button" => "0", "show_fail_button" => "0", "allowed_entries_daily_count" => "" } }
      expect { post :create, params: params }.to change { HappeningTemplate.count }.by(1)
      expect(HappeningTemplate.last.name).to eq 'derp'
    end
  end

  describe '#destroy' do
    it 'destroys the template' do
      happening_template = HappeningTemplate.create(user: selected_user)
      expect { post :destroy, params: { id: happening_template.id } }.to change { HappeningTemplate.count }.by(-1)
    end

  end
end
