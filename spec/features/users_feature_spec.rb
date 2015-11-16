require 'rails_helper'

feature 'User can sign up' do
  scenario 'User needs to provide name to sign up' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'jongmin@example.com'
    fill_in 'Name', with: 'Jongmin'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_link 'Sign out'
    expect(page).not_to have_link 'Sign in'
    expect(page).not_to have_link 'Sign up'
  end
end

feature 'Sign in' do
  context 'with correct credential' do
    before do
      user = create :user
    end
    scenario 'user can see "Sign out" link' do
      visit '/users/sign_in'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_link 'Sign out'
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end
  end
end

feature 'Sign out' do
  before do
    user = create :user
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  scenario 'user can see "Sign up" & "Sign in" links' do
    click_link 'Sign out'
    expect(page).to have_link 'Sign in'
    expect(page).to have_link 'Sign up'
    expect(page).not_to have_link 'Sign out'
  end

end
