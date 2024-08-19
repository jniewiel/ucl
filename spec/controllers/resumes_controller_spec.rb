# spec/controllers/resumes_controller_spec.rb

require 'rails_helper'

RSpec.describe ResumesController, type: :controller do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: resume.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Resume" do
        expect {
          post :create, params: { resume: attributes_for(:resume, user_id: user.id) }
        }.to change(Resume, :count).by(1)
      end

      it "redirects to the created resume" do
        post :create, params: { resume: attributes_for(:resume, user_id: user.id) }
        expect(response).to redirect_to(Resume.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., renders the `new` template)" do
        post :create, params: { resume: { resume: nil } }
        expect(response).to render_template(:new)
      end  
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: resume.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the requested resume" do
        patch :update, params: { id: resume.id, resume: { resume: "Updated content" } }
        resume.reload
        expect(resume.resume).to eq("Updated content")
      end      

      it "redirects to the resume" do
        patch :update, params: { id: resume.id, resume: { content: "Updated content" } }
        expect(response).to redirect_to(resume)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., renders the `edit` template)" do
        patch :update, params: { id: resume.id, resume: { resume: nil } }
        expect(response).to render_template(:edit)
      end    
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested resume" do
      resume  # Ensure the resume is created before deletion
      expect {
        delete :destroy, params: { id: resume.id }
      }.to change(Resume, :count).by(-1)
    end

    it "redirects to the resumes list" do
      delete :destroy, params: { id: resume.id }
      expect(response).to redirect_to(resumes_path)
    end
  end
end
