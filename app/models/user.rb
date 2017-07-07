class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :orders, inverse_of: :user do
    def cart &block
      find_or_create_by(state: :cart, &block)
    end
  end

  belongs_to :address, optional: true

  def email_required?
    false
  end
end
