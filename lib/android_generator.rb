#! /usr/bin/env ruby
require "yaml"
require "erb"
require File.expand_path("../name_utility", __FILE__)
require File.expand_path("../generator_base", __FILE__)

class AndroidGenerator < GeneratorBase
  def generate_all
    files = []
    files += generate_trivials
    files += generate_activities
    files += generate_layouts

    files.each do |f|
      save_file(f)
    end

    copy_files
  end

  def generate_trivials
    result = []
    files = ["ActivityCommandType.java", "AndroidManifest.xml", "ActivityFlowManager.java", "ManagedActivity.java", "SimpleOnClickHandler.java"]
    files.each do |f|
      template_file = f[0...f.index(".")] + ".erb"
      template = File.open(File.join(template_dir, template_file)).read

      erb = ERB.new(template, nil, "%")
      content = erb.result(binding)

      if f.end_with? "java"
        path = File.expand_path(f, src_dir)
      else
        path = File.expand_path(f, output_dir)
      end

      result << {"content" => content, "path" => path}
    end

    result
  end

  def generate_layouts
    template = File.open(File.join(template_dir, "layout.erb")).read
    result = []

    @views.each do |v|
      name = v["name"]
      activity = NameUtility.toPascalCase(name) + "Activity";
      layout = NameUtility.toSnakeCase(name)

      events = @events[name]

      erb = ERB.new(template, nil, "%")
      content = erb.result(binding)
      path = File.expand_path(layout + ".xml", layout_dir)
      result << {"content" => content, "path" => path}
    end

    result
  end

  def generate_activities
    template = File.open(File.join(template_dir, "Activity.erb")).read
    result = []

    @views.each do |v|
      name = v["name"]
      activity = NameUtility.toPascalCase(name) + "Activity";
      layout = NameUtility.toSnakeCase(name)

      events = @events[name]

      erb = ERB.new(template, nil, "%")
      content = erb.result(binding)
      path = File.expand_path(activity + ".java", src_dir)
      result << {"content" => content, "path" => path}
    end

    result
  end

  def copy_files
    FileUtils.mkdir_p(drawable_dir)
    Dir.glob(File.join(@data_dir, "*.png")).each do |f|
      FileUtils.cp(f, drawable_dir)
    end
  end

  def template_dir
    File.expand_path("../templates/android/", File.dirname(__FILE__))
  end

  def output_dir
    File.expand_path("../output_android", File.dirname(__FILE__))
  end

  def src_dir
    File.expand_path("src/" + @package.gsub(".", "/"), output_dir)
  end

  def layout_dir
    File.expand_path("res/layout/",  output_dir)
  end

  def drawable_dir
    File.expand_path("res/drawable-hdpi/", output_dir)
  end
end

if $PROGRAM_NAME == __FILE__
  config_path = ARGV[0]

  unless File.exists? config_path
    puts "input path not found"
    exit 1
  end

  generator = AndroidGenerator.new(config_path)

  generator.generate_all
end
