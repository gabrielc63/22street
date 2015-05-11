require 'rails_helper'

describe User do

  it 'is valid with name, email, username and password' do
    user = build(:user)
    expect(user).to be_valid
    expect(user).not_to be_admin
  end
    # @user.avatar = File.new("app/assets/images/ruby.png")
  # friend = FactoryGirl.build(:friend, email: 'george@example.org')
  # subject { @user }
  # it { should respond_to(:name) }
  # it { should respond_to(:email) }
  # it { should respond_to(:username) }
  # it { should validate_attachment_content_type(:avatar).
                # allowing('image/png', 'image/jpeg').
                # rejecting('text/plain', 'text/xml') }
  # it { should validate_attachment_size(:avatar).
                # in(0..100.kilobytes) }
  # it { should respond_to(:password_digest) }
  # it { should respond_to(:password) }
  # it { should respond_to(:password_confirmation) }
  # it { should respond_to(:remember_token) }
  # it { should respond_to(:authenticate) }
  # it { should respond_to(:posts) }


  describe "with admin attribute set to 'true'" do
    it "should be admin" do
      user = create(:user)
      user.toggle!(:admin)
      expect(user).to be_admin
    end
  end

  it "is invalid when name is not present" do
    user = FactoryGirl.build(:user, name: nil)
    expect(user).not_to be_valid
  end

  it "is invalid when email is not present" do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without username" do
    user = build(:user, username: " ")
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid when name is too long" do
    user = build(:user)
    user.name = "a" * 51
    expect(user).not_to be_valid
  end

  it "is invalid when username is too long" do
    user = build(:user)
    user.username = "a" * 21
    expect(user).not_to be_valid
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user = build(:user, email: invalid_address)
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user = build(:user, email: valid_address)
        expect(user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    it "should not be valid" do
      create(:user, email: 'example@gmail.org')
      user_with_same_email = build(:user, email: 'example@gmail.org'.upcase)
      user_with_same_email.valid?
      expect(user_with_same_email.errors[:email]).to include("has already been taken")
    end
  end

  describe "when password is not present" do
    it "should not be valid" do
      user = build(:user, password: " ", password_confirmation: " ")
      expect(user).not_to be_valid
    end
  end

  describe "when password doesn't match confirmation" do
    it "should not be valid" do
      user = build(:user)
      user.password_confirmation = "mismatch"
      expect(user).not_to be_valid
    end
  end

  describe "with a password that's too short" do
    it "should be invalid" do
      user = build(:user)
      user.password = user.password_confirmation = "a" * 5
      expect(user).to be_invalid
    end
  end

  describe "return value of authenticate method" do

    describe "with valid password" do
      it "should be equal" do
        old_user = create(:user)
        user = FactoryGirl.create(:user, email: "prueba@gmail.com")
        found_user = User.find_by(email: user.email)
        expect(user).to eq found_user.authenticate(old_user.password)
      end
    end

    describe "with invalid password" do
      it "should not be equal" do
        user = FactoryGirl.create(:user, email: "prueba@gmail.com")
        found_user = User.find_by(email: user.email)
        user_for_invalid_password = found_user.authenticate("invalid")
        expect(user).not_to eq user_for_invalid_password
        expect(user_for_invalid_password).to be_falsey
      end
    end
  end


  describe "remember token" do
    it "should not be blank" do
      user = create(:user)
      expect(user.remember_token).not_to be_blank
    end
  end

  # describe "post associations" do
  #
  #   before { @user.save }
  #   let!(:older_post) do
  #     FactoryGirl.create(:post, user: @user, to_friend_id: friend.id, created_at: 1.day.ago)
  #   end
  #   let!(:newer_post) do
  #     FactoryGirl.create(:post, user: @user, to_friend_id: friend.id, created_at: 1.hour.ago)
  #   end
  #
  #   it "should have the right posts in the right order" do
  #     expect(@user.posts.to_a).to eq [newer_post, older_post]
  #   end
  #
  #   it "should destroy associated posts" do
  #     posts = @user.posts.to_a
  #     @user.destroy
  #     expect(posts).not_to be_empty
  #     posts.each do |post|
  #       expect(Post.where(id: post.id)).to be_empty
  #     end
  #   end

    # describe "status" do
      # let(:received_post) do
        # FactoryGirl.create(:post, user: friend, to_friend_id: @user.id)
      # end

      # its(:feed) { should include(newer_post) }
      # its(:feed) { should include(older_post) }
      # its(:feed) { should include(received_post) }
    # end

  # end

end
