require 'active_record'

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ConfirmedAttributes
  if defined?(ActiveRecord::Base)
    require "confirmed_attributes/version"
    require "confirmed_attributes/confirmable"
    require "confirmed_attributes/control"

    ActiveRecord::Base.extend ConfirmedAttributes::Confirmable
  end
end
