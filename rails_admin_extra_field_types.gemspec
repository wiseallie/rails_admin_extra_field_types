$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_extra_field_types/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_extra_field_types"
  s.version     = RailsAdminExtraFieldTypes::VERSION
  s.authors     = ["wiseallie"]
  s.email       = ["wiseallie@gmail.com"]
  s.homepage    = "https://github.com/wiseallie/rails_admin_extra_field_types"
  s.summary     = "Support for rails_admin field types UUID and Citext "
  s.description = "Support for rails_admin field types UUID and Citext "
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "rails_admin", ">= 0.6.0"

  s.add_development_dependency "pg"
end
