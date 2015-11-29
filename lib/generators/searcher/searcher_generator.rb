# Generates searchers with concrete functionality, when passed model names
# i.e. rails g searcher User will create a UserSearcher
class SearcherGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :models, type: :array, required: true
  class_option :views, type: :boolean, default: true, desc: "Generate views"

  def create_searcher_model
    dir_name = File.join("app", "searchers")
    # unless Dir.exists? guards against deleting entire directory on `rails destroy`
    empty_directory dir_name unless Dir.exists?(dir_name)
    model_names.each do |name|
      # must use ivar to share state with Template file ERB
      @model = name
      template "searcher_template.rb", File.join("app","searchers", "#{@model}_searcher.rb")
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
    models
      .select{|model_name| is_app_class?(model_name)}
      .map(&:underscore)
  end

  # Filter out anything from the command line which is not a class in the app
  def is_app_class?(model_name)
    model_name.constantize
  rescue NameError
    say set_color("     warning", :yellow, true) + "  #{model_name} is an unknown class"
    false
  end
end
