# Generates searchers with concrete functionality, when passed model names
# i.e. rails g searcher User will create a UserSearcher
class SearcherGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  class_option :views, type: :boolean, default: true, description: "Include views"

  def create_searcher_model
    empty_directory File.join("app", "searchers")
    model_names.each do |name|
      template "searcher_template.rb", File.join("app","searchers", "#{name}_searcher.rb")
    end
  end

  def create_searcher_view
    if options.views?
      model_names.each do |name|
        empty_directory File.join("app", "views", "searchers", "#{name}")
        copy_file "new.html.erb", "app/views/searchers/#{name}/new.html.erb"
      end
    end
  end


  private
  def model_names
    ARGV.map(&:underscore)
  end
end
