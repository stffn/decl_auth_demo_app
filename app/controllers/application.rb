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
  
  hide_action :breadcrumb
  def breadcrumbs
    []
  end
  
  # Start of declaration_authorization-related code
  before_filter :set_current_user
  
  # One way of using declarative_authorization is to restrict access
  # to controller actions by default by stating the following line.
  # This installs a default before_filter for authorization according
  # to the action names.
  #filter_access_to :all
  
  protected
  # There are multiple ways of handling authorization failures.  
  # One is to implement a permission denied method as shown below.  
  # If none is defined, either a simple string is displayed
  # to the user ("You are not allowed...", default) or the authorization
  # exception is raised.  TODO state configuration option
  # 
  #def permission_denied
  #  respond_to do |format|
  #    flash[:error] = 'Sorry, you are not allowed to view the requested page.'
  #    format.html { redirect_to(:back) rescue redirect_to('/') }
  #    format.xml  { head :unauthorized }
  #    format.js   { head :unauthorized }
  #  end
  #end
  
  # set_current_user sets the global current user for this request.  This
  # is used by model security that does not have access to the
  # controller#current_user method.  It is called as a before_filter.
  def set_current_user
    Authorization.current_user = current_user
  end
end
