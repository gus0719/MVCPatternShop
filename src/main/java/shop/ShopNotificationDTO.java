package shop;

public class ShopNotificationDTO {
	private int notification_No;
	private String notification_Subject;
	private String notification_Id;
	private String notification_Content;
	private String notification_Date;
	
	public ShopNotificationDTO() {};
	
	public ShopNotificationDTO(int notification_No, String notification_Subject, String notification_Id,
			String notification_Content, String notification_Date) {
		super();
		this.notification_No = notification_No;
		this.notification_Subject = notification_Subject;
		this.notification_Id = notification_Id;
		this.notification_Content = notification_Content;
		this.notification_Date = notification_Date;
	}
	
	public int getNotification_No() {
		return notification_No;
	}

	public void setNotification_No(int notification_No) {
		this.notification_No = notification_No;
	}

	public String getNotification_Subject() {
		return notification_Subject;
	}

	public void setNotification_Subject(String notification_Subject) {
		this.notification_Subject = notification_Subject;
	}

	public String getNotification_Id() {
		return notification_Id;
	}

	public void setNotification_Id(String notificationc_Id) {
		this.notification_Id = notificationc_Id;
	}

	public String getNotification_Content() {
		return notification_Content;
	}

	public void setNotification_Content(String notification_Content) {
		this.notification_Content = notification_Content;
	}

	public String getNotification_Date() {
		return notification_Date;
	}

	public void setNotification_Date(String notification_Date) {
		this.notification_Date = notification_Date;
	}
	
	
}
