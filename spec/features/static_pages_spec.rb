require 'rails_helper'
require 'support/utilities'

feature "StaticPages" do

  #subject { page }
  context "as a user" do

    scenario "visits home page" do
      visit root_path

      expect(page).to have_content '22 Street'
      expect(page).to have_title(full_title(''))
      expect(page).not_to have_title('| Home')
    end

    scenario "visits contact page" do
      visit contact_path

      expect(page).to have_content('Contact')
      expect(page).to have_title(full_title('Contact'))
    end
  end

  context "as a sign-in user" do
    scenario "visits home page" do
      user = create(:user)
      friend = create(:friend)

      create(:post, user: user, content: "Lorem ipsum",
                           to_friend_id: friend.id)
      create(:post, user: user, content: "Dolor sit amet",
                           to_friend_id: friend.id)
      sign_in user
      visit root_path

      user.feed.each do |item|
        expect(page).to have_selector('p', text: item.content)
      end
    end
  end

end
