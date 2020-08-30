class FriendNotifierMailer < ApplicationMailer
  def inform(email_info, recipient)
    @sender = email_info[:host]
    @message = email_info[:message]
    @friend = email_info[:friend]
    @party = email_info[:party]

    mail(
      reply_to: @sender.email,
      to: recipient,
      subject: "#{@sender.username} is sending you some advice"
    )
  end
end
