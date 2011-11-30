require "yaml"
require "name_utility"
require "gen_java"

class GenTrivials < GenJava
  FILE_LISTS = ["SimpleOnClickHandler.java", "ManagedActivity.java"]

  def get_files
    ret = []
    FILE_LISTS.each do |f|
      path = get_src_path + "/" + f

      template = File.open("templates/#{f}").read()
      content = ""
      eval("content = %Q^#{template}^")

      ret << {"path" => path, "content" => content}
    end

    ret
  end
end

if $PROGRAM_NAME == __FILE__
  gen = GenTrivials.new("demo/config.yml")
  files = gen.get_files
  files.each do |d|
    puts d["path"]
    puts d["content"]
    puts "=" * 80
  end
end
