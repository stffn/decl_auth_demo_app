class ConferencesController < ApplicationController
  # Before filter to provide the objects for the actions where no params[:id]
  # is available.  See TalksController for a case where this makes sense even
  # for the index action.
  before_filter :load_conference, :only => [:show, :edit, :update, :destroy]
  before_filter :new_conference, :only => :new
  before_filter :new_conference_from_params, :only => :create
  # Installs a before_filter to check accesses on all actions for the user's
  # authorization.  :attribute_check causes the object in @conference to
  # be checked against the conditions in the authorization rules.
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => false
  
  # GET /conferences
  # GET /conferences.xml
  def index
    @conferences = Conference.with_permissions_to(:read)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conferences }
    end
  end

  # GET /conferences/1
  # GET /conferences/1.xml
  def show
    # @conference is loaded in before_filter

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @conference }
    end
  end

  # GET /conferences/new
  # GET /conferences/new.xml
  def new
    # @conference is created in before_filter

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conference }
    end
  end

  # GET /conferences/1/edit
  def edit
    # @conference is loaded in before_filter
  end

  # POST /conferences
  # POST /conferences.xml
  def create
    # @conference is created in before_filter

    respond_to do |format|
      if @conference.save
        flash[:notice] = 'Conference was successfully created.'
        format.html { redirect_to(@conference) }
        format.xml  { render :xml => @conference, :status => :created, :location => @conference }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conferences/1
  # PUT /conferences/1.xml
  def update
    # @conference is loaded in before_filter

    respond_to do |format|
      if @conference.update_attributes(params[:conference])
        flash[:notice] = 'Conference was successfully updated.'
        format.html { redirect_to(@conference) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conferences/1
  # DELETE /conferences/1.xml
  def destroy
    # @conference is loaded in before_filter
    @conference.destroy

    respond_to do |format|
      format.html { redirect_to(conferences_url) }
      format.xml  { head :ok }
    end
  end
  
  def breadcrumbs
    self.class.breadcrumbs(@conference)
  end
  
  def self.breadcrumbs (conference)
    [["Conferences", Conference.new]] +
      (conference && !conference.new_record? ? 
        [[conference.title, conference]] : [])
  end

  protected
  def load_conference
    @conference = Conference.find(params[:id])
  end

  def new_conference
    @conference = Conference.new
  end

  def new_conference_from_params
    @conference = Conference.new(params[:conference])
  end
end
