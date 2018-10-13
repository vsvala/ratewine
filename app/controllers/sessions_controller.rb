class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create_oauth
    request.env['omniauth.auth'].info
    #<OmniAuth::AuthHash::InfoHash email="mluukkai@iki.fi" image="https://avatars1.githubusercontent.com/u/523235?v=4" name="Matti Luukkainen" nickname="mluukkai" urls=#<OmniAuth::AuthHash Blog="" GitHub="https://github.com/mluukkai">>
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
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
    redirect_to :root
  end
end
