require 'rails_helper'

describe HappeningTemplatesController do
  describe '#index' do
    context 'without a selected user' do
      it 'redirects' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    it "shows the selected-user's happening_templates" do
      user = User.create!
      happening_template = HappeningTemplate.create!
      happening_template.users << user

      expect_any_instance_of(described_class).to receive(:selected_user).and_return(user)

      get :index
      expect(response.body).to include(happening_template.description)
    end
  end
end
