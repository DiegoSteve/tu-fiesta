class UserMailer < ApplicationMailer
    default from: 'diegosteve123321@gmail.com'  # Reemplaza con tu dirección de correo electrónico

    def confirmation_instructions(user, token, opts = {})
      @user = user
      @token = token
      mail(to: user.email, subject: 'Confirmación de cuenta')
    end
end
