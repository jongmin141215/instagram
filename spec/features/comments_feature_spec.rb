require 'rails_helper'

feature 'Comments' do
  before do
    @user = create :user
    @user2 = create :user2
    @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
  end

  context 'User signed in' do
    before do
      visit '/users/sign_in'
      fill_in 'Email', with: @user2.email
      fill_in 'Password', with: @user2.password
      click_button 'Log in'
    end

    scenario 'Visitors can write commnet on pictures', js: true do
      visit "/users/#{@user.id}/pictures"
      find('.comment').click
      fill_in 'comment[content]', with: 'nice'
      find('.glyphicon-save').click
      expect(page).to have_content 'nice'
      expect(page).to have_content 'Jongmin2'
    end

    # scenario 'Comments cannot be empty', js: true do
    #   visit "/users/#{@user.id}/pictures"
    #   find('.comment').click
    #   fill_in 'comment[content]', with: 'hi'
    #   find('.glyphicon-save').click
    #   expect(page).to have_css 'li.each_comment'
    # end

  end
end
