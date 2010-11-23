require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/session_helper'

class CommunicationController < Rho::RhoController
  include BrowserHelper
	include SessionHelper

  #GET /Communication
  def index
    @communications = Communication.find(:all)
    render
  end

  # GET /Communication/{1}
  def show
    @communication = Communication.find(@params['id'])
    if @communication
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Communication/new
  def new
    @communication = Communication.new
    render :action => :new
  end

  # GET /Communication/{1}/edit
  def edit
    @communication = Communication.find(@params['id'])
    if @communication
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /Communication/create
  def create
    @communication = Communication.create(@params['communication'])
    redirect :action => :index
  end

  # POST /Communication/{1}/update
  def update
    @communication = Communication.find(@params['id'])
    @communication.update_attributes(@params['communication']) if @communication
    redirect :action => :index
  end

  # POST /Communication/{1}/delete
  def delete
    @communication = Communication.find(@params['id'])
    @communication.destroy if @communication
    redirect :action => :index
  end
end
