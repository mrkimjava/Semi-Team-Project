/**
 * 
 */
 
//ajax json변수 및 start seq 변수(좌우이동)
var list;
var start = 0;

//picture변환1 관련 전역변수
var length = 6;
var idx = 1;
var slide = 6000;
var path = "./img/background/back";

//picture변환2 전역변수
var seq = 1;

//searchtext
var text = "";
var flag = true;

//onload
$(document).ready(function(){
	
	//blogdto list 가져오기
	$.ajax({
		url:"blog.do?command=bloglist",
		method: "post",
		dataType: "json",
		success:function(data){
		
			list = data;
			
			for(var i = 0; i < data.length; i++){
			
				if(i == 3) return;
				console.log(1);
				$(".card").eq(i).find("img").eq(0).prop("src", data[i].path);
				var str = "";
				for(var j = data[i].penalty; j < 3; j++){str += "★";}
				for(var j = 0; j < data[i].penalty; j++){str += "☆";}
				$(".card").eq(i).find("p").eq(0).html(data[i].userid + "&nbsp;" + str);
				$(".card").eq(i).find("span").eq(0).html(data[i].mindate + " ~ " + data[i].maxdate);
				var area = data[i].area.split(",").join(" ");
				$(".card").eq(i).find("b").eq(0).html(area);
				$(".card").eq(i).find("h6").html(data[i].title);
				$(".card").eq(i).find("p").eq(1).html(data[i].content);
				$(".card").eq(i).find("button").attr("onclick","location.href='blog.do?command=selectone&blogseq=" + data[i].blogseq + "&user_id=" + data[i].userid + "'");
				$(".card").eq(i).find("span").eq(1).html(data[i].blogheart);
				$(".card").eq(i).find("span").eq(2).html(data[i].comment);
				$(".card").eq(i).find("span").eq(3).html(data[i].hits);
			}
		}
	});
	
	$(".partner").click(function(){
		var val = $(this).val();
		seq = (parseInt(val)+1)==6? 1 : (parseInt(val)+1);
		var src ="img/partner2/donghang" + val + ".PNG";
		$("#partner_img").hide();
		$("#partner_img").prop("src",src);
		
		$(".partner").each(function(){
			if($(this).val() == val){
				$(this).css("background-color", "gray");
			}else{
				$(this).css("background-color", "white");
			}
		});
		$("#partner_img").animate().fadeIn(100);
	});
	$("#search").mouseover(function(){$(this).css("background-color","rgb(105, 231, 175)"); $(this).css("border","solid 0px");})
	$("#search").mouseleave(function(){$(this).css("background-color","white"); $(this).css("border","solid 1px #d3d3d3");})
	$("#searchbtn").mouseover(function(){$(this).css("background-color","rgb(105, 231, 175)"); $(this).css("border","solid 0px");})
	$("#searchbtn").mouseleave(function(){$(this).css("background-color","white"); $(this).css("border","solid 1px #d3d3d3");})
	
	$("#search").focusin(function(){
		flag = false;
		$(this).css("background-color", "white");
		$(this).css("border","solid 1px #d3d3d3");
		$(this).off('mouseover');
		$(this).animate({width:"400px"},"fast");
		$(this).attr("readonly",false);
		$(this).css("text-align","left");
		$(this).css("text-indent", "15px");
		$(this).css("cursor","auto");
		$("#searchbtn").show();
		$(this).attr("placeholder","키워드를 입력하세요");
		if(text != ""){
			$(this).val(text);
		}
	});
	$(document).click(function(e){
		if(flag || $(e.target).is("#searchdiv")||$(e.target).is("#search")||$(e.target).is("#searchbtnimg") || $(e.target).is("#searchbtn")){
			return;
		}
		console.log(flag);
		$("#search").mouseover(function(){$(this).css("background-color","rgb(105, 231, 175)"); $(this).css("border","solid 0px");})
		$("#search").animate({width:"170px"},"fast");
		$("#search").attr("readonly",true);
		$("#search").css("text-align","center");
		$("#search").css("text-indent", "0px");
		$("#search").css("cursor","pointer");
		$("#searchbtn").hide();
		$("#search").attr("placeholder","유연한 검색");
		if($("#search").val() != ""){
			text = $("#search").val();
		}else{
			text = "";
		}
		$("#search").val("");
		flag = true;
	});
	
/*		$("#searchform").submit(function(){
		if($("#search").val()==""){
			return true;
		}
	});*/
	
	window.setTimeout(changePicture, 4000);
	changePicture_2();
	
});

