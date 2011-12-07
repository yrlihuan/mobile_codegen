class NameUtility
  def self.toCamelCase(str)
    s = self.toPascalCase(str)
    s[0].downcase + s[1..-1]
  end

  def self.toPascalCase(str)
    str.split.map {|x| x.capitalize }.join
  end

  def self.toSnakeCase(str)
    str.gsub(" ", "_")
  end
end
