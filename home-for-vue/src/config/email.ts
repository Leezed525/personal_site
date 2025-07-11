import emailjs from "@emailjs/browser";

interface EmailConfig {
  serviceId: string;
  templateId: string;
  publicKey: string;
}

export const emailConfig: EmailConfig = {
  serviceId: import.meta.env.VITE_EMAILJS_SERVICE_ID,
  templateId: import.meta.env.VITE_EMAILJS_TEMPLATE_ID,
  publicKey: import.meta.env.VITE_EMAILJS_PUBLIC_KEY,
};

export const initEmailJS = () => {
  emailjs.init(emailConfig.publicKey);
};

if (
  !emailConfig.serviceId ||
  !emailConfig.templateId ||
  !emailConfig.publicKey
) {
  throw new Error("Missing required EmailJS configuration");
}
