require 'csv'

class Iban < ApplicationRecord

  validates :code, presence: true, uniqueness: true
  def self.import(file)
    CSV.foreach(file.path, headers: false) do |row|
      s_hash = Iban.new
      s_hash.code= row[0]
        if (s_hash.code.match(/^(?=.{1,20}$)[A-Z]{2}\d{2} ?\d{4} ?\d{4} ?\d{4} ?\d{4}/)) && (s_hash.code.include?('7044'))
          s_hash.bank = true
          s_hash.is_seb = 'SEB'
          s_hash.save
        elsif
        (s_hash.code.match(/^(?=.{1,20}$)[A-Z]{2}\d{2} ?\d{4} ?\d{4} ?\d{4} ?\d{4}/)) && (s_hash.code.exclude?('7044'))
          s_hash.bank = true
          s_hash.is_seb = 'BANK'
          s_hash.save
        else
          s_hash.bank = false
          s_hash.is_seb = "Incorrect IBAN"
          s_hash.save
        end
      end
    end



  def self.to_csv
    attributes = %w{code is_seb bank}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      Iban.all.each do |iban|
        csv << [iban.code, iban.is_seb, iban.bank]
      end
    end
  end

  end
