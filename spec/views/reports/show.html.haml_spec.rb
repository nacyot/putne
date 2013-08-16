require 'spec_helper'

describe "reports/show" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :repository_id => "Repository",
      :branch_id => "Branch",
      :commit_id => "Commit",
      :project_id => "Project"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Repository/)
    rendered.should match(/Branch/)
    rendered.should match(/Commit/)
    rendered.should match(/Project/)
  end
end
