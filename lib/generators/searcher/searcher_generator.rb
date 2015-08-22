# Generates searchers with concrete functionality, when passed model names
# i.e. rails g searcher User will create a UserSearcher
class SearcherGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_searcher_model
    
    dir_name = File.join("app", "searchers")
    # unless Dir.exists? guards against deleting entire directory on `rails destroy`
    empty_directory dir_name unless Dir.exists?(dir_name)
    model_names.each do |name|
      template "searcher_template.rb", File.join("app","searchers", "#{name}_searcher.rb")
    end
  end
  

  private
  def model_names
    ARGV.map(&:underscore)
  end
end
