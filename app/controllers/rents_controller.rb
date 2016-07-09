class RentsController < ApplicationController
  before_action :set_rent#, only: [:destroy, :pay2go_cc_notify, :redirecting]
  protect_from_forgery except: :pay2go_cc_notify

  def redirecting    
  end

  def pay2go_cc_notify
    respond = JSON.parse(params["JSONData"])
    if respond["Status"] == "SUCCESS"
      @rent.make_payment!(JSON.parse(respond["Result"]))

      # if @rent.paid?
      #   # UserMailer.pay_rent_success_mail(@rent).deliver_later
      #   flash[:success] = "Thanks!"#I18n.t('flash.messages.rent_payment_success')
      #   redirect_to result_rent_path(@rent)
      # else
      #   #render text: I18n.t('flash.messages.rent_payment_fail')
      # end
      redirect_to result_rent_path(@rent.token)
    elsif respond["Status"] == "TRA20004"
      redirect_to redirecting_rent_path(@rent.token)
      #binding.pry
      #render text: I18n.t('flash.messages.transaction_fail')
    else
      redirect_to result_rent_path(@rent.token , status: respond["Status"])
    end
  end

  def result
  end

  # GET /rents/new
  def new
    @rent = Rent.new
  end

  # POST /rents
  # POST /rents.json
  def create
    @rent = Rent.new(rent_params)

    respond_to do |format|
      if @rent.save
        format.html { redirect_to redirecting_rent_path(@rent.token) }#, notice: 'Rent was successfully created.' }
        format.json { render json: { url: redirecting_rent_path(@rent.token) }, status: :created, location: @rent }
      else
        format.html { render :new }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @rent.update(rent_params)
        format.html { redirect_to redirecting_rent_path(@rent.token) }
        format.json { render json: { url: redirecting_rent_path(@rent.token) }, status: :created, location: @rent }
      else
        format.html { render :edit }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rent
      @rent = Rent.find_by_id(params[:id]) || Rent.find_by_token(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rent_params
      params.require(:rent).permit(:token, :pay_state, :total, :payment_method, :house_name, :room_name, :receipt_num)
    end
end
