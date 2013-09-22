require 'spec_helper'

describe "routes for Main" do
  it { { get: "/"}.should route_to("main#index") }
  it { { get: "/help"}.should route_to("main#help") }
end
 
