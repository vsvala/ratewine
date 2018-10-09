class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
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
