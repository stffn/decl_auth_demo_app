class ConferenceAttendeesController < ApplicationController
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
