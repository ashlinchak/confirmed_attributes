module ConfirmedAttributes
  module Confirmable

    def attribute_confirmable?
      false
    end

    def confirmable_attribute(*args)
      cattr_accessor :confirmable_attributes
      self.confirmable_attributes = args.map(&:to_sym)

      include ConfirmedAttributes::Confirmable::ConfirmableMethods
    end

    module ConfirmableMethods
      def self.included(klass)
        klass.class_eval do
          include ConfirmedAttributes::Confirmable::InstanceMethods

          has_many :confirmed_attributes, as: :targetable, dependent: :delete_all, class_name: "ConfirmedAttributes::Control"

          def self.attribute_confirmable?
            true
          end
        end
      end
    end

    module InstanceMethods
      def confirmed_attribute?(attribute_name)
        if confirmable_attribute? attribute_name
          attribute = confirmed_attributes.find_by(name: attribute_name)
          return false unless attribute

          attribute && attribute.value.to_s == send(attribute_name).to_s
        end
      end

      def confirm(attribute_name, user_id = nil)
        return false if new_record? || send(attribute_name).blank?

        confirmed_attribute = confirmed_attributes.new user_id: nil
        confirmed_attribute.verify(attribute_name)
      end

      def unconfirm(attribute_name, user_id = nil)
        array = confirmed_attributes.where(name: attribute_name, value: send(attribute_name))
        return false if new_record? || array.empty?

        !!array.delete_all
      end

      def confirmable_attribute?(attribute_name)
        return false if attribute_name.blank?

        confirmable_attributes.include? attribute_name.to_sym
      end
    end
  end
end