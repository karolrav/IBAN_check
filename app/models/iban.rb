require 'csv'

class Iban < ApplicationRecord

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      s_hash = Iban.new
      s_hash.code= row[0]
      s_hash.save
    end
  end



end