//picture변환1
function changePicture() {
	idx = (idx + 1)%length == 0? length : (idx + 1)%length;
	var ipath = path + idx + ".jpg";
	
	$("#img").animate({opacity:0}, 800, function(){
		$("#img").css('backgroundImage', function(){
			return "url(" + ipath+ ")";
		});
	});
	
	$("#img").animate({opacity:1}, 800);
	window.setTimeout(changePicture, slide);
}

//picture변환2
function changePicture_2(){
	
	var src ="img/partner2/donghang" + seq + ".PNG";
	$("#partner_img").hide();
	$("#partner_img").prop("src",src);
	$(".partner").each(function(){
		if($(this).val() == seq){
			$(this).css("background-color","gray");
		}else{
			$(this).css("background-color","white");
		}
	})
	$("#partner_img").animate().fadeIn("100");
	seq = (seq + 1)==6? 1 : (seq + 1);
	
	window.setTimeout(changePicture_2, 5000);
}
//left 버튼
function left(){
	if(list.length <= 3) {
		alert("더이상 글이 존재하지 않습니다.");
		return;
	}

	$(".card").eq(0).animate().stop();
	start = (start-1) < 0? list.length-1 : (start-1);
	temp = start;
	$("#left_thumbnail").hide();
	$("#left_thumbnail").hide().animate().show(300);
	$(".card").each(function(){
		$(this).find("img").eq(0).prop("src", list[start].path);
		var str = "";
		for(var i = list[start].penalty; i < 3; i++){str += "★";}
		for(var i = 0; i < list[start].penalty; i++){str += "☆";}
		$(this).find("p").eq(0).html(list[start].userid + "&nbsp;" + str);
		$(this).find("span").eq(0).html(list[start].mindate + " ~ " + list[start].maxdate);
		var area = list[start].area.split(",").join(" ");
		$(this).find("b").eq(0).html(area);
		$(this).find("h6").html(list[start].title);
		$(this).find("p").eq(1).html(list[start].content);
		$(this).find("button").attr("onclick","location.href='blog.do?command=selectone&blogseq=" + list[start].blogseq + "&user_id=" + list[start].userid + "'");
		$(this).find("span").eq(1).html(list[start].blogheart);
		$(this).find("span").eq(2).html(list[start].comment);
		$(this).find("span").eq(3).html(list[start].hits);
		start = (start + 1)==list.length? 0 : (start)+1;
	});
	
	
	start = temp;
}
//right 버튼
function right(){
	if(list.length <= 3) {
		alert("더이상 글이 존재하지 않습니다.");
		return;
	}

	$(".card").eq(2).animate().stop();
	var temp = start;
	
	$(".card").eq(2).css("opacity",0);
	$("#right_thumbnail").animate({opacity: 1}, 700);
	
	$(".card").each(function(){
		start = (start+1)==list.length? 0 : (start+1);
		$(this).find("img").eq(0).prop("src", list[start].path);
		var str = "";
		for(var i = list[start].penalty; i < 3; i++){str += "★";}
		for(var i = 0; i < list[start].penalty; i++){str += "☆";}
		$(this).find("p").eq(0).html(list[start].userid + "&nbsp;" + str);
		$(this).find("span").eq(0).html(list[start].mindate + " ~ " + list[start].maxdate);
		var area = list[start].area.split(",").join(" ");
		$(this).find("b").eq(0).html(area);
		$(this).find("h6").html(list[start].title);
		$(this).find("p").eq(1).html(list[start].content);
		$(this).find("button").attr("onclick","location.href='blog.do?command=selectone&blogseq=" + list[start].blogseq + "&user_id=" + list[start].userid + "'");
		$(this).find("span").eq(1).html(list[start].blogheart);
		$(this).find("span").eq(2).html(list[start].comment);
		$(this).find("span").eq(3).html(list[start].hits);
	});
	
	
	start = (temp+1)==list.length? 0 : (temp+1);
}