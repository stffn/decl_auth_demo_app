require 'digest/sha1'

class User < ActiveRecord::Base
  using_access_control
  
  include Authentication
  include Authentication::ByPassword
  #include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :roles

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  
  # Start of code needed for the declarative_authorization plugin
  # 
  # Roles are stored in a serialized field of the User model.
  # For many applications a separate UserRole model might be a
  # better choice.
  serialize :roles, Array

  # The necessary method for the plugin to find out about the role symbols
  # Roles returns e.g. [:admin]
  def role_symbols
    @role_symbols ||= (roles || []).map {|r| r.to_sym}
  end
  # End of declarative_authorization code

  
  # Application-specific code  
  has_many :talk_attendees
  has_many :conference_attendees

  # for ChangeAnalyzer: ensure that role_symbols is cloned
  def clone
    a_clone = super
    a_clone.send(:instance_variable_set, :@role_symbols, @role_symbols.clone) if @role_symbols
    a_clone
  end
end
