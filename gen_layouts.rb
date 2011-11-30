require "yaml"
require "name_utility"
require "gen_java"

class GenLayouts
  MAIN_TEMPLATE = <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent"
    android:orientation="vertical"
    android:background="@drawable/\#{background}">
    <LinearLayout android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="vertical">

\#{text_views}

    </LinearLayout>
</ScrollView>
  EOF

  TEXT_TEMPLATE = <<-EOF
        <Button android:id="@+id/\#{event_id}"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textColor="\#{color}"
            android:textSize="14sp"
            android:layout_margin="10dip"
            android:text="\#{event}" />
  EOF

  def initialize(file)
    @cfg = YAML.load_file(file)
  end

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

      background = layout
      text_views = ""
      events.each do |event_name, trigger_transition|
        event = NameUtility.toPascalCase(event_name)
        event_id = NameUtility.toSnakeCase(event_name)
        color = trigger_transition && "#0000ff" || "#ff0000"
        eval("text_views += %Q^#{TEXT_TEMPLATE}^")
      end

      path = "res/layout/" + layout + ".xml"
      content = ""
      eval("content = %Q^#{MAIN_TEMPLATE}^")

      ret << {"path" => path, "content" => content}
    end

    ret
  end

end

if $PROGRAM_NAME == __FILE__
  gen = GenLayouts.new("demo/config.yml")
  files = gen.get_files
  files.each do |d|
    puts d["path"]
    puts d["content"]
    puts "=" * 80
  end
end

