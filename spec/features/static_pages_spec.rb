require 'rails_helper'

describe "StaticPages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_content('22 Street') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:friend) { FactoryGirl.create(:friend) }
      before do
        FactoryGirl.create(:post, user: user, content: "Lorem ipsum",
                           to_friend_id: friend.id)
        FactoryGirl.create(:post, user: user, content: "Dolor sit amet",
                           to_friend_id: friend.id)
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector('p', text: item.content)
        end
      end
    end
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
