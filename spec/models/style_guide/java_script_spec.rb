require "fast_spec_helper"
require "jshintrb"
require "active_support/inflector"
require "app/models/violation"
require "app/models/style_guide/base"
require "app/models/style_guide/java_script"

describe StyleGuide::JavaScript do
  describe "#violations_in_file" do
    context "with default config" do
      context "when semicolon is missing" do
        it "returns violation" do
          style_guide = StyleGuide::JavaScript.new(double("RepoConfig", for: {}))
          file = double(:file, content: "var blahh = 'blahh'")
          violation = double("Violation")
          Violation.stub(new: violation)

          violations = style_guide.violations_in_file(file)

          expect(Violation).to have_received(:new).with(file, 1, "Missing semicolon.")
          expect(violations.first).to eq violation
        end
      end
    end

    context "when curly brace rule is disabled using custom config" do
      context "with missing curly braces" do
        it "returns no violation" do
          custom_config = double("RepoConfig", for: { "curly" => false })
          style_guide = StyleGuide::JavaScript.new(custom_config)
          file = double(:file, content: "while(true) var test = 'test';")

          violations = style_guide.violations_in_file(file)

          expect(violations).to be_empty
        end
      end
    end
  end
end
