require 'spec_helper'

feature 'User Sign In' do

  scenario 'User should be able to sign into facebook' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      'uid' => '1337',
      'provider' => 'facebook',
      'info' => {
        'name' => 'John Bean',
        'email' => 'john@bean.com'
      },
      'credentials' => {
        'token' => '123',
        'expires_at' => (Time.now + 7.days).to_i
      }
    })

    visit root_path
    click_link_or_button('Sign in with Facebook')
    expect(page).to have_selector('.alert', text: 'Welcome John Bean')
  end
end
