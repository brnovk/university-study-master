package by.gsu.bugtracker.service.impl;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import by.gsu.bugtracker.domain.Notification;
import by.gsu.bugtracker.service.INotificationSender;

@Service
public class MyMailSender implements INotificationSender {
	
	private static final Logger LOG = Logger.getLogger(MyMailSender.class);
	
	@Inject
	private MailSender mailSender;
	
	@Inject
    private SimpleMailMessage templateMessage;

	@Override
	public void sendNotification(Notification notification) {
		LOG.info(notification);
		SimpleMailMessage msg = new SimpleMailMessage(this.templateMessage);
		msg.setTo(notification.getTo());
		msg.setText(notification.getMessage());
		LOG.info(msg);
		mailSender.send(msg);
	}
}
