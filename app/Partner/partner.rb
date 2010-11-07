# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
# Do I want a PropertyBag or FixedSchema model?
#	- Some values need to be optional, some unique, some mandatory
#	- Can check that in controller or DB
#	- Maybe FixedSchema is better, since allows DB checking


class Partner
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Partner.
  # enable :sync

  #add model specifc code here
end
