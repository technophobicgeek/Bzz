# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
# Do I want a PropertyBag or FixedSchema model?
#	- Some values need to be optional, some unique, some mandatory
#	- Can check that in controller or DB
#	- Maybe FixedSchema is better, since allows DB checking


class Partner
  include Rhom::FixedSchema

  # Uncomment the following line to enable sync with Partner.
  # enable :sync
  
  # model-specific code
  
  set :schema_version, '0.1' # pour data migration
  
  #object properties
  property :bzzid, :string
  property :name, :string
  property :nick, :string
  property :phone, :string
  property :email, :string
  property :twitter, :string

  #indexes
  unique_index :by_bzzid, [:bzzid]
  unique_index :by_phone, [:phone]
  unique_index :by_email, [:email]
  unique_index :by_twitter, [:twitter]
end
