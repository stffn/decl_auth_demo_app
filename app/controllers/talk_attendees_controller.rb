class TalkAttendeesController < ApplicationController
  filter_access_to :all
  filter_access_to :destroy, :attribute_check => true
    
  def index
    @talk = Talk.find(params[:talk_id])
    @attendees = @talk.attendees

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attendees }
    end
  end

  filter_access_to :create do
    @talk = Talk.find(params[:talk_id])
    @attendee = TalkAttendee.new(:talk => @talk,
                                 :user => current_user)
    permitted_to!(:create, @attendee)
  end
  def create
    respond_to do |format|
      if @attendee.save
        flash[:notice] = 'Successfully signed up to talk.'
        format.html { redirect_to(@talk.conference) }
        format.xml  { render :xml => @attendee, :status => :created, :location => @talk }
      else
        flash[:error] = 'Error signing up to talk.'
        format.html { redirect_to(@talk.conference) }
        format.xml  { render :xml => @attendee.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendee = TalkAttendee.find(params[:id])
    @attendee.destroy
    @talk = Talk.find(params[:talk_id])
    flash[:notice] = 'Successfully unregistered from talk.'

    respond_to do |format|
      format.html { redirect_to(@talk.conference) }
      format.xml  { head :ok }
    end
  end

end
