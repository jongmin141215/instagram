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

    scenario 'User can add a picture' do
      attach_file('Upload Image', './spec/fixtures/associations.jpg')
      fill_in 'picture_description', with: 'associations'
      click_button 'Post'
      expect(page).to have_selector 'img'
      expect(page).to have_content 'associations'
    end

    scenario 'User can edit description' do
      attach_file('Upload Image', './spec/fixtures/associations.jpg')
      fill_in 'picture_description', with: 'associations'
      click_button 'Post'
      find('.glyphicon-trash').click
      expect(page).to have_selector 'textarea'
      fill_in 'edit_description', with: 'has many through associations'
      click_link 'Save'
      expect(page).to have_content 'has many through associations'
    end

    scenario 'User can delete picture' do
      attach_file('Upload Image', './spec/fixtures/associations.jpg')
      fill_in 'picture_description', with: 'associations'
      click_button 'Post'
      find('.save').click
      expect(page).not_to have_selector 'img'
      expect(page).not_to have_content 'associations'
    end

  end

end
