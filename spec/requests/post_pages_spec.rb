require 'spec_helper'

describe "PostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:friend) { FactoryGirl.create(:friend) }
  let(:topic)  { FactoryGirl.create(:post, user: friend, to_friend_id: user.id) }
  before { sign_in user }

  describe "post creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a post" do
        expect { click_button "Send!" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Send!" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
        fill_in 'post_content', with: "Lorem ipsum"
        find_by_id('post_to_friend_id').find(:xpath, 'option[2]').select_option
      end
      it "should create a new post" do
        expect { click_button "Send!" }.to change(Post, :count).by(1)
      end
    end
  end

  describe "post destruction" do
    before { FactoryGirl.create(:post, user: user, to_friend_id: friend.id) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a post" do
        expect { click_link "delete" }.to change(Post, :count).by(-1)
      end
    end
  end

  describe "reply destruction" do
    before { FactoryGirl.create(:post, user: user, to_friend_id: friend.id, topic_id: topic.id) }

    describe "as correct user" do
      before { visit user_path(user) }

      it "should delete my reply" do
        expect { click_link "delete" }.to change(Post, :count).by(-1)
      end
    end
  end

  describe "replies and post destruction" do
    before { FactoryGirl.create(:post, user: user, to_friend_id: friend.id, topic_id: topic.id) }

    describe "as correct user" do
      before do
        sign_in friend
        visit root_path
      end

      it "should delete a post and its replies" do
        expect { click_link "delete" }.to change(Post, :count).by(-2)
      end
    end
  end
end
