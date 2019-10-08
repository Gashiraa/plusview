class ProjectExtraLinesController < ApplicationController
  before_action :set_project_extra_line, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /project_extra_lines
  # GET /project_extra_lines.json
  def index
    @project_extra_lines = ProjectExtraLine.all
  end

  # GET /project_extra_lines/1
  # GET /project_extra_lines/1.json
  def show
  end

  # GET /project_extra_lines/new
  def new
    @project_extra_line = ProjectExtraLine.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new_manual
    @project_extra_line = ProjectExtraLine.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /project_extra_lines/1/edit
  def edit
    @extra = ProjectExtraLine.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit_manual
    @extra = ProjectExtraLine.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /project_extra_lines
  # POST /project_extra_lines.json
  def create
    @project_extra_line = ProjectExtraLine.new(project_extra_line_params)
    respond_to do |format|
      if @project_extra_line.save
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_extra_line_add_success')}
        format.json {render :show, status: :created, location: @project_extra_line}
      else
        format.html {render :new}
        format.json {render json: @project_extra_line.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /project_extra_lines/1
  # PATCH/PUT /project_extra_lines/1.json
  def update
    respond_to do |format|
      if @project_extra_line.update(project_extra_line_params)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_extra_line_update_success')}
        format.json {render :show, status: :ok, location: @project_extra_line}
      else
        format.html {render :edit}
        format.json {render json: @project_extra_line.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /project_extra_lines/1
  # DELETE /project_extra_lines/1.json
  def destroy
    @project_extra_line.destroy
    respond_to do |format|
      format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_extra_line_delete_success')}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project_extra_line
    @project_extra_line = ProjectExtraLine.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_extra_line_params
    params.require(:project_extra_line).permit(:project_id, :extra_id, :quantity,:total, :total_gross, :manual_name, :manual_price, :tva_rate, :unit, :is_manual)
  end
end
