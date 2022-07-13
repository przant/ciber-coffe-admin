# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Registration', type: :system do
  let(:existing_user) { create :user }

  scenario 'A user fails to sign up (i.e. password too short)' do
    visit root_path

    expect(page).to have_link 'Login', href: new_user_session_path
    expect(page).to have_link 'Sign-up', href: new_user_registration_path

    click_link 'Sign-up'

    fill_in 'Name', with: 'ExampleName'
    fill_in 'Last name', with: 'ExampleSurname'
    fill_in 'Nickname', with: 'ExampleAlias'
    fill_in 'Email', with: 'example@test.com'
    fill_in 'Password', with: '12345'
    fill_in 'Password confirmation', with: '12345'

    click_button 'Sign Up'

    expect(page).not_to have_link 'Logout', href: destroy_user_session_path
    expect(page).to have_text '1 error prohibited this user from being saved:'
    expect(page).to have_text 'Password is too short (minimum is 6 characters)'
  end

  scenario "A user fails to sign up (i.e. password doesn't match" do
    visit root_path

    expect(page).to have_link 'Login', href: new_user_session_path
    expect(page).to have_link 'Sign-up', href: new_user_registration_path

    click_link 'Sign-up'

    fill_in 'Name', with: 'ExampleName'
    fill_in 'Last name', with: 'ExampleSurname'
    fill_in 'Nickname', with: 'ExampleAlias'
    fill_in 'Email', with: 'example@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '87654321'

    click_button 'Sign Up'

    expect(page).not_to have_link 'Logout', href: destroy_user_session_path
    expect(page).to have_text '1 error prohibited this user from being saved:'
    expect(page).to have_text "Password confirmation doesn't match Password"
  end

  scenario 'A user fails to sign up (i.e. email is already taken)' do
    visit root_path

    expect(page).to have_link 'Login', href: new_user_session_path
    expect(page).to have_link 'Sign-up', href: new_user_registration_path

    click_link 'Sign-up'

    fill_in 'Name', with: 'ExampleName'
    fill_in 'Last name', with: 'ExampleSurname'
    fill_in 'Nickname', with: 'ExampleAlias'
    fill_in 'Email', with: existing_user.email
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_button 'Sign Up'

    expect(page).not_to have_link 'Logout', href: destroy_user_session_path
    expect(page).to have_text '1 error prohibited this user from being saved:'
    expect(page).to have_text 'Email has already been taken'
  end

  scenario 'A user fails to sign up (i.e. email is blank)' do
    visit root_path

    expect(page).to have_link 'Login', href: new_user_session_path
    expect(page).to have_link 'Sign-up', href: new_user_registration_path

    click_link 'Sign-up'

    fill_in 'Name', with: 'ExampleName'
    fill_in 'Last name', with: 'ExampleSurname'
    fill_in 'Nickname', with: 'ExampleAlias'
    fill_in 'Email', with: ''
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_button 'Sign Up'

    expect(page).not_to have_link 'Logout', href: destroy_user_session_path
    expect(page).to have_text '1 error prohibited this user from being saved:'
    expect(page).to have_text "Email can't be blank"
  end

  scenario 'A user signs up' do
    visit root_path

    expect(page).to have_link 'Login', href: new_user_session_path
    expect(page).to have_link 'Sign-up', href: new_user_registration_path

    click_link 'Sign-up'

    fill_in 'Name', with: 'ExampleName'
    fill_in 'Last name', with: 'ExampleSurname'
    fill_in 'Nickname', with: 'ExampleAlias'
    fill_in 'Email', with: 'example@email.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_button 'Sign Up'

    expect(page).to have_button 'Logout'
    expect(page).to have_text 'Welcome! You have signed up successfully.'
    expect(page).to have_text 'example@email.com'
  end
end
