package shop;

public class ShopBuyDTO {
	private String buy_id; // 유저 ID
	private int buy_productcode; // 구매 상품코드
	private String buy_productname;
	private String buy_productimg;
	private int buy_cnt; // 구매 개수
	private int buy_price; // 가격
	private String buy_addr; // 주소
	
	public ShopBuyDTO() {}
	public ShopBuyDTO(String buy_id, int buy_productcode, String buy_productname, String buy_productimg,int buy_cnt, int buy_price, String buy_addr) {
		this.buy_id = buy_id;
		this.buy_productcode = buy_productcode;
		this.buy_productname = buy_productname;
		this.buy_productimg = buy_productimg;
		this.buy_cnt = buy_cnt;
		this.buy_price = buy_price;
		this.buy_addr = buy_addr;
	}
	
	/* 구매한 유저 ========================	
	*/
	public String getBuy_id() {
		return buy_id;
	}
	public void setBuy_id(String buy_id) {
		this.buy_id = buy_id;
	}

	/* 구매 상품코드 ========================	
	*/
	public int getBuy_productcode() {
		return buy_productcode;
	}
	public void setBuy_productcode(int buy_productcode) {
		this.buy_productcode = buy_productcode;
	}

	/* 구매 상품명 ========================	
	*/
	public String getBuy_productname() {
		return buy_productname;
	}
	public void setBuy_productname(String buy_productname) {
		this.buy_productname = buy_productname;
	}
	
	/* 구매 상품이미지 ========================	
	*/
	public String getBuy_productimg() {
		return buy_productimg;
	}
	public void setBuy_productimg(String buy_productimg) {
		this.buy_productimg = buy_productimg;
	}
	
	/* 구매한 상품 개수 ========================	
	*/
	public int getBuy_cnt() {
		return buy_cnt;
	}
	public void setBuy_cnt(int buy_cnt) {
		this.buy_cnt = buy_cnt;
	}

	/* 구매 가격 ========================	
	*/
	public int getBuy_price() {
		return buy_price;
	}
	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}

	/* 구매한 유저가 입력한 주소 ========================	
	*/
	public String getBuy_addr() {
		return buy_addr;
	}
	public void setBuy_addr(String buy_addr) {
		this.buy_addr = buy_addr;
	}
}
