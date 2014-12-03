require 'rails_helper'

describe UsersController do
  render_views

  let(:zodiac)    { Zodiac.all[rand 12] }
  let(:user)      { create :user, zodiac: zodiac }
  let(:horoscope) { create(:horoscope, zodiac: zodiac) }

  before { sign_in user }

  describe "GET index" do
    before { create_list(:user, 3, zodiac: zodiac) }

    context "when successfully" do
      before { get :index }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :index }
      it("returns all users") { expect(assigns(:users)).to eq User.all }

    end

    context "when is not authorized" do
      before do
        sign_out user
        get :index
      end

      it { is_expected.to respond_with :found }
      it { is_expected.to redirect_to new_session_path }

    end
  end

  describe "GET new" do
    before { get :new }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :new }
  end

  describe "GET show" do
    before { get :show, id: user.id }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :show }
  end

  describe "POST create" do
    before { sign_out user }

    context "when successfully" do
      let(:user_params) { attributes_for(:user, zodiac: zodiac) }

      it "creates a user" do
        expect { post :create, user: user_params }.to change(Session, :count).by 1
        is_expected.to respond_with :found
        expect(assigns(:user)).to be_instance_of User
        expect(flash[:success]).to be_present
        expect(session[:user_id]).to eq assigns(:user).id
      end
    end

    context "when failure" do
      let(:user_params) { attributes_for(:user, password: nil, zodiac: zodiac) }

      it "doesn't create a user" do
        expect { post :create, user: user_params }.to_not change(Session, :count)
        is_expected.to respond_with :unprocessable_entity
        expect(flash[:error]).to eq ["Password can't be blank"]
        expect(session[:user_id]).to eq nil
      end
    end
  end

  describe "GET horoscope" do

    it "yesterday" do
      get :horoscope, user_id: user.id, type: "yesterday"
      is_expected.to respond_with :success
    end

    it "today" do
      get :horoscope, user_id: user.id, type: "today"
      is_expected.to respond_with :success
    end

    it "tomorrow" do
      get :horoscope, user_id: user.id, type: "tomorrow"
      is_expected.to respond_with :success
    end
  end

end
