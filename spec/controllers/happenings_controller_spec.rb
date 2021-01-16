require 'rails_helper'

describe HappeningsController do
  describe '#index' do
    it 'works' do
      get :index
      expect(response).to be_successful
    end
  end

  describe '#grid_index' do
    it 'works' do
      get :grid_index
      expect(response).to be_successful
    end
  end

  describe '#create' do
    subject do
      # template.users << reportee_user
      # expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(reporting_user)
      post :create, params: { selected_user_id: reportee_user.id, reporting_user_id: reporting_user.id, template_id: template.id }
    end

    let(:template) { HappeningTemplate.create!(point_value: 99, user: reportee_user) }
    let(:reportee_user) { User.create! }
    let(:reporting_user) { User.create! }

    it 'redirects' do
      subject

      expect(response).to be_redirect
    end

    it 'creates a happening from a happening template' do
      expect { subject }.to change { Happening.count }.by 1
      expect(Happening.last.point_value).to eq template.point_value
    end

    it 'records the reporting and reportee users' do
      expect { subject }.to change { Happening.count }.by 1
      expect(Happening.last.reporting_user).to eq reporting_user
      expect(Happening.last.user).to eq reportee_user
    end
  end

  describe '#edit' do
    let(:happening) { Happening.create! }
    it 'works' do
      get :edit, params: { id: happening.id }
      expect(response).to be_successful
    end
  end
end
