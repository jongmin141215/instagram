require 'rails_helper'

feature 'Search users' do
  before do
    @user = create :user
    @user.pictures.create(image_file_name: 'associations.jpg', description: 'associations')
  end

  scenario 'can autocomplete', js: true do
    search('jo')
    expect(page).to have_text 'Jongmin'

  end

  scenario 'can search users', js: true do
    search('j')
    click_on 'Jongmin'
    expect(current_path).to eq("/users/#{@user.id}/pictures")
  end

end
