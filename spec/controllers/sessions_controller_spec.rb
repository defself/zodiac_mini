require 'rails_helper'

describe SessionsController do
  render_views

  let(:zodiac) { create :zodiac }
  let(:user)   { create :user, zodiac: zodiac }

  describe "GET new" do

    context "when successfully" do
      before { get :new }

      it { expect(response).to be_success }
      it { expect(assigns(:session)).to be_a_new(Session) }
    end

    context "when is authorized" do
      before do
        sign_in user
        get :new
      end

      it { expect(response).to redirect_to(users_path) }
    end
  end

  describe "POST create" do

    context "when successfully" do
      let(:session_params) {{ email: user.email, password: user.password }}

      it "creates a session" do
        expect { post :create, session: session_params }.to change(Session, :count).by 1
        expect(response).to redirect_to(user_path user)
        expect(assigns(:user)).to eq(user)
        expect(flash[:success]).to be_present
        expect(session[:user_id]).to eq user.id
      end
    end

    context "when failure" do
      let(:session_params) {{ email: user.email, password: "invalid" }}

      it "doesn't create a session" do
        expect { post :create, session: session_params }.to_not change(Session, :count)
        expect(response).to render_template(:new)
        expect(assigns(:user)).to be_nil
        expect(flash[:error]).to be_present
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE destroy" do

    context "when successfully" do
      before do
        sign_in user
      end

      it "deletes a session" do
        expect { delete :destroy, id: user.id }.to change(Session, :count).by -1
        expect(response).to redirect_to(new_session_path)
        expect(flash[:success]).to be_present
        expect(session[:user_id]).to be_nil
      end
    end

    context "when is not authorized" do
      before { delete :destroy, id: user.id }

      it { expect(response).to redirect_to(root_path) }
      it { expect(flash[:error]).to eq "First log in to use the web site" }
    end

    context "when failure" do
      before { sign_in user }

      it "doesn't delete a session" do
        expect { delete :destroy, id: "" }.to_not change(Session, :count)
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to be_present
        expect(session[:user_id]).to_not be_nil
      end
    end
  end

end
