package by.gsu.bugtracker.service;

import by.gsu.bugtracker.domain.Notification;

public interface INotificationSender {
	
	void sendNotification(Notification notification);
}
