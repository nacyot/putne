require 'spec_helper'

describe "routes for User" do
  it { { get: "/users/1/secret_key"}.should route_to("secret_key#index", user_id: "1") }
  it { { get: "/users/13/secret_key"}.should route_to("secret_key#index", user_id: "13") }
  it { { post: "/users/1/secret_key/reset"}.should route_to("secret_key#reset", user_id: "1") }
end
