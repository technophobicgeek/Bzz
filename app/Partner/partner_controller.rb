require 'rho/rhocontroller'
require 'helpers/browser_helper'

class PartnerController < Rho::RhoController
  include BrowserHelper

  #GET /Partner
  def index
    @partners = Partner.find(:all)
    render
  end

  # GET /Partner/{1}
  def show
    @partner = Partner.find(@params['id'])
    if @partner
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Partner/new
  def new
    @partner = Partner.new
    render :action => :new
  end

  # GET /Partner/{1}/edit
  def edit
    @partner = Partner.find(@params['id'])
    if @partner
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /Partner/create
  def create
    @partner = Partner.create(@params['partner'])
    redirect :action => :index
  end

  # POST /Partner/{1}/update
  def update
    @partner = Partner.find(@params['id'])
    @partner.update_attributes(@params['partner']) if @partner
    redirect :action => :index
  end

  # POST /Partner/{1}/delete
  def delete
    @partner = Partner.find(@params['id'])
    @partner.destroy if @partner
    redirect :action => :index
  end
end
