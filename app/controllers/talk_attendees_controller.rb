class TalkAttendeesController < ApplicationController
  filter_resource_access :nested_in => :talks

  # provided by filter_resource_access:
  #before_filter :load_talk
  #before_filter :new_talk_attendee, :only => :create
  #filter_access_to :all, :attribute_check => true

  def create
    respond_to do |format|
      if @talk_attendee.save
        flash[:notice] = 'Successfully signed up to talk.'
        format.html { redirect_to(@talk.conference) }
        format.xml  { render :xml => @talk_attendee, :status => :created, :location => @talk }
      else
        flash[:error] = 'Error signing up to talk.'
        format.html { redirect_to(@talk.conference) }
        format.xml  { render :xml => @talk_attendee.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @talk_attendee.destroy
    flash[:notice] = 'Successfully unregistered from talk.'

    respond_to do |format|
      format.html { redirect_to(@talk.conference) }
      format.xml  { head :ok }
    end
  end

  protected
  # provided by filter_resource_access:
  #def load_talk
  #  @talk = Talk.find(params[:talk_id])
  #end

  # overwriting default filter_resource_access new method:
  def new_talk_attendee_from_params
    @talk_attendee = @talk.talk_attendees.new(:user => current_user)
  end
end
