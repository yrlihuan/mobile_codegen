#! /usr/bin/env ruby
require "yaml"
require "erb"
require File.expand_path("../name_utility", __FILE__)
require File.expand_path("../generator_base", __FILE__)

class IOSGenerator < GeneratorBase
  def generate_all
    files = []
    files += generate_root_folder
    files += generate_view_controllers

    files.each do |f|
      save_file(f)
    end

    copy_files
  end

  def setup_variables
    super

    @company = @cfg["company"]
    @prefix = @cfg["clsprefix"]
    @appdelegate = @prefix + "AppDelegate"
    @basecontroller = @prefix + "ViewController"
  end

  def generate_root_folder
    result = []

    files = [["main.m", File.expand_path("main.m", output_dir)],
             ["AppDelegate.h", File.expand_path(@prefix + "AppDelegate.h", output_dir)],
             ["AppDelegate.m", File.expand_path(@prefix + "AppDelegate.m", output_dir)],
             ["ViewController.h", File.expand_path(@prefix + "ViewController.h", output_dir)],
             ["ViewController.m", File.expand_path(@prefix + "ViewController.m", output_dir)],
            ]
    files.each do |f, path|
      template_file = f + ".erb"
      class_name = @prefix + f[0...f.index(".")]
      template = File.open(File.join(template_dir, template_file)).read

      erb = ERB.new(template, nil, "%")
      content = erb.result(binding)

      result << {"content" => content, "path" => path}
    end

    result
  end

  def generate_view_controllers
    result = []

    @views.each do |v|
      name = v["name"]
      class_name = NameUtility.toPascalCase(name) + "ViewController"

      triggers = v["transitions"] && v["transitions"].map {|t| t["trigger"]} || []
      commands = v["commands"] && v["commands"].map {|c| c["name"]} || []

      template_file = "SubViewController.h.erb"
      path = File.expand_path(class_name + ".h", controller_dir)
      template = File.open(File.join(template_dir, template_file)).read
      erb = ERB.new(template, nil, "%")
      content = erb.result(binding)
      result << {"content" => content, "path" => path}

      template_file = "SubViewController.m.erb"
      path = File.expand_path(class_name + ".m", controller_dir)
      template = File.open(File.join(template_dir, template_file)).read
      erb = ERB.new(template, nil, "%")
      content = erb.result(binding)
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
    FileUtils.mkdir_p(resource_dir)
    Dir.glob(File.join(@data_dir, "*.png")).each do |f|
      FileUtils.cp(f, resource_dir)
    end
  end

  def template_dir
    File.expand_path("../templates/ios/", File.dirname(__FILE__))
  end

  def output_dir
    File.expand_path("../output_ios", File.dirname(__FILE__))
  end

  def controller_dir
    File.expand_path("controllers", output_dir)
  end

  def view_dir
    File.expand_path("views",  output_dir)
  end

  def resource_dir
    File.expand_path("resources", output_dir)
  end
end

if $PROGRAM_NAME == __FILE__
  config_path = ARGV[0]

  unless File.exists? config_path
    puts "input path not found"
    exit 1
  end

  generator = IOSGenerator.new(config_path)

  generator.generate_all
end
