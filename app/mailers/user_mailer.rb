class UserMailer < ActionMailer::Base
  default from: "P2PC <mailer@p2p.leanstartupcircle.com>"

  def group_application(group)
    @group = group
    mail to: "tristan@leanstartupcircle.com",
         from: "New Group Application <feedback@leanstartupcircle.com>",
         subject: "[LSC] " + group.name
  end

  def contact(message)
    @message = message
    from = @message.name + "<" + @message.email + ">"
    mail to: "feedback@leanstartupcircle.com",
         from: from,
         subject: "[LSC] Message from" + from
  end

end