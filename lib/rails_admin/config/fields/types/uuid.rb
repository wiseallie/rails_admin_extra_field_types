require 'rails_admin/config/fields/base'

module RailsAdmin::Config::Fields::Types
  class Uuid < RailsAdmin::Config::Fields::Types::String
    RailsAdmin::Config::Fields::Types::register(:uuid, self)
  end
end
