# frozen_string_literal: true

class ProjectsController < ApplicationController

  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects
  # GET /projects.json
  def index
    @search = Project.order(date: :desc).ransack(params[:q])
    @projects = @search.result(distinct: true).paginate(page: params[:page], per_page: 12)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show;
  end

  # GET /projects/new
  def new
    @project = Project.new
    respond_to(&:js)
  end

  # GET /projects/1/edit
  def edit;
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects, @project.invoice.wares)
        format.html {redirect_to projects_url, notice: t('project_add_success')}
        format.json {render :show, status: :created, location: @project}
      else
        format.html {render :new}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects, @project.invoice.wares)
        format.html {redirect_to projects_url, notice: t('project_update_success')}
        format.json {render :show, status: :ok, location: @project}
      else
        format.html {render :edit}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html {redirect_to projects_url, notice: t('project_destroy_success')}
      format.json {head :no_content}
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:invoice_id, :quotation_id, :customer_id, :name, :status, :wielding, :machining, :karcher, :total, :total_gross, :date, :description)
  end

end
