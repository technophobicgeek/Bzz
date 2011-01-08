require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/communication_helper'
require 'helpers/pattern_helper'

class SessionController < Rho::RhoController
  include BrowserHelper
	include CommunicationHelper
  include PatternHelper
 
  #GET /Session
  def index
    @sessions = Session.find(:all)
    render
  end

  # GET /Session/{1}
  def show
    @session = Session.find(@params['id'])
    if @session
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Session/new
  def new
    @session = Session.new
    render :action => :new
  end

  # GET /Session/{1}/edit
  def edit
    @session = Session.find(@params['id'])
    if @session
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /Session/create
  def create
    @session = Session.create(@params['session'])
    redirect :action => :index
  end

  # POST /Session/{1}/update
  def update
    @session = Session.find(@params['id'])
    @session.update_attributes(@params['session']) if @session
    redirect :action => :index
  end

  # POST /Session/{1}/delete
  def delete
    @session = Session.find(@params['id'])
    @session.destroy if @session
    redirect :action => :index
  end


# Custom code

  # When a session is started, create a new instance of the pattern class
  # and then go to the controlpanel page
  
  def start_session
    @@pattern = PatternHelper::Pattern.new(Session.count + 1)
    render :action => :controlpanel
  end

  # Head back to start page
  def end_session
    puts "DEBUG: ending session"
    $channel.turn_off
    @@pattern.end_pattern
    
    puts 'DEBUG:'
    puts @@pattern.inspect
    
    # Create a session entity, update its attributes and then go to session edit page
    session_vars = @@pattern.get_session_vars
    
    puts 'DEBUG:'
    puts session_vars

    @session = Session.create(session_vars)
    
    # Destroy the pattern
    @@pattern = nil

    redirect :action => :edit, :id => @session.object
    
  end
  
  def replay_session
    @session = Session.find(@params['id'])
    
    # Create a pattern from the session object
    puts 'DEBUG'
    puts @session.sequence
    @@pattern = PatternHelper::PlayPattern.new(@session.sequence)
    # Play the pattern
    
    play_pattern @@pattern
    
    @@pattern = nil
    # Go to Home screen
    WebView.navigate Rho::RhoConfig.start_path
  end
  
end
