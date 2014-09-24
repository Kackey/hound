require "fast_spec_helper"
require "jshintrb"
require "app/models/violation"
require "app/models/style_guide/base"
require "app/models/style_guide/java_script"

describe StyleGuide::JavaScript do
  describe "#violations_in_file" do
    context "when semicolon is missing" do
      it "returns violation" do
        style_guide = StyleGuide::JavaScript.new(double("RepoConfig"))
        file = double(:file, content: "var blahh = 'blahh'")
        violation = double("Violation")
        Violation.stub(new: violation)

        violations = style_guide.violations_in_file(file)

        expect(Violation).to have_received(:new).with(file, 1, "Missing semicolon.")
        expect(violations.first).to eq violation
      end
    end
  end
end
