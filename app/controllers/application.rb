# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :logged_in?

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8e49e1c945c636c4e5062b7fa72f2333'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  include AuthenticatedSystem
  layout "layout"
  
  before_filter :set_current_user
  
  hide_action :breadcrumb
  def breadcrumbs
    []
  end
  
  protected
  #def permission_denied
  #  respond_to do |format|
  #    flash[:error] = 'Sorry, you are not allowed to view the requested page.'
  #    format.html { redirect_to(:back) rescue redirect_to('/') }
  #    format.xml  { head :unauthorized }
  #    format.js   { head :unauthorized }
  #  end
  #end
  
  def set_current_user
    Authorization.current_user = current_user
  end
end
