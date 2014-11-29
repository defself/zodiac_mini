require 'rails_helper'

describe UsersController do
  render_views

  let(:zodiac)    { create :zodiac }
  let(:user)      { create :user, zodiac: zodiac }
  let(:horoscope) { create(:horoscope, zodiac: zodiac) }

  before { sign_in user }

  describe "GET index" do
    before do
      create_list(:user, 3, zodiac: zodiac)
      get :index
    end

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it("returns all users") { expect(assigns(:users)).to eq User.all }
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, id: user.id
      expect(response).to be_success
    end
  end

  describe "POST create" do
    before { log_out user }

    context "when successfully" do
      let(:user_params)   { attributes_for(:user, zodiac: zodiac) }

      it "creates a user" do
        expect { post :create, user: user_params }.to change(Session, :count).by 1
        user = assigns(:user)
        expect(response).to redirect_to(user)
        expect(assigns(:user)).to eq(user)
        expect(flash[:success]).to be_present
        expect(session[:user_id]).to eq user.id
      end
    end

    context "when failure" do
      let(:user_params) { attributes_for(:user, password: nil, zodiac: zodiac) }

      it "doesn't create a user" do
        expect { post :create, user: user_params }.to_not change(Session, :count)
        expect(response).to render_template(:new)
        expect(flash[:error]).to be_present
        expect(session[:user_id]).to eq nil
      end
    end
  end

end
