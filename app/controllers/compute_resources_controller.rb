class ComputeResourcesController < ApplicationController
  include Foreman::Controller::AutoCompleteSearch
  AJAX_REQUESTS = %w{hardware_profile_selected cluster_selected}
  before_filter :ajax_request, :only => AJAX_REQUESTS
  before_filter :find_by_id, :only => %w{show edit update destroy} + AJAX_REQUESTS

  def index
    values = ComputeResource.search_for(params[:search], :order => params[:order])
    respond_to do |format|
      format.html {@compute_resources = values.paginate :page => params[:page]}
      format.json {render :json => ComputeResource.all}
    end
  end

  def new
    @compute_resource = ComputeResource.new
  end

  def create
    @compute_resource = ComputeResource.new_provider params[:compute_resource]
    if @compute_resource.save
      process_success
    else
      process_error
    end
  end

  def edit
  end

  def update
    if @compute_resource.update_attributes(params[:compute_resource])
      process_success
    else
      process_error
    end
  end

  def destroy
    if @compute_resource.destroy
      process_success
    else
      process_error
    end
  end

  #ajax methods
  def hardware_profile_selected
    compute = @compute_resource.hardware_profile(params[:hwp_id])
    respond_to do |format|
      format.json { render :json => compute }
    end
  end

  def cluster_selected
    networks = @compute_resource.networks(:cluster_id => params[:cluster_id])
    respond_to do |format|
      format.json { render :json => networks }
    end
  end

  private

  def find_by_id
    @compute_resource = ComputeResource.find(params[:id])
  end
end
