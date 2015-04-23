require 'rails_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }
  # user = FactoryGirl.create(:user)
  let(:friend) { FactoryGirl.create(:friend) }
  before { @post = user.posts.build(content: "bla bla bla", to_friend_id: friend.id) }

  subject { @post }

  it { should respond_to(:content) }
  it { should respond_to(:to_friend_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  # its(:user) { should eq user}
  # expect(@post.user).to eq(user)

  it { should be_valid }

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @post.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @post.content = "a" * 301 }
    it { should_not be_valid }
  end

end
