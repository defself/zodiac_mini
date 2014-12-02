require 'rails_helper'

describe SessionsController do
  render_views

  let(:zodiac) { Zodiac.all[rand 12] }
  let(:user)   { create :user, zodiac: zodiac }

  before { sign_in user }

  describe "GET new" do

    context "when successfully" do
      before do
        sign_out user
        get :new
      end

      it { expect(response).to be_success }
      it { expect(assigns(:session)).to be_a_new Session }
    end

    context "when is authorized" do
      before { get :new }

      it { expect(response).to redirect_to(users_path) }
    end
  end

  describe "POST create" do
    before { sign_out user }

    context "when successfully" do
      let(:session_params) {{ email: user.email, password: user.password }}

      it "creates a session" do
        expect { post :create, session: session_params }.to change(Session, :count).by 1
        expect(response).to be_success
        expect(assigns(:user)).to eq(user)
        expect(flash[:success]).to be_present
        expect(session[:user_id]).to eq user.id
      end
    end

    context "when failure" do
      let(:session_params) {{ email: user.email, password: "invalid" }}

      it "doesn't create a session" do
        expect { post :create, session: session_params }.to_not change(Session, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(flash[:error]).to be_present
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE destroy" do
    context "when successfully" do
      it "deletes a session" do
        expect { delete :destroy, id: user.id }.to change(Session, :count).by -1
        expect(response).to be_success
        expect(flash[:success]).to be_present
        expect(session[:user_id]).to be_nil
      end
    end

    context "when is not authorized" do
      before do
        sign_out user
        delete :destroy, id: user.id
      end

      it { expect(response).to redirect_to(root_path) }
      it { expect(flash[:error]).to eq "First log in to use the web site" }
    end

    context "when failure" do
      before do
        sign_out user
        controller.stub(:signed_in?) { true }
      end

      it "doesn't delete a session" do
        expect { delete :destroy, id: user.id }.to_not change(Session, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(flash[:error]).to be_present
      end
    end
  end

end
