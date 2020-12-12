require 'rails_helper'

describe HappeningsController do
  describe '#create' do
    subject do
      template.users << happening_user
      expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(reporting_user)
      post :create, params: { user_id: happening_user.id, template_id: template.id }
    end

    let(:template) { HappeningTemplate.create!(point_value: 99) }
    let(:happening_user) { User.create! }
    let(:reporting_user) { User.create! }

    it 'redirects' do
      subject

      expect(response).to be_redirect
    end

    it 'creates a happening from a happening template' do
      template.users << happening_user

      expect { subject }.to change { Happening.count }.by 1
      expect(Happening.last.point_value).to eq template.point_value
    end

    it 'records the submitting_user' do
      template.users << happening_user

      expect { subject }.to change { Happening.count }.by 1
      expect(Happening.last.reporting_user).to eq reporting_user
    end
  end
end
