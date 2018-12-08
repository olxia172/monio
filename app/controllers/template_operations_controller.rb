class TemplateOperationsController < ApplicationController
  before_action :set_template_operation, only: [:show, :edit, :update, :destroy]

  # GET /template_operations
  # GET /template_operations.json
  def index
    @template_operations = TemplateOperation.all
  end

  # GET /template_operations/1
  # GET /template_operations/1.json
  def show
  end

  # GET /template_operations/new
  def new
    @template_operation = TemplateOperation.new
  end

  # GET /template_operations/1/edit
  def edit
  end

  # POST /template_operations
  # POST /template_operations.json
  def create
    @template_operation = TemplateOperation.new(template_operation_params)

    respond_to do |format|
      if @template_operation.save
        format.html { redirect_to @template_operation, notice: 'Template operation was successfully created.' }
        format.json { render :show, status: :created, location: @template_operation }
      else
        format.html { render :new }
        format.json { render json: @template_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /template_operations/1
  # PATCH/PUT /template_operations/1.json
  def update
    respond_to do |format|
      if @template_operation.update(template_operation_params)
        format.html { redirect_to @template_operation, notice: 'Template operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @template_operation }
      else
        format.html { render :edit }
        format.json { render json: @template_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_operations/1
  # DELETE /template_operations/1.json
  def destroy
    @template_operation.destroy
    respond_to do |format|
      format.html { redirect_to template_operations_url, notice: 'Template operation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template_operation
      @template_operation = TemplateOperation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_operation_params
      params.fetch(:template_operation, {})
    end
end
