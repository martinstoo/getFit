require 'rails_helper'

RSpec.describe Coach::UebungsController, type: :controller do
  let(:coach) { create(:benutzer, :coach) }
  let!(:uebung) { create(:uebung, benutzer: coach) }

  before do
    sign_in coach
  end

  describe 'GET #index' do
    it 'assigns @uebungs and renders the index template' do
      get :index
      expect(assigns(:uebungs)).to eq([uebung])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested uebung to @uebung' do
      get :show, params: { id: uebung.id }
      expect(assigns(:uebung)).to eq(uebung)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Uebung to @uebung' do
      get :new
      expect(assigns(:uebung)).to be_a_new(Uebung)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Uebung' do
        expect {
          post :create, params: { uebung: attributes_for(:uebung) }
        }.to change(Uebung, :count).by(1)
      end

      it 'redirects to the uebungs index' do
        post :create, params: { uebung: attributes_for(:uebung) }
        expect(response).to redirect_to(coach_uebungs_path)
      end
    end

    context 'with invalid params' do
      it 're-renders the new template' do
        post :create, params: { uebung: attributes_for(:uebung, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'New Title' } }

      it 'updates the requested uebung' do
        put :update, params: { id: uebung.id, uebung: new_attributes }
        uebung.reload
        expect(uebung.title).to eq('New Title')
      end

      it 'redirects to the uebungs index' do
        put :update, params: { id: uebung.id, uebung: new_attributes }
        expect(response).to redirect_to(coach_uebungs_path)
      end
    end

    context 'with invalid params' do
      it 're-renders the edit template' do
        put :update, params: { id: uebung.id, uebung: attributes_for(:uebung, title: nil) }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested uebung' do
      expect {
        delete :destroy, params: { id: uebung.id }
      }.to change(Uebung, :count).by(-1)
    end

    it 'redirects to the uebungs list' do
      delete :destroy, params: { id: uebung.id }
      expect(response).to redirect_to(coach_uebungs_path)
    end
  end
end