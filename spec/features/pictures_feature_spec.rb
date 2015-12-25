require 'rails_helper'

feature 'Pictures' do
  context 'User signed in' do
    before do
      @user = create :user
      sign_in(@user.email, @user.password)
      click_button 'Add a picture'
    end
    scenario 'User can see a form' do
      expect(page).to have_selector 'input[type="file"]'
      expect(page).to have_selector 'textarea'
      expect(page).to have_button 'Post'
    end

    scenario 'User can add a picture' do
      attach_picture('associations')
      expect(page).to have_selector 'img'
      expect(page).to have_content 'associations'
    end

    scenario 'Time is displayed' do
      attach_picture('associations')
      picture = Picture.first
      within '.time' do
        expect(page).to have_content(picture.created_at.strftime('%H:%M %m/%d/%y'))
      end
    end

    scenario 'Most recent picture is shown at the top' do
      attach_picture('Old')
      click_button 'Add a picture'
      attach_picture('New')
      expect(page).to have_css("div.pictures .panel:nth-child(1)", text: 'New')
      expect(page).to have_css("div.pictures .panel:nth-child(2)", text: 'Old')
    end

    scenario 'User cannot post without a picture' do
      fill_in 'picture_description', with: 'associations'
      click_button 'Post'
      expect(current_path).to eq("/users/#{@user.id}/pictures")
      expect(page).to have_content 'Image can\'t be blank'
    end

    scenario 'User can edit description', js: true do
      @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
      visit "/users/#{@user.id}/pictures"
      find('.glyphicon-edit').click
      fill_in 'picture[description]', with: 'has many through associations'
      find('.save').click
      expect(page).to have_content 'has many through associations'
    end

    scenario 'User can delete picture', js: true do
      @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
      visit "/users/#{@user.id}/pictures"
      find('.delete').click
      expect(page).to have_button 'Add a picture'
      expect(page).not_to have_selector 'img'
      expect(page).not_to have_content 'associations'
    end


    # context 'Signed-in visitors' do
    #
    # end
  end

  context 'User not signed in' do
    before do
      @user = create :user
      sign_in(@user.email, @user.password)
      click_button 'Add a picture'
      attach_picture('associations')
      click_link 'Sign out'
    end

    scenario 'User can still see pictures from other users' do
      visit "/users/#{@user.id}/pictures"
      expect(page).to have_selector 'img'
      expect(page).to have_content 'associations'
    end

    scenario 'User cannot edit picture description' do
      visit "/users/#{@user.id}/pictures"
      expect(page).not_to have_css('.edit')
    end

    scenario 'User cannot see the trash bin icon' do
      visit "/users/#{@user.id}/pictures"
      expect(page).not_to have_selector '.delete'
    end
  end

end
