require "yaml"
require "fileutils"
require File.expand_path("../name_utility", __FILE__)
require File.expand_path("../generator_base", __FILE__)

class GeneratorBase

  def initialize(dir)
    @cfg = YAML.load_file(File.expand_path("config.yml", dir))
    @data_dir = dir

    setup_variables
  end

  def setup_variables
    @package = @cfg["package"]
    @views = @cfg["views"]

    @triggers = []
    @commands = []
    @events = {}
    @cfg["views"].each do |v|
      name = v["name"]
      @events[name] = []
      trans = v["transitions"]
      if trans
        trans.each do |t|
          @triggers << t["trigger"]
          @events[name] << [t["trigger"], true]
        end
      end

      cmds = v["commands"]
      if cmds
        cmds.each do |c|
          @commands << c["name"]
          @events[name] << [c["name"], false]
        end
      end
    end
  end

  def save_file(file)
    path = file["path"]
    content = file["content"]
    FileUtils.mkdir_p(File.dirname(path))

    out = File.open(path, "w")
    out.write(content)
    out.close
  end
end
