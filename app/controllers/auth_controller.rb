class AuthController < ApplicationController

  PAVLOK_CLIENT_ID     = "Grab from the Pavlok"
  PAVLOK_CLIENT_SECRET = "Grab from the Pavlok"
  PAVLOK_REDIRECT_URI  = "Grab from the Pavlok"


  # http://localhost:3000/auth/pavlok/result
  def index
    # authorize app to get the access_token for further calls
    @pavlok = Pavlok::Client.new(client_id: PAVLOK_CLIENT_ID, redirect_uri: PAVLOK_REDIRECT_URI, client_secret: PAVLOK_CLIENT_SECRET)
    @pavlok_auth_url = @pavlok.code_url

    if params[:code].present?
      code = params[:code]
      access_token = @pavlok.fetch_access_token(code)
      # save access token in db for each user to reuse that token
      session[:pavlok_access_token] ||= access_token
      # @pavlok.zap(127)
      # @pavlok.beep(2)
      # @pavlok.vibration(127)
      return render json: @pavlok.zap(127)
    end
  end

  # http://localhost:3000/reuse
  def reuse_token
    # get token from db for user.
    # token = current_user.pavlok_access_token
    # Or in my case I currently not using db I am saving token in session just for demo
    @pavlok = Pavlok::Client.new(access_token: session[:pavlok_access_token])
    # zap is sent to device
    return render json: @pavlok.zap(127)
  end

end
