class ConferenceAttendeesController < ApplicationController
  # See ConferenceController for comments on the most common use of 
  # filter_access_to
  filter_access_to :all
  filter_access_to :destroy, :attribute_check => true
    
  def index
    @conference = Conference.find(params[:conference_id])
    @attendees = @conference.attendees

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attendees }
    end
  end

  # In the case of create, declarative_authorization cannot load an
  # object from the params hash by default.  The object is needed to
  # check the authorization rules defined in the configuration.
  # Instead, an new Attendee object is created with the known parameters
  # and checked for in a block given to filter_access_to.
  filter_access_to :create do
    @conference = Conference.find(params[:conference_id])
    @attendee = ConferenceAttendee.new(:conference => @conference,
                                       :user => current_user)
    permitted_to!(:create, @attendee)
  end
  def create
    respond_to do |format|
      if @attendee.save
        flash[:notice] = 'Successfully registered with conference.'
        format.html { redirect_to(conferences_url) }
        format.xml  { render :xml => @attendee, :status => :created, :location => @conference }
      else
        flash[:error] = 'Error registering with conference.'
        format.html { redirect_to(conferences_url) }
        format.xml  { render :xml => @attendee.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendee = ConferenceAttendee.find(params[:id])
    @attendee.destroy
    @conference = Conference.find(params[:conference_id])
    flash[:notice] = 'Successfully unregistered from conference.'

    respond_to do |format|
      format.html { redirect_to(conferences_url) }
      format.xml  { head :ok }
    end
  end

end
