package shop;

public class ShopProductDTO {
	private int product_code; // 상품코드
	private String product_category; // 카테고리
	private String product_brand; // 브랜드
	private String product_name; // 상품명
	private int product_price; // 상품가격
	private String product_explain; // 상품설명
	private String product_seller; // 판매자
	private String product_date; // 등록일
	private String product_img; // 상품이미지
	
	
	/*기본 생성자================
	*/
	public ShopProductDTO() {}
	
	/*초기화용 생성자=======================================================================================================
	*/
	public ShopProductDTO(int product_code, String product_category, String product_brand, String product_name,
			int product_price, String product_explain, String product_seller, String product_date, String product_img) {
		this.product_code = product_code;
		this.product_category = product_category;
		this.product_brand = product_brand;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_explain = product_explain;
		this.product_seller = product_seller;
		this.product_date = product_date;
		this.product_img = product_img;
	}
	
	// =================================================================
	// getter / setter =================================================
	
	/*상품코드=======================================
	*/
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
	
	/*카테고리=======================================
	*/
	public String getProduct_category() {
		return product_category;
	}
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	
	/*브랜드========================================
	*/
	public String getProduct_brand() {
		return product_brand;
	}
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	
	/*상품명========================================
	*/
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	/*상품가격=======================================
	*/
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	/*상품설명=======================================
	*/
	public String getProduct_explain() {
		return product_explain;
	}
	public void setProduct_explain(String product_explain) {
		this.product_explain = product_explain;
	}
	
	/*판매자========================================
	*/
	public String getProduct_seller() {
		return product_seller;
	}
	public void setProduct_seller(String product_seller) {
		this.product_seller = product_seller;
	}
	
	/*등록일========================================
	*/
	public String getProduct_date() {
		return product_date;
	}
	public void setProduct_date(String product_date) {
		this.product_date = product_date;
	}
	
	/*상품이미지=======================================
	*/
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
}