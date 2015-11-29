require 'rails_helper'

feature 'Search users' do
  before do
    @user = create :user
    @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
  end

  scenario 'can search users', js: true do
    visit root_path
    fill_in 'user-search-txt', with: 'jo'
    page.execute_script %Q{ $('#user-search-txt').trigger("keydown")}
    expect(page).to have_css 'li', text: 'jongmin'
  end
end
