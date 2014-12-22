  #
  # Abstract class holding all common search functionality
  #
module Haystack
  class BaseSearcher

    #performs ActiveRecord-like mass assignment of attributes             
    def initialize(attributes = {})
      mass_assign(attributes)
    end    
    
    # Caches the rows
    def data
      @data ||= perform_query
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
    def perform_query
      # Reduce as in map-reduce- ANDs together multiple SQL queries
      # while still lazy-loading them
      condition_part_array.reduce(:merge)
    end

    # For each param passed from the front-end, fire a "*_conditions" method
    def condition_part_array
      ar_relation_array = []
      self.instance_variables.each do |ivar| # e.g. :@name, :@phone
        new_method_name = "#{ivar.to_s.sub('@','')}_conditions"
        ar_relation_array << self.send(new_method_name)
      end
      ar_relation_array
    end

    # method_missing will, when passed "_conditions" methods, create an equality-
    # based AR:Relation
    def method_missing(meth, *args, &block)
      # NOTE: We are intentionally setting regex_match_data var here, NOT ==
      if regex_match_data = /(.*?)_conditions/.match(meth) # match returns nil
        hash = {}
        hash[regex_match_data[1]] = self.instance_variable_get(("@"+regex_match_data[1]))
        self.class::BASE.send(:where, hash) # self.class::BASE = BASE for the subclass
      else
        super
      end
    end
  end
end