require 'rails_helper'

feature 'liking pictures' do
  before do
    @user = create :user
    @user2 = create :user2
    @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
  end

  context 'Visitor signed in', js: true do
    before do
      sign_in(@user2.email, @user2.password)
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
    scenario 'Visitors cannot see the like button' do
      visit "/users/#{@user.id}/pictures"
      expect(page).not_to have_css('button.like.glyphicon.glyphicon-thumbs-up')
    end
  end

  context 'User who posted a picture signed in' do
    before do
      sign_in(@user.email, @user.password)
    end

    scenario 'cannot see the like button', js: true do
      visit "/users/#{@user.id}/pictures"
      expect(page).not_to have_css('button.like.glyphicon.glyphicon-thumbs-up')
    end
  end
end
