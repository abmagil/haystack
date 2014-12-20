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
        respond_to?(:"#{attribute}=") && send(:"#{attribute}=", value)
      end
    end   


    #############################################################################
    # Querying methods
    #############################################################################

    # The heart of the engine
    def perform_query
      # Reduce as in map-reduce- merges down array of queries into a single one
      condition_parts.reduce(:merge)
    end

    # Finds each method named *_conditions and runs it in the concrete class
    # Returns an array of ActiveRecord::Relation objects
    def condition_parts
      ### Subclass MUST respond with at least 1 non-nil AR::Relation object  ###
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
    end
  end
end