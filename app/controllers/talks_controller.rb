class TalksController < ApplicationController
  filter_resource_access :nested_in => :conferences

  # provided by filter_resource_access:
  #before_filter :load_conference
  #before_filter :load_talk, :only => [:show, :edit, :update, :destroy]
  #before_filter :new_talk, :only => [:new, :create, :index]
  #filter_access_to :all, :attribute_check => true
  
  # GET /talks
  # GET /talks.xml
  def index
    @talks = @conference.talks

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @talks }
    end
  end

  # GET /talks/1
  # GET /talks/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @talk }
    end
  end

  # GET /talks/new
  # GET /talks/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @talk }
    end
  end

  # GET /talks/1/edit
  def edit
  end

  # POST /talks
  # POST /talks.xml
  def create
    respond_to do |format|
      if @talk.save
        flash[:notice] = 'Talk was successfully created.'
        format.html { redirect_to([@talk.conference, @talk]) }
        format.xml  { render :xml => @talk, :status => :created, :location => @talk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /talks/1
  # PUT /talks/1.xml
  def update
    respond_to do |format|
      if @talk.update_attributes(params[:talk])
        flash[:notice] = 'Talk was successfully updated.'
        format.html { redirect_to([@talk.conference, @talk]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.xml
  def destroy
    @talk.destroy

    respond_to do |format|
      format.html { redirect_to(@conference) }
      format.xml  { head :ok }
    end
  end
  
  def breadcrumbs
    self.class.breadcrumbs(@conference || @talk.conference, @talk)
  end
  
  def self.breadcrumbs (conference, talk)
    (conference ? ConferencesController.breadcrumbs(conference) : []) +
      (talk && !talk.new_record? ? 
        [[talk.title, [conference, talk]]] : [])
  end
  
  protected
  # provided by the default filter_resource_access before_filters
  #def load_conference
  #  @conference = Conference.find(params[:conference_id])
  #end
  #
  #def load_talk
  #  @talk = Talk.find(params[:id])
  #end
  #
  #def new_talk
  #  @talk = @conference.talks.new(params[:talk])
  #end
end
