require 'rails_helper'

feature 'Comments' do
  before do
    @user = create :user
    @user2 = create :user2
    @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
  end

  context 'Visitors signed in' do
    before do
      sign_in(@user2.email, @user2.password)
    end

    scenario 'Visitors can write commnet on pictures', js: true do
      visit user_pictures_path(@user)
      leave_comment('nice')
      expect(page).to have_content 'nice'
      expect(page).to have_link 'Jongmin2'
    end

    scenario 'Time is displayed', js: true do
      visit user_pictures_path(@user)
      leave_comment('nice')
      wait_for_ajax
      comment = Comment.first
      within '.each_comment' do
        expect(page).to have_content comment.created_at.strftime('%H:%M %m/%d/%y')
      end
    end

    scenario 'Comments cannot be empty', js: true do
      visit "/users/#{@user.id}/pictures"
      leave_comment('')
      wait_for_ajax
      expect(page).not_to have_css 'li.each_comment'
    end

    scenario 'User can delete their own comments', js: true do
      visit "/users/#{@user.id}/pictures"
      leave_comment('nice')
      find('.remove').click
      wait_for_ajax
      expect(page).not_to have_content 'nice'
    end
  end

  context 'User not signed in' do
    scenario 'User cannot see the comment button' do
      visit "/users/#{@user.id}/pictures"
      expect(page).not_to have_css 'button.comment.glyphicon.glyphicon-comment'
    end
  end
end
