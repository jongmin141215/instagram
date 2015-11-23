require 'rails_helper'

feature 'liking pictures' do
  before do
    @user = create :user
    @user2 = create :user2
    @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
  end

  context 'Visitor signed in', js: true do
    before do
      visit '/users/sign_in'
      fill_in 'Email', with: @user2.email
      fill_in 'Password', with: @user2.password
      click_button 'Log in'
    end

    scenario 'User can like pictures, which updates the picture like count', js: true do
      visit "/users/#{@user.id}/pictures"
      find('.glyphicon-thumbs-up').click
      wait_for_ajax
      expect(page).to have_css('button.like.glyphicon.glyphicon-thumbs-up', text: '1')
    end

    scenario 'User can only like once for a picture', js: true do
      visit "/users/#{@user.id}/pictures"
      find('.glyphicon-thumbs-up').click
      find('.glyphicon-thumbs-up').click
      wait_for_ajax
      expect(page).to have_css('button.like.glyphicon.glyphicon-thumbs-up', text: '1')
    end
  end

  context 'Visitors not signed in', js: true do
    scenario 'Visitors cannot like' do
      visit "/users/#{@user.id}/pictures"
      find('.glyphicon-thumbs-up').click
      expect(page).to have_css('.like', text: '0')
    end
  end
end
