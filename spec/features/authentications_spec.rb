require 'rails_helper'

RSpec.feature 'Authentication', type: :feature, js: true do
  let!(:user) { create(:user) }

  feature 'Sign In' do
    background do
      visit root_path
    end

    scenario 'fails with invalid credentials' do
      click_button 'Sign in'
      expect(page).to have_text('incorrect')
    end

    scenario 'success with valid credentials' do
      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Sign in'
      expect(page).to have_text('Signed in as')
      click_link 'Logout'
      expect(page).to have_text('Login')
    end
  end

  feature 'Sign Up' do
    background do
      visit signup_path
    end
    scenario 'fails with invalid credentials' do
      click_button 'Create user'
      expect(page).to have_text('Password is too short')
    end

    scenario 'success with valid credentials' do
      within 'form' do
        fill_in 'Name', with: 'abama'
        fill_in 'Email', with: 'abama@gmail.com'
        fill_in 'Password', with: '11111111'
        fill_in 'Password confirmation', with: '11111111'
      end
      click_button 'Create user'
      expect(page).to have_text('You signed up successfully')
    end
  end
end
