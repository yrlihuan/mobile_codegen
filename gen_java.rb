require "yaml"
require "name_utility"

class GenJava
  def initialize(file)
    @cfg = YAML.load_file(file)
  end

  def package
    @cfg["package"]
  end

  def get_src_path()
    "src/" + package.gsub(".", "/")
  end
end
