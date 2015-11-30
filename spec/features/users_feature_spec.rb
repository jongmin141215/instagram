require 'rails_helper'

feature 'User can sign up' do
  before do
    @user = build :user
    sign_up(@user)
  end
  scenario 'User needs to provide name to sign up' do
    expect(page).to have_link 'Sign out'
    expect(page).not_to have_link 'Sign in'
    expect(page).not_to have_link 'Sign up'
  end

  scenario 'Name has to be unique' do
    click_on 'Sign out'
    user = build(:user, email: 'jongmin2@example.com')
    expect { sign_up(user) }.not_to change(User, :count)
  end
end

feature 'Sign in' do
  context 'with correct credential' do
    before do
      @user = create :user
    end
    scenario 'user can see "Sign out" link' do
      sign_in(@user.email, @user.password)
      expect(page).to have_link 'Sign out'
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end
  end
end

feature 'Sign out' do
  before do
    @user = create :user
    sign_in(@user.email, @user.password)
  end

  scenario 'user can see "Sign up" & "Sign in" links' do
    click_link 'Sign out'
    expect(page).to have_link 'Sign in'
    expect(page).to have_link 'Sign up'
    expect(page).not_to have_link 'Sign out'
  end

end
