require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_content('22 Street') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
