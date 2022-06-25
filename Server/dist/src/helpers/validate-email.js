"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.changePassEmail = exports.validateEmail = void 0;
const nodemailer_1 = __importDefault(require("nodemailer"));
const transporter = nodemailer_1.default.createTransport({
    host: 'smtp.office365.com',
    secure: false,
    port: 587,
    tls: {
        ciphers: 'SSLv3'
    },
    auth: {
        user: process.env.NODEMAIL_EMAIL,
        pass: process.env.NODEMAIL_PASS_EMAIL
    }
});
const sendMail = (mailOptions) => {
    transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
            console.log(error);
        }
        else {
            console.log('Email sent: ' + info.response);
        }
    });
};
const validateEmail = (email, token) => {
    const url = 'https://incredibclap-backend-ts.herokuapp.com/auth/confirmEmail';
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
};
exports.validateEmail = validateEmail;
const changePassEmail = (email, token) => {
    const url = 'https://incredibclap-backend-ts.herokuapp.com/auth/changepass';
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
};
exports.changePassEmail = changePassEmail;
//# sourceMappingURL=validate-email.js.map