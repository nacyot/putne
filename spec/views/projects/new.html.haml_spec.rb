require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project,
      :title => "MyString",
      :description => "MyText",
      :language => "MyString",
      :repository_type => "MyString",
      :repository_url => "MyString"
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", projects_path, "post" do
      assert_select "input#project_title[name=?]", "project[title]"
      assert_select "textarea#project_description[name=?]", "project[description]"
      assert_select "input#project_language[name=?]", "project[language]"
      assert_select "input#project_repository_type[name=?]", "project[repository_type]"
      assert_select "input#project_repository_url[name=?]", "project[repository_url]"
    end
  end
end