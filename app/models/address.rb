class Address < ApplicationRecord
  validates_presence_of :receiver, :mobile

  def clone
    self_clone = self.class.new(attributes.except('id', 'updated_at', 'created_at'))
    self_clone
  end
end
