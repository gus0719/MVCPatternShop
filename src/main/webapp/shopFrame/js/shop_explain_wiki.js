var wikiBtn;
var updateWikiBtn;

var wiki_text;
var hidden_wiki;

function wikiInit(){
	wikiBtn = document.getElementById("wikiBtn");
	updateWikiBtn = document.getElementById("updateWikiBtn");
	wiki_text = document.getElementById("wiki_text");
	hidden_wiki = document.getElementById("wiki");
	updateWikiBtn.style.display = "none";
	
	wiki_text.innerHTML = hidden_wiki.value;
}
function enableWiki(){
	wiki_text.readOnly = false;
	wikiBtn.style.display = "none";
	updateWikiBtn.style.display = "inline-block";
}
function updateWiki(){
	//document.forms[1].action = "./shop_wiki_pro.jsp";
	document.getElementById("pagePd").value = "proWiki";
	document.forms[1].submit();
}