class ApplicationMailer < ActionMailer::Base
  def send_simple_message
    RestClient.post "https://api:#{ENV[MAILGUN_API_KEY]}"\
    "@api.mailgun.net/v3/sandbox44416e498e7447068ce8bace5b16caae.mailgun.org/messages",
    :from => "Excited User <joaquinsepulveda@hotmail.com>",
    :to => "joaquinsepulveda@hotmail.com",
    :subject => "Hello",
    :text => "Testing some Mailgun awesomness!"
  end
end
