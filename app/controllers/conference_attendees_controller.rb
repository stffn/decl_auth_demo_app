class ConferenceAttendeesController < ApplicationController
  filter_resource_access :nested_in => :conferences
  
  # provided by filter_resource_access:
  #before_filter :load_conference
  #before_filter :new_conference_attendee, :only => :create
  # See ConferenceController for comments on the most common use of
  # filter_access_to
  #filter_access_to :all, :attribute_check => true
  
  def create
    respond_to do |format|
      if @conference_attendee.save
        flash[:notice] = 'Successfully registered with conference.'
        format.html { redirect_to(conferences_url) }
        format.xml  { render :xml => @conference_attendee, :status => :created, :location => @conference }
      else
        flash[:error] = 'Error registering with conference.'
        format.html { redirect_to(conferences_url) }
        format.xml  { render :xml => @conference_attendee.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @conference_attendee.destroy
    flash[:notice] = 'Successfully unregistered from conference.'

    respond_to do |format|
      format.html { redirect_to(conferences_url) }
      format.xml  { head :ok }
    end
  end

  protected
  # provided by filter_resource_access
  #def load_conference
  #  @conference = Conference.find(params[:conference_id])
  #end

  # Overriding the default filter_resource_access new method:
  def new_conference_attendee_from_params
    @conference_attendee = @conference.conference_attendees.new(:user => current_user)
  end
end
