#!/usr/bin/env ruby

require "fileutils"
require "gen_layouts"
require "gen_activities"
require "gen_flow_manager"
require "gen_command_type"
require "gen_manifest"
require "gen_trivials"

def generate_all(dir)
  classes = [GenLayouts, GenActivities, GenFlowManager, GenCommandType, GenManifest, GenTrivials]

  classes.each do |c|
    gen = c.new(File.join(dir, "config.yml"))

    gen.get_files.each do |h|
      path = h["path"]
      content = h["content"]
      path = File.join("out", path)
      FileUtils.mkdir_p(File.dirname(path))

      out = File.open(path, "w")
      out.write(content)
      out.close
    end
  end

  drawable_out_dir = "out/res/drawable-hdpi/"
  FileUtils.mkdir_p(drawable_out_dir)
  Dir.glob(File.join(dir, "*.png")).each do |f|
    FileUtils.cp(f, drawable_out_dir)
  end
end

if $PROGRAM_NAME == __FILE__
  unless ARGV[0] && File.exists?(ARGV[0])
    puts "usage: gen_prject.rb <dir containing config.yml>"
    exit 1
  end

  generate_all(ARGV[0])
end
