require 'spec_helper'

describe "MicropostPages" do
  
	subject { page }

	let(:user) {FactoryGirl.create(:user) }
	before {valid_signin user }

	describe "micropost creation" do
		before {visit root_path }

		describe "with invalid information" do

			it "should not create a micropost" do
				expect { click_button "Post" }.not_to change(Micropost, :count)
			end

			describe "error messages" do
				before {click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid informaiton" do
			befor { fill_in 'micropost_content', with: "Lorem ipsum" }
			it "should create a micropost" do
				expect { click_button "post" }.to change(Micropost, :count).by(1)
			end
		end
	end

end
