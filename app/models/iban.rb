require 'csv'

class Iban < ApplicationRecord

  validates :code, presence: true, uniqueness: true
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      s_hash = Iban.new
      s_hash.code= row[0]
      s_hash.save
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
