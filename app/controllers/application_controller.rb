# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5ee0c1f9ce72a776ebba8a8c3338e3d2'

  protected

  def current_user
    @current_user ||= (load_user_from_cookie || create_user)
  end
  helper_method :current_user

  def load_user_from_cookie
    User.find_by_id(cookies[:user_id]) if cookies[:user_id]
  end

  def create_user
    user = User.create!
    cookies[:user_id] = {:value => user.id, :expires => 5.years.from_now}
    user
  end

  def suspected_spam_user?
    %w(76.168.113.69 84.46.116.13).include? request.remote_ip
  end

  def current_period
    @current_period ||= params[:period].present? ? params[:period] : 'hour'
  end
  helper_method :current_period

  def current_vurl
    @current_vurl ||= if params[:slug]
                Vurl.find_by_slug params[:slug]
              else
                Vurl.find_by_id params[:id]
              end
  end
  helper_method :current_vurl
end
