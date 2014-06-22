require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before {visit signin_path}

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before {sign_in user}

      it { should have_title(user.name) }
      it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end

  describe "authorization" do
    let(:user) { FactoryGirl.create(:user) }

    describe "for non signed in users" do

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end

        describe "when signing in again" do
          before do
            click_link "Sign out"
            click_link "Sign in"
            fill_in "Email",    with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end

          it "should render the default page" do
            expect(page).to have_title(user.name)
          end
        end
      end

      describe "in the users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('h1', text: 'Sign in') }
          it { should have_selector('div.alert.alert-info') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { response.should redirect_to signin_path }
        end

        describe "visiting the users index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
      end
    end

    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:friend) }
      before { sign_in user, no_capybara: true }

      describe "visiting Users#edit page" do
        before { get edit_user_path(wrong_user) }
        it { should_not have_title('Edit user') }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { response.should redirect_to root_path }
      end
    end

    describe "as non admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to destroy users action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to root_path   }
      end
    end

    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:admin) }

      before { sign_in admin, no_capybara: true }

      describe "submitting a DELETE request to the same admin" do
        before { delete user_path(admin) }
        specify { expect(response).to redirect_to root_path }
      end
    end

    describe "as signed in user" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user, no_capybara: true }

      describe "visiting Users#new" do
        before { get new_user_path }
        specify { expect(page).to redirect_to root_path }
      end

      describe "submitting a POST request to Users#create" do
        before { post users_path }
        specify { expect(page).to redirect_to root_path }
      end
    end

  end

end
