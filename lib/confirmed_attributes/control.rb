module ConfirmedAttributes
  class Control < ActiveRecord::Base
    self.table_name_prefix = "confirmed_attributes_"

    belongs_to :user
    belongs_to :targetable, polymorphic: true

    validates :name, :value, :targetable, presence: true

    def title
      "#{name}: #{value}"
    end

    def verify(attribute_name)
      if targetable.confirmable_attribute?(attribute_name)
        self.name = attribute_name.to_s
        self.value = targetable.send(attribute_name).to_s
        save
      end
    end

  end
end
