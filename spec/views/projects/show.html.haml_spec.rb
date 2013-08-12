require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :title => "Title",
      :description => "MyText",
      :language => "Language",
      :repository_type => "Repository Type",
      :repository_url => "Repository Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Language/)
    rendered.should match(/Repository Type/)
    rendered.should match(/Repository Url/)
  end
end
