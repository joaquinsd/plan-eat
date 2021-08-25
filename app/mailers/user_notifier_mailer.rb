class UserNotifierMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid
  def test_mail
    body = '<h4>Hello,</h4><br/><p>Regards</p>'

    from = Email.new(email: 'joaquinsepulveda@hotmail.com')
    to = Email.new(email: 'joaquinsepulvedad@gmail.com')
    subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/html', value: body)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_2nd_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end
