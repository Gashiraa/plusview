class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @search = Project.ransack(params[:q])
    @projects = @search.result(distinct: true)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show

  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params_create)

    respond_to do |format|
      if @project.save
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects, @project.invoice.wares)
        format.html {redirect_to projects_url, notice: t('Project was successfully created.')}
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
        format.html {redirect_to projects_url, notice: t('Project was successfully updated.')}
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
      format.html {redirect_to projects_url, notice: t('Project was successfully destroyed.')}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params_create
    params.permit(:invoice_id, :quotation_id, :customer_id, :name, :status, :wielding, :machining, :karcher, :total, :total_gross)
  end

  def project_params
    params.require(:project).permit(:invoice_id, :quotation_id, :customer_id, :name, :status, :wielding, :machining, :karcher, :total, :total_gross)
  end
end
