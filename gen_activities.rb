require "yaml"
require "name_utility"
require "gen_java"

class GenActivities < GenJava
  HANDLER_TEMPLATE = <<-EOF
	private SimpleOnClickHandler handle\#{event} = new SimpleOnClickHandler() {
		@Override
		public void run() {
\#{transition_trigger}		}
	};\n
  EOF

  TRANS_TRIGGER_TEMPLATE = "\t\t\t\#{activity}.this.handleCommand(ActivityCommandType.\#{event}, null);\n"

  EVENT_REGISTER_TEMPLATE = "\t\tfindViewById(R.id.\#{event_id}).setOnClickListener(handle\#{event});\n"

  def get_files
    ret = []

    @cfg["views"].each do |v|
      view_name = v["name"]
      activity = NameUtility.toPascalCase(view_name) + "Activity"
      layout = NameUtility.toSnakeCase(view_name)

      events = []
      trans = v["transitions"]
      if trans
        trans.each do |t|
          events << [t["trigger"], true]
        end
      end

      commands = v["commands"]
      if commands
        commands.each do |c|
          events << [c["name"], false]
        end
      end

      handler_definitions = ""
      register_events = ""
      events.each do |event_name, trigger_transition|
        event = NameUtility.toPascalCase(event_name)
        event_id = NameUtility.toSnakeCase(event_name)
        eval("register_events += %Q^#{EVENT_REGISTER_TEMPLATE}^")

        transition_trigger = ""
        eval("transition_trigger = %Q^#{TRANS_TRIGGER_TEMPLATE}^") if trigger_transition

        eval("handler_definitions += %Q^#{HANDLER_TEMPLATE}^")
      end

      path = get_src_path + "/" + activity + ".java"
      template = File.open("templates/Activity.java").read()
      content = ""
      eval("content = %Q^#{template}^")

      ret << {"path" => path, "content" => content}
    end

    ret
  end
end

if $PROGRAM_NAME == __FILE__
  gen = GenActivities.new("demo/config.yml")
  files = gen.get_files
  files.each do |d|
    puts d["path"]
    puts d["content"]
    puts "=" * 80
  end
end
