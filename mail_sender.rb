require 'mail'

target = "TWSummer@gmail.com"

Mail.defaults do
  delivery_method :smtp, address: "localhost", port: 1025
end

mail = Mail.new do
  from    'donotreply@creativeMarket.com'
  to      target
  subject 'This is a test email'
  body    "Thank you for your purchase. \n\nYour license key is: 4AE2F98CCD0B8"
end

File.open("messages.txt", 'w') { |file| file.write(mail.to_s) }

# mail.deliver


# Mail.deliver do
#   from     'donotreply@localhost'
#   to       'TWSummer@gmail.com'
#   subject  'This is a test email'
#   body     "Thank you for your purchase. \n\nYour license key is : 4AE2F98CCD0B8"
# end
