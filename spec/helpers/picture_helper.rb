module PictureHelper
  def attach_picture(description)
    attach_file('Upload Image', './spec/fixtures/associations.jpg')
    fill_in 'picture_description', with: description
    click_button 'Post'
  end
end
