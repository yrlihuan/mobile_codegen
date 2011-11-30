require "yaml"
require "name_utility"
require "gen_java"

class GenFlowManager < GenJava
  FILE_LISTS = ["ActivityFlowManager.java"]

  TRANSITION_TABLE_ROW_TEMPLATE = <<-EOF
		table.put(ActivityCommandType.\#{action_type}, \#{target_activity}.class);
  EOF

  ACTIVITY_TRANSITIONS_TEMPLATE = <<-EOF
		// \#{activity}
		table = new HashMap<ActivityCommandType, Class<?>>();
		\#{table_entities}
		mTransitionTables.put(\#{activity}.class, table);
  EOF

  def get_files
    ret = []
    FILE_LISTS.each do |f|
      path = get_src_path + "/" + f

      transition_table = ""
      @cfg["views"].each do |view|
        activity = NameUtility.toPascalCase(view["name"]) + "Activity"
        table_entities = ""
        trans = view["transitions"]
        next unless trans

        trans.each do |t|
          trigger = t["trigger"]
          target = t["target"]

          action_type = NameUtility.toPascalCase(trigger)
          target_activity = NameUtility.toPascalCase(target) + "Activity"

          eval("table_entities += %Q^#{TRANSITION_TABLE_ROW_TEMPLATE}^")
        end

        eval("transition_table += %Q^#{ACTIVITY_TRANSITIONS_TEMPLATE}\n^")
      end

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
