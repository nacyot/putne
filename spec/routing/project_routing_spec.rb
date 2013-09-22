require 'spec_helper'

describe "routes for Project" do
  it { { get: "/projects/1/settings"}.should route_to("projects#settings", project_id: "1") }
  it { { post: "/projects/1/api/hook"}.should route_to("commit_hook#hook", project_id: "1") }
  it { { get: "/projects/1/api/hook_url"}.should route_to("commit_hook#hook_url", project_id: "1") }
  it { { get: "projects/1/commits"}.should route_to("git#commits", project_id: "1", report_id: "125") }
  it { { get: "projects/1/committers"}.should route_to("git#committers", project_id: "1", report_id: "125") }
end
 
