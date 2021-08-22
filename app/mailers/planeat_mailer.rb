class PlaneatMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default from: 'PlanEat Team <no-reply@planeat.xyz>'
  default reply_to: 'PlanEat Team <joaquinsepulveda@hotmail.com>'

  layout 'mailer_planeat'

  #############################
  # CONFIRMATION EMAIL
  # overrides Devise's confirmation_instructions method
  #############################
  def confirmation_instructions(record, token, opts={})
    @individual = record
    @token = token
    @to_email = @individual.email

    template = render_to_string(template: "mailers/planeat/confirmation_instructions")
    premailer = Premailer.new(template, :with_html_string => true, :warn_level => Premailer::Warnings::SAFE)

    mg_client = Mailgun::Client.new
    mb_obj    = Mailgun::MessageBuilder.new

    mb_obj.from("PlanEat Team <no-reply@planeat.xyz>")
    mb_obj.add_recipient(:to, @to_email, {'first' => "#{@individual.first_name}", 'last' => "#{@individual.last_name}"})
    mb_obj.subject("PlanEat - email confirmation instructions")
    # mb_obj.body_text("Plaint text email goes here")
    mb_obj.body_html((premailer.to_inline_css).to_str)

    # mg_client.send_message(Rails.application.credentials.dig(Rails.env.to_sym, :mailgun, :domain), mb_obj)
    mg_client.send_message("sandbox44416e498e7447068ce8bace5b16caae.mailgun.org", mb_obj)
  end
end