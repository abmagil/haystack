###############################################################################
# AddressSearcher: Searches over your Address Model
# 
###############################################################################
class AddressSearcher < Haystack::BaseSearcher

  BASE = Address

  #############################################################################
  # SEARCHABLE FIELDS: uncomment `attr_accessor` below and define any model
  # attributes you would like to search over
  # attr_accessor 
  # 
  ###############################################################################


  # Haystack uses rails' understanding of classes

  protected

  #----------------------------------------------------------------------------
  # Simple Equality Queries
  # Wherever simple equality is acceptable (e.g. "id = 7", "id in (4,5)")
  # the searcher handles this out of the box
  #----------------------------------------------------------------------------

  #----------------------------------------------------------------------------
  # Inequality Queries
  # Most commonly dates and dollar values, add any methods here which search
  # based on an inequality (e.g. "cash_value < 10000")
  #----------------------------------------------------------------------------
  
  #----------------------------------------------------------------------------
  # Boolean Queries 
  # Not checking a box does not equal "restrict to things where this is false"
  #----------------------------------------------------------------------------

  #----------------------------------------------------------------------------
  # Custom Queries 
  # When search logic doesn't fall into the above categories, place logic below
  #----------------------------------------------------------------------------
    


end