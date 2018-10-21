class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create_oauth
    username = request.env['omniauth.auth'].info['email']

    user = User.find_by username: params[:username]

    if user&.closed
      redirect_to signin_path, notice: "your accout is closed, please contact admin"
    end

    if user.nil?
      user = User.new username: username
      user.save(validate: false)
    end

    session[:user_id] = user.id
    redirect_to user_path(user), notice: "Welcome!"
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    # tarkastetaan että käyttäjä olemassa, ja että salasana on oikea
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # uudelleen ohjataan käyttäjä omalle sivulleen
      if !user.close
        redirect_to user_path(user), notice: "Welcome back!"
      else
        redirect_to signin_path, notice: "your account is closed, please contact admin"
      end
    else
      redirect_to signin_path, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root, notice: :"Signed out!"
  end
end
