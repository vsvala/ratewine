class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create_oauth
    info = request.env["omniauth.auth"].info
    auth = request.env["omniauth.auth"]
    # user = User.find_or_create_by(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    # session[:user_id] = user.id
    # #redirect_to user_path(user), notice: "Signed in!"

    # redirect_to root_path, notice: "Signed in!"
    # auth = request.env["omniauth.auth"]
    # user = User.where(:provider => auth['provider'],
    #                   :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    # reset_session

    #@user = User.from_omniauth(request.env["omniauth.auth"])
    # @user = User.create_with_omniauth(auth)
    #sign_in_and_redirect @user
    #session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    # tarkastetaan että käyttäjä olemassa, ja että salasana on oikea
    # user && user.authenticate(params[:password])

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
    redirect_to :root, :notice => "Signed out!"
  end
end
