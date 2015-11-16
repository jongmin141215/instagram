require 'rails_helper'

feature 'Pictures' do
  scenario 'User can add a picture' do
    user = create :user
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_button 'Add a picture'
  end
end
