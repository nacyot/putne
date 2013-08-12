require 'spec_helper'

describe "projects/index" do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :title => "Title",
        :description => "MyText",
        :language => "Language",
        :repository_type => "Repository Type",
        :repository_url => "Repository Url"
      ),
      stub_model(Project,
        :title => "Title",
        :description => "MyText",
        :language => "Language",
        :repository_type => "Repository Type",
        :repository_url => "Repository Url"
      )
    ])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Repository Type".to_s, :count => 2
    assert_select "tr>td", :text => "Repository Url".to_s, :count => 2
  end
end
