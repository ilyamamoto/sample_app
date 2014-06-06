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
	end

	describe "Help Page" do
		before { visit help_path }
		let(:heading) { 'Help' }
		let(:page_title) { 'Help' }

		it_should_behave_like "all static pages"
		it { should_not have_title('| Help') }
	end

	describe "About Page" do
		before { visit about_path }
		let(:heading) { 'About Us' }
		let(:page_title) { 'About Us' }

		it_should_behave_like "all static pages"
		it { should_not have_title('| About Us') }
	end

	describe "Contact Page" do
		before { visit contact_path }
		let(:heading) { 'Contact' }
		let(:page_title) { 'Contact' }

		it_should_behave_like "all static pages"
		it { should have_title('| Contact') }
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
