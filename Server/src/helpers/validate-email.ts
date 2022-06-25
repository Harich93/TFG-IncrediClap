import nodemailer, {SendMailOptions} from "nodemailer";

const transporter = nodemailer.createTransport({
   host: 'smtp.office365.com',
   secure: false,
   port: 587,
   tls: {
      ciphers:'SSLv3'
   },
   auth: {
     user: process.env.NODEMAIL_EMAIL,
     pass: process.env.NODEMAIL_PASS_EMAIL
   }
});

const sendMail = (mailOptions: SendMailOptions) => {
   transporter.sendMail(mailOptions, function(error, info){
      if (error) {
         console.log(error);
      } else {
         console.log('Email sent: ' + info.response);
      }
   });

}

const validateEmail = ( email: string, token: string ) => {
  
   const url = 'https://incredibclap-backend-ts.herokuapp.com/auth/confirmEmail'

   var mailOptions = {
      from: process.env.NODEMAIL_EMAIL,
      to: `${email}`,
      subject: 'Verificación email',
      text: `Verificación email`,
      html: `
         <h1>Verifica tu email</h1>   
         <h3>Click <a href="${url}?x_token=${token}">aquí</a> para activar tu cuenta</h3>
      `,
   };
   
   
   sendMail(mailOptions);

}

const changePassEmail = ( email: string, token: string ) => {
  
   const url = 'https://incredibclap-backend-ts.herokuapp.com/auth/changepass'

   var mailOptions = {
      from: process.env.NODEMAIL_EMAIL,
      to: `${email}`,
      subject: 'Restablecer contraseña',
      text: `Restablecer contraseña`,
      html: `
         <h1>Verifica tu email</h1>   
         <h3>Click <a href="${url}/${token}">aquí</a> para restablecer contraseña</h3>
      `,
   };
   
   
   sendMail(mailOptions);

}


export {
   validateEmail,
   changePassEmail
}