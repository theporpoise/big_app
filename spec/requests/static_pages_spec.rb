require 'spec_helper'

#The tests for all the static pages
describe "StaticPages" do

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact Us')
    click_link "Home"
    page.should have_selector 'title', text: full_title('')
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
  end

  #let(:base_title) {"Ruby on Rails Tutorial Big App"}
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector 'h1', text: heading }
    it { should have_selector 'title', text: full_title(page_title) }
  end

  #Home page test
  describe "Home Page" do
    before { visit root_path }
    let(:heading)    { 'Big App' }
    let(:page_title) { '' }  
    
    it_should_behave_like "all static pages" 
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) {FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        valid_signin user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  #Help Page Tests
  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages" 
    
    #it { should have_selector 'h1', text: 'Help' }
	  #it { should have_selector 'title', text: full_title('') }
  end

  #About Page Tests
  describe "About page" do
    before { visit about_path }
    
    let(:heading)    { 'About Us' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"

    #it { should have_selector 'h1', text: 'About Us' }
    #it { should have_selector 'title', text: full_title('') }
  end

  #Contact Page Tests

  describe "Contact Page" do
    before { visit contact_path }

    let(:heading)    { 'Contact' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"

    #it { should have_selector 'h1', text: 'Contact' }
    #it { should have_selector 'title', text: full_title('') }
  end

end
