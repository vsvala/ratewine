require 'rails_helper'

include Helpers

describe "User" do
  # before :each do
    let(:user){FactoryBot.create :user}

  # end

  describe "who has signed up" do
    it "can signin with right credentials" do
      allow_any_instance_of(UsersController).to receive(:current_user).and_return(user) 
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end 
  end

  it "is redirected back to signin form if wrong credentials given" do
    allow_any_instance_of(UsersController).to receive(:current_user).and_return(user) 
    visit signin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'wrong')
    click_button('Log in')

    # save_and_open_page

    expect(current_path).to eq(signin_path)
    expect(page).to have_content 'Username and/or password mismatch'
  end
  
  it "when signed up with good credentials, is added to the system" do
    allow_any_instance_of(UsersController).to receive(:current_user).and_return(user) 

    
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
    # save_and_open_page
  end




end