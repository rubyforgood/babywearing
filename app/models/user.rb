class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :full_name, :street_address, :city,
            :state, :postal_code, :phone_number, presence: true

  has_many :signed_agreements
  has_many :carts

  def self.to_csv
    attributes = %w{full_name email	phone_number created_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end
end
