require 'rails_helper'

describe SessionsController do
  let(:zodiac) { create :zodiac }
  let(:user) { create :user, zodiac: zodiac }

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:session)).to be_a_new(Session)
    end

    it "is authorized" do
      user_login user

      get :new
      expect(response).to redirect_to(users_path)
    end
  end

  describe "POST create" do
    let(:session_params) { { session: { email: "qwerty@gmail.com", password: "123456789" }} }
    let(:invalid_session_params) { { session: { email: "qwerty@gmail.com", password: "invalid" }} }

    before { user }

    it "returns http success" do
      expect { post :create, session_params }.to change { Session.count }.by 1
      expect(response).to redirect_to(user_path user)
      expect(assigns(:user)).to eq(user)
      expect(flash[:success]).to be_present
      expect(session[:user_id]).to eq user.id
    end

    it "returns http error" do
      expect { post :create, invalid_session_params }.to_not change(Session, :count)
      expect(response).to redirect_to(new_session_path)
      expect(assigns(:user)).to be_nil
      expect(flash[:error]).to be_present
      expect(session[:user_id]).to be_nil
    end
  end

  describe "DELETE destroy" do
    it "returns http success" do
      user_login user

      expect { delete :destroy, id: user.id }.to change { Session.count }.by -1
      expect(response).to redirect_to(new_session_path)
      expect(flash[:success]).to be_present
      expect(session[:user_id]).to be_nil
    end

    it "is not authorized" do
      delete :destroy, id: user.id
      expect(response).to redirect_to(root_path)
      expect(flash[:error]).to eq "First log in to use the web site"
    end
  end

end
