require 'rails_helper'

describe Identifier do
  let(:auth) { {
    provider: :test,
    uid:      1,
    info: {
      name:  "Test",
      email: "test@example.com",
      image: ""
    }
  } }

  let(:other) { auth.merge provider: :other }

  it 'can create a new user from oauth data' do
    user = Identifier.new(auth).resolve
    expect( user.identities.count ).to eq 1
    expect( user.email ).to eq "test@example.com"
  end

  it 're-resolves to the same user' do
    2.times { Identifier.new(auth).resolve }
    expect( User.count ).to eq 1
    expect( Identity.count ).to eq 1
  end

  it 'looks up users from new providers via email' do
    user = Identifier.new(auth).resolve
    new_user = Identifier.new(other).resolve
    expect( user ).to eq new_user
  end

  it 'links identities when given a user' do
    user = Identifier.new(auth).resolve
    Identifier.new(other, user).resolve
    expect( user.identities.count ).to eq 2
  end
end
