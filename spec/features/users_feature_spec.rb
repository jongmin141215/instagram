require 'rails_helper'

feature 'User can sign up' do
  scenario 'User needs to provide name to sign up' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'jongmin@example.com'
    fill_in 'Name', with: 'Jongmin'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_link 'Add picture'
  end

end
