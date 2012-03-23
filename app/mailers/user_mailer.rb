class UserMailer < ActionMailer::Base
  default from: "huntingtargeting@gmail.com"

def shot_boar(user, mail_body)
    mail(:to =>user.email, :subject => "Boar is shot") do |format|
    format.text {render :text => mail_body}
    #mail.deliver
    end
  end
end
