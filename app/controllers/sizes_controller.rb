class SizesController < ApplicationController
  before_action :set_size, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /sizes or /sizes.json
  def index
    @sizes = Size.all
  end

  # GET /sizes/1 or /sizes/1.json
  def show
  end

  # GET /sizes/new
  def new
  if params[:product_id] # nested route
    @product = Product.find(params[:product_id])
    @size = @product.sizes.build
  else # standalone
    @size = Size.new
  end
end

  # GET /sizes/1/edit
  def edit
  end

  # POST /sizes or /sizes.json
  def create
  if params[:product_id] # nested route
    @product = Product.find(params[:product_id])
    @size = @product.sizes.build(size_params)
  else # standalone
    @size = Size.new(size_params)
  end

  @size.user = current_user if current_user

  if @size.save
    redirect_to @product || @size, notice: "Size created successfully."
  else
    render :new, status: :unprocessable_entity
  end
end

  # PATCH/PUT /sizes/1 or /sizes/1.json
  def update
    respond_to do |format|
      if @size.update(size_params)
        format.html { redirect_to @size, notice: "Size was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @size }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sizes/1 or /sizes/1.json
  def destroy
    @size.destroy!

    respond_to do |format|
      format.html { redirect_to sizes_path, notice: "Size was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  
  def buying_price
    size = Size.find(params[:id])
    render json: { buying_price: size.buying_price }
  end
  
   # Get sizes by selecting product
  def by_product
    product = Product.find(params[:product_id])
    sizes = product.sizes.select(:id, :name, :buying_price)

    render json: sizes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_size
      @size = Size.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def size_params
      params.expect(size: [ :name, :product_id, :buying_price, :selling_price, :user_id ])
    end
end
