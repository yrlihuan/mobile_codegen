require "yaml"
require "name_utility"
require "gen_java"

class GenCommandType < GenJava
  FILE_LISTS = ["ActivityCommandType.java"]

  def get_files
    ret = []
    FILE_LISTS.each do |f|
      path = get_src_path + "/" + f

      commands = ""
      @cfg["views"].each do |v|
        trans = v["transitions"]
        next unless trans

        trans.each do |t|
          commands += "\t#{NameUtility.toPascalCase(t["trigger"])},\n"
        end
      end

      commands = commands[0...-2]

      template = File.open("templates/#{f}").read()
      content = ""
      eval("content = %Q^#{template}^")

      ret << {"path" => path, "content" => content}
    end

    ret
  end
end

if $PROGRAM_NAME == __FILE__
  gen = GenCommandType.new("demo/config.yml")
  files = gen.get_files
  files.each do |d|
    puts d["path"]
    puts d["content"]
    puts "=" * 80
  end
end
