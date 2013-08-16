require 'spec_helper'

describe "reports/new" do
  before(:each) do
    assign(:report, stub_model(Report,
      :repository_id => "MyString",
      :branch_id => "MyString",
      :commit_id => "MyString",
      :project_id => "MyString"
    ).as_new_record)
  end

  it "renders new report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reports_path, "post" do
      assert_select "input#report_repository_id[name=?]", "report[repository_id]"
      assert_select "input#report_branch_id[name=?]", "report[branch_id]"
      assert_select "input#report_commit_id[name=?]", "report[commit_id]"
      assert_select "input#report_project_id[name=?]", "report[project_id]"
    end
  end
end
