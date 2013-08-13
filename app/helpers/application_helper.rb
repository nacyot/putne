module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def login_form_for_header
    simple_form_for resource, :as => resource_name, :url => session_path(resource_name), html: { class: "navbar-form pull-right"} do |f|
      email_input(f) + " " + password_input(f) + " " + signin_submit(f)
    end
  end

  def email_input(form)
    form.input(:email,
               wrapper: false,
               label: false,
               input_html: {
                 class: "form-control",
                 style: "width: 200px;",
                 placeholder: "ID",
                 value: "admin@example.com"})
  end

  def password_input(form)
    form.input(:password,
               wrapper: false,
               label: false,
               input_html: {
                 class: "form-control",
                 style: "width: 200px;",
                 placeholder: "Password",
                 value: "abcd1234"})
  end

  def signin_submit(form)
    form.submit("Sign in",
                class: "btn btn-default navbar-btn",
                style: "margin-top: -3px;")
  end

  def gravatar_image_for_navbar
    gravatar_image_tag(current_user.email,
                       alt: "gravatar image",
                       class: "img-rounded gravatar",
                       gravatar: { size: 25 })
                       
  end

  def gravatar_image_for_profile
        gravatar_image_tag(current_user.email,
                       alt: "gravatar image",
                       class: "img-circle gravatar",
                       gravatar: { size: 120 })
  end
end
