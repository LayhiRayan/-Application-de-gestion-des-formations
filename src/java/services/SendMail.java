package services;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMail {

    private static final String EMAIL_SENDER = "skillforge212@gmail.com"; // ton adresse Gmail
    private static final String PASSWORD_SENDER = "ixeu rkyt gvfg tvqc"; // mot de passe d'application

    public static void envoyerCode(String destinataire, String code) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_SENDER, PASSWORD_SENDER);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_SENDER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinataire));
            message.setSubject("🔐 Code de vérification - Réinitialisation");

            // ✅ Contenu HTML
           String htmlContent = "<!DOCTYPE html>"
    + "<html>"
    + "<head>"
    + "<meta charset='UTF-8'>"
    + "<style>"
    + "  body { font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #444; margin: 0; padding: 0; background-color: #f5f7fa; }"
    + "  .container { max-width: 600px; margin: 20px auto; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }"
    + "  .header { background: linear-gradient(135deg, #6c5ce7, #fd79a8); padding: 30px 20px; text-align: center; }"
    + "  .brand { display: flex; align-items: center; justify-content: center; margin-bottom: 15px; }"
    + "  .icon { font-size: 32px; margin-right: 15px; color: white; }"
    + "  .brand-name { color: white; font-size: 28px; font-weight: 700; }"
    + "  h1 { color: white; margin: 0; font-size: 24px; }"
    + "  .content { padding: 30px; }"
    + "  .code-container { background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 25px 0; text-align: center; }"
    + "  .verification-code { font-size: 32px; letter-spacing: 3px; color: #6c5ce7; font-weight: bold; }"
    + "  .footer { text-align: center; padding: 20px; font-size: 12px; color: #888; background: #f5f7fa; }"
    + "  .note { background: #fff8e1; padding: 15px; border-left: 4px solid #ffc107; margin: 20px 0; }"
    + "</style>"
    + "</head>"
    + "<body>"
    + "<div class='container'>"
    + "  <div class='header'>"
    + "    <div class='brand'>"
    + "      <div class='icon'>🤫</div>"
    + "      <div class='brand-name'>SkillForge</div>"
    + "    </div>"
    + "    <h1>Réinitialisation de votre mot de passe</h1>"
    + "  </div>"
    + "  <div class='content'>"
    + "    <p>Bonjour,</p>"
    + "    <p>Vous avez demandé à réinitialiser votre mot de passe sur SkillForge. Voici votre code de vérification :</p>"
    + "    "
    + "    <div class='code-container'>"
    + "      <div class='verification-code'>" + code + "</div>"
    + "      <p style='margin-top:10px;color:#666;'>Ce code est valable pendant 5 minutes</p>"
    + "    </div>"
    + "    "
    + "    <div class='note'>"
    + "      <p>💡 <strong>Conseil de sécurité :</strong> Ne partagez jamais ce code avec qui que ce soit.</p>"
    + "    </div>"
    + "    "
    + "    <p>Si vous n'avez pas demandé cette réinitialisation, veuillez ignorer cet email.</p>"
    + "    "
    + "    <p>Cordialement,<br>L'équipe SkillForge</p>"
    + "  </div>"
    + "  <div class='footer'>"
    + "    <p>© 2023 SkillForge. Tous droits réservés.</p>"
    + "    <p>Si vous rencontrez des problèmes, contactez-nous à <a href='mailto:support@skillforge.com' style='color:#6c5ce7;'>support@skillforge.com</a></p>"
    + "  </div>"
    + "</div>"
    + "</body>"
    + "</html>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✅ Mail envoyé à : " + destinataire);

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ Erreur d’envoi de mail");
        }
    }
}
