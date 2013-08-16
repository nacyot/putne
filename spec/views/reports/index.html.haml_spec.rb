require 'spec_helper'

describe "reports/index" do
  before(:each) do
    assign(:reports, [
      stub_model(Report,
        :repository_id => "Repository",
        :branch_id => "Branch",
        :commit_id => "Commit",
        :project_id => "Project"
      ),
      stub_model(Report,
        :repository_id => "Repository",
        :branch_id => "Branch",
        :commit_id => "Commit",
        :project_id => "Project"
      )
    ])
  end

  it "renders a list of reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Repository".to_s, :count => 2
    assert_select "tr>td", :text => "Branch".to_s, :count => 2
    assert_select "tr>td", :text => "Commit".to_s, :count => 2
    assert_select "tr>td", :text => "Project".to_s, :count => 2
  end
end
