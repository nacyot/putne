require 'spec_helper'

describe "routes for Project" do
  it { { get: "projects/1/reports/125/files"}.should route_to("metrics#files", project_id: "1", report_id: "125") }
  it { { get: "projects/1/reports/125/file"}.should route_to("metrics#file", project_id: "1", report_id: "125") }
  it { { get: "projects/1/reports/125/classes"}.should route_to("metrics#classes", project_id: "1", report_id: "125") }
  it { { get: "projects/1/reports/125/klass"}.should route_to("metrics#klass", project_id: "1", report_id: "125") }
  it { { get: "projects/1/reports/125/methods"}.should route_to("metrics#methods", project_id: "1", report_id: "125") }
  it { { get: "projects/1/reports/125/method"}.should route_to("metrics#method", project_id: "1", report_id: "125") }
  it { { get: "projects/1/reports/125/churn"}.should route_to("metrics#churn", project_id: "1", report_id: "125") }
  it { { get: "projects/1/reports/125/complexity"}.should route_to("metrics#complexity", project_id: "1", report_id: "125") }
    
end
