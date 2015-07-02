module Haystack
# Abstract class holding all common search functionality
# 
# The key to the searcher is in #condition_part_array and #method_missing:
# condition_part_array transforms front-end parameters into method calls
# to methods that fit a known regex.  These method calls are expected to fail,
# and hit method_missing where we extract the information back out of the regex
# and create an ActiveRecord::Relation.  The AR:Relations get zipped up and fired,
# returning the requested data
#   
# This will only work for equality checks, i.e. WHERE `id` = 15.  If the developer
# wants to bolster the searcher with new behavior, they need simply intercept the
# method call before it hits method_missing.  This means adding in a method in their
# generated searcher class that fits the regex and writing the relevant logic.
# Their new method MUST conform to the interface expected by #concatenated_queries, 
# which applies ActiveRecord::Relation#merge
  class BaseSearcher

    #performs ActiveRecord-like mass assignment of attributes             
    def initialize(attributes = {})
      raise ArgumentError, "When assigning attributes, you must pass a hash as an argument." unless attributes.is_a? Hash
      mass_assign(attributes)
    end    
    
    # Caches the rows
    def data
      @data ||= concatenated_queries
    end
    
    def to_s
      conditions
    end

    protected

    #############################################################################
    # Creation methods
    #############################################################################

    # requires each attribute in the hash to be names the same as the class property
    def mass_assign(attributes)
      attributes.each do |attribute, value|
        respond_to?("#{attribute}=") && send("#{attribute}=", value)
      end
    end

    #############################################################################
    # Querying methods
    #############################################################################
    def concatenated_queries
      # Reduce as in map-reduce- ANDs together multiple SQL queries
      # while still lazy-loading them
      condition_part_array.reduce(:merge)
    end

    # Transform from ivar names to method calls fitting the Haystack regex
    # Returns an array of ActiveRecord::Relations (or respond to ActiveRecord::Relation#merge)
    def condition_part_array
      instance_values.keys.map do |ivar_name|
        new_method_name = "#{ivar_name}_conditions"
        send(new_method_name)
      end
    end

    # method_missing's job in Haystack is to convert from regex-matching but undefined method calls
    # into ActiveRecord::Relation queries
    def method_missing(meth, *args, &block)
      # NOTE: We are intentionally assigning regex_match_data var here, NOT checking equality
      if regex_match_data = /\A(.*?)_conditions\z/.match(meth) # match returns nil on failure
        hash = {}
        hash[regex_match_data[1]] = self.instance_variable_get(("@"+regex_match_data[1])) 
        self.class::BASE.send(:where, hash) # self.class::BASE = BASE for the subclass
      else
        super
      end
    end
  end
end