class CallsController < ApplicationController
  before_action :set_call, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :edit, :update]
  before_action :authenticate_user!

  # GET /calls
  # GET /calls.json
  def index
    @q = Call.ransack(params[:q])
    @calls = @q.result.includes(:client)
    #@calls = Call.all
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
    @call = Call.find(params[:id])
  end

  # GET /calls/new
  def new
    @call = Call.new
  end

  # GET /calls/1/edit
  def edit
    @call = Call.find(params[:id])
  end

  # POST /calls
  # POST /calls.json
  def create
    @call = Call.new(call_params)

    respond_to do |format|
      if @call.save
        format.html { redirect_to @call, notice: 'Call was successfully created.' }
        format.json { render :show, status: :created, location: @call }
      else
        format.html { render :new }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calls/1
  # PATCH/PUT /calls/1.json
  def update
    respond_to do |format|
      if @call.update(call_params)
        format.html { redirect_to @call, notice: 'Call was successfully updated.' }
        format.json { render :show, status: :ok, location: @call }
      else
        format.html { render :edit }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1
  # DELETE /calls/1.json
  def destroy
    @call.destroy
    respond_to do |format|
      format.html { redirect_to calls_url, notice: 'Call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call
      @call = Call.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def call_params
      params.require(:call).permit(:call_date, :details, :interest_level, :next_call, :annotation, :client_id)
    end

    def set_client
      @clients = Client.all
    end
end
