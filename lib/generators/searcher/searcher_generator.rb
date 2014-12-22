class SearcherGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_searcher_model
    
    empty_directory File.join("app", "searchers")
    model_names.each do |name|
      template "searcher_template.rb", File.join("app","searchers", "#{name}_searcher.rb")
    end
  end
  

  private
  def model_names
    ARGV.map(&:underscore)
  end
end
