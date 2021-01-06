class IbansController < ApplicationController
  before_action :set_iban, only: [:show, :edit, :update, :destroy]

  # GET /ibans
  # GET /ibans.json
  def index

    @ibans = Iban.where(code: params[:query])
    end

  # GET /ibans/1
  # GET /ibans/1.json
  def show
    @iban = Iban.find(params[:id])
    if contains(@iban) != nil
      @iban.is_seb =true
    else
      @iban.is_seb =false
    end
  end

  # GET /ibans/new
  def new
    @iban = Iban.new
  end


  # POST /ibans
  # POST /ibans.json
  def import
    Iban.import(params[:file])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_iban
    @iban = Iban.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def iban_params
    params.require(:iban).permit(:code, :bank, :is_seb)
  end

  def contains(str)
    str =~ /LT[a-zA-Z0-9]{2}\s?([0-9]{4}\s?){4}\s?/
  end

end
