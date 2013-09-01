require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Welcome to Bedellos Webshop'" do
      visit root_path
      expect(page).to have_content('Welcome to Bedellos Webshop')
    end
  end
end