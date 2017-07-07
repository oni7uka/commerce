module Viewable
  extend ActiveSupport::Concern

  included do
    has_many :assets, as: 'viewable', dependent: :delete_all
  end

end
