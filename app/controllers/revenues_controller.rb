class RevenuesController < ApplicationController
  before_action :set_revenue, only: [:show, :edit, :update, :destroy]

  # GET /revenues
  # GET /revenues.json
  def index
    @revenues = Revenue.where(user: current_user).paginate(:page => params[:page], :per_page => 5)
  end

  # GET /revenues/1
  # GET /revenues/1.json
  def show
  end

  # GET /revenues/new
  def new
    @revenue = Revenue.new
  end

  # GET /revenues/1/edit
  def edit
  end

  # POST /revenues
  # POST /revenues.json
  def create
    @revenue = Revenue.new(revenue_params)
    @revenue.user = current_user

    respond_to do |format|
      if @revenue.save
        format.html { redirect_to @revenue, notice: 'Receita foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @revenue }
      else
        format.html { render :new }
        format.json { render json: @revenue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revenues/1
  # PATCH/PUT /revenues/1.json
  def update
    respond_to do |format|
      if @revenue.update(revenue_params)
        format.html { redirect_to @revenue, notice: 'Receita foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @revenue }
      else
        format.html { render :edit }
        format.json { render json: @revenue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revenues/1
  # DELETE /revenues/1.json
  def destroy
    respond_to do |format|
      if @revenue.destroy
        format.html { redirect_to revenues_url, notice: 'Receita foi excluída com sucesso.' }
      else
        format.html { redirect_to revenues_url, alert: @revenue.errors.messages[:base].first}
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revenue
      @revenue = Revenue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revenue_params
      params.require(:revenue).permit(:name, :fixed, :category_id)
    end
end
