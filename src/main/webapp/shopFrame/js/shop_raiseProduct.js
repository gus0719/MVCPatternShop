var category;
var images;
var product_img;

/* 미리보기 객체 ==============
*/
var explain_top_mainImg;
var explain_top_subImg;
var explain_price;
var explain_name;
var explain_images;
var addImages;


function showAddImages(obj){
	addImages = document.getElementById("product_img");
	if(obj.value != "no"){
		addImages.style.display = "block";
	} else {
		addImages.style.display = "none";
	}
}

function getCategory(){
	category = document.getElementById("product_category").value;
}
function getImages(){
    images = document.getElementById("product_img");
    let pd_img = document.getElementById("pd_img");
    
    let path = "/" + category + "/";

    // 이미지 여러개 배열로 반환
    product_img = "[";
    product_img += Array.from(images.files).map(file => path + file.name);
    // 1. 이미지들을 하나씩 배열로 변환
    // 2. 파일객체에서 파일명으로 반환

    product_img += "]";
    
    pd_img.value = product_img;
    alert(pd_img.value);
}

function viewExplain(obj){
	document.querySelector("#product_info > textarea").innerHTML = obj.value;
}

function viewName(obj){
    document.getElementById("explain_name").innerHTML = obj.value;
}

function viewPrice(obj){
    document.getElementById("explain_price").innerHTML = parseInt(obj.value).toLocaleString("ko-KR")+"원";
}

function viewImg(prjPath){
    let text = pd_img.value;
    explain_top_mainImg = document.querySelector("#explain_top_mainImg > img");
    explain_top_subImg = document.getElementById("explain_top_subImg");
    explain_images = document.getElementById("explain_images");
    
    let imgArr = text.substring(text.indexOf("[")+1, text.lastIndexOf("]")).split(",");
    explain_top_mainImg.src = prjPath + "/img" + imgArr[0];

    explain_top_subImg.innerHTML = "";
    explain_images.innerHTML = "";
    for(let i = 0; i < imgArr.length; i++){
        explain_top_subImg.innerHTML +=
        `<img class = "explain_top_subImg_dots" src = "${prjPath + "/img" + imgArr[i]}">`;
        explain_images.innerHTML +=
        `<img src = "${prjPath + "/img" + imgArr[i]}">`;
    }
}