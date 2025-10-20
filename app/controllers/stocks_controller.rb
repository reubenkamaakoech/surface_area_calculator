class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /stocks or /stocks.json
  def index
    @grouped_stock_items = StockItem.grouped_by_product_and_size
  end

  # GET /stocks/1 or /stocks/1.json
  def show
    @stock = Stock.find(params[:id])

    # highlight row in group_show view if more than one stock entry
    @highlight_stock_item_id = params[:highlight_stock_item_id]&.to_i
  end

  # GET /stocks/group_show
  def group_show
  @product = Product.find(params[:product_id])
  @size = Size.find(params[:size_id])
  @stocks = StockItem.where(product_id: @product.id, size_id: @size.id).order(:created_at)
  end


  # GET /stocks/new
  def new
    @stock = Stock.new
    @stock.stock_items.build
  end

  # GET /stocks/1/edit
  def edit
    @stock.stock_items.build if @stock.stock_items.empty?
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy!

    respond_to do |format|
      format.html { redirect_to stocks_path, notice: "Stock was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_stock
      @stock = Stock.find(params[:id])
    end

    def stock_params
      params.require(:stock).permit(
        :user_id,
        stock_items_attributes: [:id, :product_id, :size_id, :quantity, :_destroy]
      )
    end
end
