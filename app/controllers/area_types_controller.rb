class AreaTypesController < ApplicationController
  before_action :set_area_type, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /area_types or /area_types.json
  def index
    @area_types = AreaType.all
  end

  # GET /area_types/1 or /area_types/1.json
  def show
  end

  # GET /area_types/new
  def new
    @area_type = AreaType.new
  end

  # GET /area_types/1/edit
  def edit
  end

  # POST /area_types or /area_types.json
  def create
    @area_type = AreaType.new(area_type_params)

    respond_to do |format|
      if @area_type.save
        format.html { redirect_to @area_type, notice: "Area type was successfully created." }
        format.json { render :show, status: :created, location: @area_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @area_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /area_types/1 or /area_types/1.json
  def update
    respond_to do |format|
      if @area_type.update(area_type_params)
        format.html { redirect_to @area_type, notice: "Area type was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @area_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @area_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /area_types/1 or /area_types/1.json
  def destroy
    @area_type.destroy!

    respond_to do |format|
      format.html { redirect_to area_types_path, notice: "Area type was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area_type
      @area_type = AreaType.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def area_type_params
      params.expect(area_type: [ :name, :user_id ])
    end
end
