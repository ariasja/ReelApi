require 'spec_helper'

describe 'POST v1/sessions' do
  it 'creates a session' do

    email = "jasck_sparrow@pirates.com"
    password = "foobar"

    post 'v1/users', {
      device_token: '123abc4556def',
      name: "Captain Jack Sparrow",
      username: "cjs",
      bio: "Where's all the rum gone?",
      email: email,
      password: password,
      password_confirmation: password
    }.to_json, { 'Content-Type' => 'application/json' }

    post 'v1/sessions', {
      email: email,
      password: password
    }.to_json, { 'Content-Type' => 'application/json' }

  end
end