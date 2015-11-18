require 'rails_helper'

feature 'Pictures' do
  context 'User signed in' do
    before do
      user = create :user
      visit '/users/sign_in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_button 'Add a picture'
    end
    scenario 'User can see a form' do
      expect(page).to have_selector 'input[type="file"]'
      expect(page).to have_selector 'textarea'
      expect(page).to have_button 'Post'
    end

    # scenario 'User can add a picture' do
    #
    # end
  end

end
