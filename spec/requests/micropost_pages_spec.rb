require 'spec_helper'

describe "MicropostPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
#	before { sign_in user }

	#it { should have_button('Post') }

	describe "micropost creation" do
		before {
			sign_in user
			visit root_path
		}
		
		describe "with invalid information" do
			
			it "should not create a micropost" do
				# clicking button just with empty input field
				expect { click_button "Post" }.not_to change(Micropost, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do

			before { fill_in 'micropost_content', with: "Lorem ipsum" }
			it "should create a micropost" do
				expect { click_button "Post" }.to change(Micropost, :count).by(1)
			end
		end

		describe "with valid but long word" do
			let!(:m_long) { FactoryGirl.create(:micropost, user: user, content: "a" * 100) }
			before { fill_in 'micropost_content', with: m_long.content }
				
			it "should create a micropost with the separator '&#8203;'" do
				expect { click_button "Post" }.to change(Micropost, :count).by(1)
				expect(page.find(:xpath,
					"//ol[@class='microposts']/li[@id=#{m_long.id}]/span[@class='content']").text.length).to be > m_long.content.length
			end
		end
	end

	describe "micropost destruction" do
		let!(:m) { FactoryGirl.create(:micropost, user: user, content: "Hoge") }
		let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
		let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

		describe "as correct user" do
			before { 
				sign_in user
				visit root_path
			}

			it "should delete a micropost" do
				expect { click_link("delete", match: :first) }.to change(Micropost, :count).by(-1)
			end
		end

		# Excercise 10.5.4
		describe "as wrong user" do
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before {
				sign_in wrong_user, no_capybara: true
				visit root_path
			}
			it "should not be able to delete a micropost" do
				expect(page).not_to have_link('delete', href: micropost_path(m))	
			end
		end
	end

	# test for not-signed-in user
end
