require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content '22 Street'" do
      visit 'static_pages/home'
      expect(page).to have_content('22 Street')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("22 Street | Home")
    end
  end
end
