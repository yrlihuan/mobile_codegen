require "yaml"
require "name_utility"

class GenManifest
  ACTIVITY_TEMPLATE = %q[    <activity android:name=".#{activity_name}" android:screenOrientation="portrait">#{initial_activity}</activity>\n]
  INITIAL_ACTIVITY_TEMPLATE = <<-EOF

      <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
      </intent-filter>
    EOF

  def initialize(file)
    @cfg = YAML.load_file(file)
    @file_template = File.open("templates/AndroidManifest.xml").read()
  end

  def get_files
    manifest_package = @cfg["package"]
    manifest_activities = ""
    @cfg["views"].each do |v|
      activity_name = NameUtility.toPascalCase(v["name"]) + "Activity"
      initial_activity = v["initial"] && INITIAL_ACTIVITY_TEMPLATE + " " * 4 || ""

      eval(%Q[manifest_activities += %Q(#{ACTIVITY_TEMPLATE})])
    end

    manifest = ""
    eval(%Q[manifest = %Q(#{@file_template})])

    [{"path" => "AndroidManifest.xml", "content" => manifest }]
  end
end

if $PROGRAM_NAME == __FILE__
  gen = GenManifest.new("demo/config.yml")
  puts gen.get_files[0]["content"]
end
