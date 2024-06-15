package shop;

public class ShopCartDTO {
	private String cart_id; // 유저의 ID
	private int cart_code; // 장바구니 상품코드
	private String cart_product_name; // 상품명
	private String cart_product_img; // 상품이미지
	private int cart_num; // 장바구니 상품의 개수
	
	public ShopCartDTO() {}
	
	public ShopCartDTO(String cart_id, int cart_code, String cart_product_name, String cart_product_img, int cart_num) {
		this.cart_id = cart_id;
		this.cart_code = cart_code;
		this.cart_product_name = cart_product_name;
		this.cart_product_img = cart_product_img;
		this.cart_num = cart_num;
	}

	/* 상품을 장바구니에 담은 유저 ========================	
	*/
	public String getCart_id() {
		return cart_id;
	}
	public void setCart_id(String cart_id) {
		this.cart_id = cart_id;
	}

	/* 장바구니 상품코드 ========================	
	*/
	public int getCart_code() {
		return cart_code;
	}
	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}
	
	/* 장바구니 상품명 ========================	
	*/
	public String getCart_product_name() {
		return cart_product_name;
	}
	public void setCart_product_name(String cart_product_name) {
		this.cart_product_name = cart_product_name;
	}

	/* 장바구니 상품이미지 ========================	
	*/
	public String getCart_product_img() {
		return cart_product_img;
	}
	public void setCart_product_img(String cart_product_img) {
		this.cart_product_img = cart_product_img;
	}

	/* 장바구니에 담긴 상품의 개수 ========================	
	*/
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
}
