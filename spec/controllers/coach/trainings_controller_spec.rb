require 'rails_helper'

RSpec.describe Coach::TrainingsController, type: :controller do
  let(:coach) { create(:benutzer, :coach) }
  let!(:training) { create(:training, benutzer: coach) }

  before do
    sign_in coach
  end

  describe 'GET #show' do
    it 'assigns the requested training to @training' do
      get :show, params: { id: training.id }
      expect(assigns(:training)).to eq(training)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Training to @training' do
      get :new
      expect(assigns(:training)).to be_a_new(Training)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Training' do
        expect {
          post :create, params: { training: attributes_for(:training) }
        }.to change(Training, :count).by(1)
      end

      it 'redirects to the trainings index' do
        post :create, params: { training: attributes_for(:training) }
        expect(response).to redirect_to(coach_trainings_path)
      end
    end

    context 'with invalid params' do
      it 're-renders the new template' do
        post :create, params: { training: attributes_for(:training, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'New Title' } }

      it 'updates the requested training' do
        put :update, params: { id: training.id, training: new_attributes }
        training.reload
        expect(training.title).to eq('New Title')
      end

      it 'redirects to the trainings index' do
        put :update, params: { id: training.id, training: new_attributes }
        expect(response).to redirect_to(coach_trainings_path)
      end
    end

    context 'with invalid params' do
      it 're-renders the edit template' do
        put :update, params: { id: training.id, training: attributes_for(:training, title: nil) }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested training' do
      expect {
        delete :destroy, params: { id: training.id }
      }.to change(Training, :count).by(-1)
    end

    it 'redirects to the trainings list' do
      delete :destroy, params: { id: training.id }
      expect(response).to redirect_to(coach_trainings_path)
    end
  end
end