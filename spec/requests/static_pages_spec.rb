require 'spec_helper'

describe "Static Pages" do
	subject { page }	

	shared_examples_for "all static pages" do
		it { should have_content(heading) }
		it { should have_title(full_title(page_title)) }
	end

	describe "Home Page" do
		before { visit root_path }
		let(:heading) { 'Sample App' }
		let(:page_title) { '' }
		
		it_should_behave_like "all static pages"
		it { should_not have_title('| Home') }

		describe "for signed-in users" do
			# 'Email already taken' error occurred when using Guard
			let(:user) { FactoryGirl.create(:user) }
			let!(:m1) {	FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum") }
			let!(:m2) {	FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet") }
			before do
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end

			describe "should count and show the user's microposts correctly" do
				let(:micropost_count_string) { page.find(:xpath, '//span[@id="micropost_count"]').text }
				describe "the case there're 2 microposts" do
					it { expect(micropost_count_string).to match(/2 microposts/) }
				end
				describe "the case there's only 1 micropost" do
					before { click_link('delete', match: :first) }
					it { expect(micropost_count_string).to match(/micropost/) }
					it { expect(micropost_count_string).not_to match(/microposts/) }
				end

			end

			# pagination test based on List 9.33 in the tutorial
			describe "pagination" do
			#	before(:all) { 30.times { FactoryGirl.create(:micropost, user: user, content: "example") } }
				#after(:all) { Micropost.delete_all }
				
				it "should list each micropost" do 
			#		Micropost.paginate(page: 1).each do |micropost|
			#			page.should have_selector('li', text: micropost.content)
			#		end
				end

			end
		end
	end

	describe "Help Page" do
		before { visit help_path }
		let(:heading) { 'Help' }
		let(:page_title) { 'Help' }

		it_should_behave_like "all static pages"
	end

	describe "About Page" do
		before { visit about_path }
		let(:heading) { 'About Us' }
		let(:page_title) { 'About Us' }

		it_should_behave_like "all static pages"
	end

	describe "Contact Page" do
		before { visit contact_path }
		let(:heading) { 'Contact' }
		let(:page_title) { 'Contact' }

		it_should_behave_like "all static pages"
	end
	
	it "should have the right links on the layout" do 
		visit root_path
		click_link "About"
		expect(page).to have_title(full_title('About Us'))
		click_link "Help"
		expect(page).to have_title(full_title('Help'))
		click_link "Contact"
		expect(page).to have_title(full_title('Contact'))
		click_link "Home"
		click_link "Sign up now!"
		expect(page).to have_title(full_title('Sign up'))
		click_link "sample app"
		expect(page).to have_title(full_title(''))
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
