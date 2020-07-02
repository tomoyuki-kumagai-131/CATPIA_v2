include ApplicationHelper # full_titleメソッドを読み込む

def is_logged_in?
  !session[:user_id].nil?
end

def login_for_request(user)
  post login_path, params: { session: { email: user.email,
                                        password: user.password } }
end

def login_for_system(user)
  visit login_path
  fill_in "user_email",    with: user.email
  fill_in "user_password", with: user.password
  click_button "ログイン"
end

def login_remember(user)
  post login_path, params: { session: { email: user.email,
                                        password: user.password,
                                        remember_me: '1' } }
end

def current_user
  if (user_id = session[:user_id])
    User.find_by(id: user_id)
  elsif (user_id = cookies.signed[:user_id])
    user = User.find_by(id: user_id)
    if user && user.authenticated?(cookies[:remember_token])
      login_for_request user
      user
    end
  end
end
