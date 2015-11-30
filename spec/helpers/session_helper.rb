module SessionHelper
  def sign_in(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def sign_up(user)
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button 'Sign up'
  end
end