package shop;

public class ShopWikiDTO {
	private int wiki_code;
	private String wiki_product_name;
	private String wiki_text;
	
	public ShopWikiDTO() {}
	
	public ShopWikiDTO(int wiki_code, String wiki_product_name, String wiki_text) {
		this.wiki_code = wiki_code;
		this.wiki_product_name = wiki_product_name;
		this.wiki_text = wiki_text;
	}

	/* 상품 코드 ==================
	*/
	public int getWiki_code() {
		return wiki_code;
	}
	public void setWiki_code(int wiki_code) {
		this.wiki_code = wiki_code;
	}

	/* 상품명 ==================
	*/
	public String getWiki_product_name() {
		return wiki_product_name;
	}
	public void setWiki_product_name(String wiki_product_name) {
		this.wiki_product_name = wiki_product_name;
	}

	/* 상품의 위키 ==================================
	*/
	public String getWiki_text() {
		return wiki_text;
	}
	public void setWiki_text(String wiki_text) {
		this.wiki_text = wiki_text;
	}
}