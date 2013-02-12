require 'spec_helper'

#The tests for all the static pages
describe "StaticPages" do

  #let(:base_title) {"Ruby on Rails Tutorial Big App"}
  subject { page }

  #Home page test
  describe "Home Page" do
    before { visit root_path }
    
    it { should have_selector 'h1', text: 'Big App' }
    it { should have_selector 'title', text: full_title('') }
    it { should_not have_selector 'title', text: '| Home' }  
  end

  #Help Page Tests
  describe "Help page" do
    before { visit help_path }
    
    it { should have_selector 'h1', text: 'Help' }
	  it { should have_selector 'title', text: full_title('') }
  end

  #About Page Tests
  describe "About page" do
    before { visit about_path }
    
    it { should have_selector 'h1', text: 'About Us' }
    it { should have_selector 'title', text: full_title('') }
  end

  #Contact Page Tests

  describe "Contact Page" do
    before { visit contact_path }

    it { should have_selector 'h1', text: 'Contact' }
    it { should have_selector 'title', text: full_title('') }
  end

end
