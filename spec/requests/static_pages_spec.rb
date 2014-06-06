require 'spec_helper'

describe "Static Pages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

	describe "Home Page" do
		it "should have the content 'Sample App'" do
			visit home_path 
			expect(page).to have_content('Sample App')
		end
		it "should have the right title" do
			visit home_path
			expect(page).to have_title("#{base_title}")
		end
		
		it "should not have a custom page title" do
			visit home_path
			expect(page).not_to have_title('| Home')
		end
	end

	describe "Help Page" do
		it "should have the content 'Help'" do
			visit help_path
			expect(page).to have_content('Help')
		end
		it "should have the right title" do
			visit help_path
			expect(page).to have_title("#{base_title} | Help")
		end
	end

	describe "About Page" do
		it "should have the content 'About Us'" do
			visit about_path
			expect(page).to have_content('About Us')
		end
		it "should have the right title" do
			visit about_path
			expect(page).to have_title("#{base_title} | About Us")
		end
	end

	describe "Contact Page" do
		it "should have the right title" do
			visit contact_path
			expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
		end
		it "should have the content 'Contact'" do
			visit contact_path
			expect(page).to have_content('Contact')
		end
	end
end

#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end
#end
