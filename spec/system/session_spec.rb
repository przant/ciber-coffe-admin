# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Session', type: :system do
  let(:existing_user) { create :user, :with_full_info }

  scenario 'An existing user can do login and logout' do
    visit root_path

    click_link 'Login'

    expect(page).to have_text 'Log in'
    expect(page).to have_link 'Forgot your password?'

    fill_in 'Email', with: existing_user.email
    fill_in 'Password', with: '12345678'

    click_button 'Log in'

    expect(page).to have_text 'Signed in successfully.'
    expect(page).to have_link existing_user.email, href: edit_user_registration_path
    expect(page).to have_button 'Logout'

    click_button 'Logout'

    expect(page).not_to have_button 'Logout'
    expect(page).to have_link 'Login'
    expect(page).to have_link 'Sign-up'
    expect(page).to have_text 'Signed out successfully.'
  end
end