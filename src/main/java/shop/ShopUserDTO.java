package shop;

public class ShopUserDTO {
	private String user_id; // 유저 ID
	private String user_pwd; // 유저 Password
	private String user_name; // 유저 이름
	private String user_phone; // 유저 전화번호
	private String user_email; // 유저 이메일
	private String user_addr; // 유저 주소
	private String user_rank; // 유저 등급 => 구매자 or 판매자
	
	public ShopUserDTO() {}
	
	/* 회원가입 정보 생성자 ==========================================================================================
	*/
	public ShopUserDTO(String user_id, String user_pwd, String user_name, String user_phone, String user_email,
			String user_addr, String user_rank) {
		this.user_id = user_id;
		this.user_pwd = user_pwd;
		this.user_name = user_name;
		this.user_phone = user_phone;
		this.user_email = user_email;
		this.user_addr = user_addr;
		this.user_rank = user_rank;
	}

	/* 유저 ID ========================	
	*/
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	/* 유저 Password ========================	
	*/
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	/* 유저 이름 ========================	
	*/
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	/* 유저 전화번호 ========================
	*/
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	/* 유저 이메일 ========================	
	*/
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	/* 유저 주소 ========================
	*/
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	/* 유저 등급 ========================> 구매자 or 판매자	
	*/
	public String getUser_rank() {
		return user_rank;
	}
	public void setUser_rank(String user_rank) {
		this.user_rank = user_rank;
	}
}