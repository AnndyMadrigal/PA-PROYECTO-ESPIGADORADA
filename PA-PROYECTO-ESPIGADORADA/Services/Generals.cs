using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;

namespace PA_PROYECTO_ESPIGADORADA.Services
{
    public class Generals
    {
        public void SendEmail(string recipient, string subject, string body)
        {
            // Asegúrate de cambiar también estas llaves en tu Web.config o App.config
            var emailAccount = ConfigurationManager.AppSettings["EmailAccount"];
            var emailPassword = ConfigurationManager.AppSettings["EmailPassword"];

            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress(emailAccount);
                mail.To.Add(recipient);
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = true;

                using (SmtpClient smtp = new SmtpClient("smtp.office365.com", 587))
                {
                    smtp.Credentials = new NetworkCredential(emailAccount, emailPassword);
                    smtp.EnableSsl = true;
                    smtp.Send(mail);
                }
            }
        }

        public string GeneratePassword()
        {
            int length = 8;
            const string letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            StringBuilder result = new StringBuilder(length);

            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                byte[] bytes = new byte[1];
                for (int i = 0; i < length; i++)
                {
                    rng.GetBytes(bytes);
                    int index = bytes[0] % letters.Length;
                    result.Append(letters[index]);
                }
            }
            return result.ToString();
        }
    }
}