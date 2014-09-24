module StyleGuide
  class JavaScript < Base
    DEFAULT_CONFIG_FILE = File.join(CONFIG_DIR, "javascript.json")

    def violations_in_file(file)
      Jshintrb.lint(file.content, :defaults).map do |violation|
        Violation.new(file, violation["line"], violation["reason"])
      end
    end
  end
end
