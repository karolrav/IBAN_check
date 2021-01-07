class IbansController < ApplicationController
  before_action :set_iban, only: [:show, :edit, :update, :destroy]

  def index
    @iban = Iban.all
    @ibans = Iban.where(code: params[:query])
    respond_to do |format|
      format.html
    format.csv { send_data @iban.to_csv }
    end
    end

  def show
    @iban = Iban.find(params[:id])
    if (contains(@iban) != nil)
      @iban.is_seb =true
      @iban.save
    else
      @iban.is_seb =false
      @iban.save
    end
  end


  def new
    @iban = Iban.new
  end


  def import
    @ibans = Iban.all
    Iban.import(params[:file])#

  end

  def self.to_csv
    attributes = %w{code is_seb bank}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      @iban.each do |iban|
        csv << [iban.code, iban.is_seb, iban.bank]
      end
    end
  end

  private

  def set_iban
    @iban = Iban.find(params[:id])
  end

  def iban_params
    params.require(:iban).permit(:code, :bank, :is_seb)
  end

  def contains(str)
    str =~ /[A-Z]{2}\d{2} ?\d{4} ?\d{4} ?\d{4} ?\d{4} ?[\d]{0,2}/
  end

end
