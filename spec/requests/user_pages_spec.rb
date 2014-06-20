require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index page" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:friend, name: "Steve", email: "st@apple.com")
      FactoryGirl.create(:friend, name: "Bill", email: "bill@hotmail.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_selector('h1', text: 'All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li>a', text: user.name)
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:friend) { FactoryGirl.create(:friend) }
    let!(:m1) { FactoryGirl.create(:post, user: friend, to_friend_id: user.id, content: "Hi") }
    let!(:m2) { FactoryGirl.create(:post, user: friend, to_friend_id: user.id, content: "Mate") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "posts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.posts_received.count) }
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Diego Simeone"
        fill_in "Username",     with: "Cholo"
        fill_in "Email",        with: "cholo@gmail.com"
        fill_in "Password",     with: "123456"
        fill_in "Confirmation", with: "123456"
        # attach_file "user_avatar", 'app/assets/images/ruby.png'
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'cholo@gmail.com') }

        it { should have_title(user.name) }
        it { should have_link('Sign out') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end

  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new_email@email.com" }
      before do
        fill_in "Name",         with: new_name
        fill_in "Username",     with: user.username
        fill_in "Email",        with: new_email
        fill_in "Password",     with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('h1', text: new_name)}
      it { should have_link('Sign out', href: signout_path)}
      it { should have_selector('div.alert.alert-success', text: 'Profile updated') }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end

