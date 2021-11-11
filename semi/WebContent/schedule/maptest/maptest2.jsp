<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mvc.dto.HeartDto"%> 
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>       

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
     
<!DOCTYPE html>
<html>
  <head>
    <title>searchmap</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    
    
    
    <style>


table {
  font-size: 13px;
  vertical-align: middle;
}
tr{
	cursor: pointer;
}


#map {height:550px;}

.map-search {
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center; 
   display: -webkit-box; 
  left: 30;
  position: relative;
  top: 0;
  width: 100%;
  z-index: 1;
}
 
 
#locationField {
  -webkit-box-flex: 1 1 190px;
  -ms-flex: 1 1 190px;
  flex: 1 1 190px;
  margin: 0 8px;
}

#controls {
  -webkit-box-flex: 1 1 140px;
  -ms-flex: 1 1 140px;
  flex: 1 1 140px;
}

#autocomplete {
  width: 100%;
}

#country {
  width: 100%;
}

.placeIcon {
  width: 20px;
  height: 34px;
  margin: 4px;
}

.hotelIcon {
  width: 24px;
  height: 24px;
}
 
#rating {
  font-size: 13px;
  font-family: Arial Unicode MS;
}
 



.form__group {
  position: relative;
  padding: 15px 0 0;
  margin-top: 10px;
  margin-bottom:30px;
  width: 70%;
}

.form__field {
  font-family: inherit;
  width: 100%;
  border: 0;
  border-bottom: 2px solid #9b9b9b;
  outline: 0;
  font-size: 1.3rem;
  color: black;
  padding: 7px 0;
  background: transparent;
  transition: border-color 0.2s;
}
.form__field::placeholder {
  color: transparent;
}
.form__field:placeholder-shown ~ .form__label {
  font-size: 1.3rem;
  cursor: text;
  top: 20px;
}

.form__label {
  position: absolute;
  top: 0;
  display: block;
  transition: 0.2s;
  font-size: 1rem;
  color: #9b9b9b;
}

.form__field:focus {
  padding-bottom: 6px;
  font-weight: 700;
  border-width: 3px;
  border-image: linear-gradient(to right, #11998e, #38ef7d);
  border-image-slice: 1;
}
.form__field:focus ~ .form__label {
  position: absolute;
  top: 0;
  display: block;
  transition: 0.2s;
  font-size: 1rem;
  color: #11998e;
  font-weight: 700;
}
 
.form__field:required, .form__field:invalid {
  box-shadow: none;
}

.form__group field {
  font-family: "Poppins", sans-serif;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 300vh;
  font-size: 1.5rem; 
  padding:20px;
}
    </style>
  </head>


<body>
 
    
   
 <div class="map-search">

 <div class="form__group field">
  <input type="text" class="form__field" placeholder="Name" name="name" id='autocomplete' required />
  <label for="name" class="form__label" style="font-family: 'Noto Sans KR', sans-serif;">어디로 떠나시나요?</label>
</div>
 </div>
 <div id="info-content" style="display:none;;">
 <table>
            <tr id="iw-url-row" class="iw_table_row">
              <td id="iw-icon" class="iw_table_icon"></td>
              <td id="iw-url"></td>
            </tr>
            <tr id="iw-address-row" class="iw_table_row">
              <td class="iw_attribute_name">Address:</td>
              <td id="iw-address"></td>
            </tr>
            <tr id="iw-phone-row" class="iw_table_row">
              <td class="iw_attribute_name">Telephone:</td>
              <td id="iw-phone"></td>
            </tr>
            <tr id="iw-rating-row" class="iw_table_row">
              <td class="iw_attribute_name">Rating:</td>
              <td id="iw-rating"></td>
            </tr>
            <tr id="iw-website-row" class="iw_table_row">
              <td class="iw_attribute_name">Website:</td>
              <td id="iw-website"></td>
            </tr>
          </table>
  <select id="country" style="visibility:hidden">
   <option value="all"></option>
   <option value="kr" selected></option>
  </select>
 </div>
 
 <div id="map" class="rounded"></div>
       
 <div id="floating-panel">
 </div>
 

<script>
var markerColor = {tourist_attraction:"fbfe00", lodging:"67ff58", restaurant:"fa4f2d"};
var markerlink = "http://www.googlemapsmarkers.com/v1/";

var types = ["tourist_attraction","lodging", "restaurant"]; //명소, 호텔,식당 type 3가지만 검색 
var map, places, infoWindow;
var markers = [];
var autocomplete;
var countryRestrict = { 'country': 'kr'};
var countries = {'kr': { center: {lat: 37.52,lng: 126.97},zoom: 12},};
var MARKER_PATH = 'https://developers.google.com/maps/documentation/javascript/images/marker_green'; 
var MARKER_BASEPATH = 'https://maps.google.com/mapfiles/ms/micons/'; 
var customIcons = { //지도상에서 type별 마커를 색으로 구분 
  tourist_attraction: {icon: MARKER_BASEPATH + "yellow.png"},
  lodging: {icon: MARKER_BASEPATH + "green.png"},
  restaurant: {icon: MARKER_BASEPATH + "red.png"}};
var hostnameRegexp = new RegExp('^https?://.+?/');
var countries = {
  'kr': { center: {lat: 37.52,lng: 126.97},zoom: 12},};
 
 var markerOnMap=new Array(); 
 <c:forEach items="${wished_list }" var="HeartDto">
 markerOnMap.push ({lat: Number("${HeartDto.latitude}")
	,lng:Number("${HeartDto.longtitude}") });
 </c:forEach>
 
 
 




	let fixedMarkers = [
		
	]; //drop시 찍히는 모든 마커의 배열 
 
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: countries['kr'].zoom,
    center: countries['kr'].center,
    mapTypeControl: false,
    panControl: false,
    streetViewControl: false
  });

  infoWindow = new google.maps.InfoWindow({
    content: document.getElementById('info-content')
  });

 
  autocomplete = new google.maps.places.Autocomplete(
		    (
	document.getElementById('autocomplete')), {
	});
	places = new google.maps.places.PlacesService(map);

	autocomplete.addListener('place_changed', onPlaceChanged);
    document.getElementById('country').addEventListener('change', setAutocompleteCountry);

	document.getElementById("drop").addEventListener("click", drop);  //id=drop, 클릭하면 드롭
	
	//TEST ING...
	document.getElementById("clickdrop").addEventListener("click",clickdrop);
	
	
	google.maps.event.addListener(map, "click", (event) => { 
	addMarker(event.latLng, map);});
	addMarker(markerOnMap, map);
	}
	
function onPlaceChanged() {
  var place = autocomplete.getPlace();
  if (place.geometry) {
    map.panTo(place.geometry.location);
    map.setZoom(15);
    search();
  } else {
    document.getElementById('autocomplete').placeholder = 'Enter a city';
  }
}

function search() {
  var FirstEsecution = true;

  types.forEach(type => {
    var search = {
      bounds: map.getBounds(),	
      types: [type]
    };
    

    places.nearbySearch(search, (function(type) {
      return function(results, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          console.log("processing " + results.length + " for type=" + type);
          if (FirstEsecution) {
            clearResults();
            clearMarkers();
            FirstEsecution = false;
          }
        
          for (var i = 0; i < results.length; i++) {
            var markerLetter = String.fromCharCode(
              "A".charCodeAt(0) + (i % 26)
            );
            var markerIcon = MARKER_PATH + markerLetter + ".png";
            if (!markers[type])
              markers[type] = [];
            markers[type][i] = new google.maps.Marker({
              position: results[i].geometry.location,
              animation: google.maps.Animation.DROP,
              icon: {
                url: customIcons[type].icon,
                labelOrigin: new google.maps.Point(15, 10)
              },
              label: {
                text: markerLetter,
              }
            });
            console.log(markers[type][i]);
            
            markers[type][i].placeResult = results[i];
            google.maps.event.addListener(
              markers[type][i],
              "click",
              showInfoWindow
            );
            setTimeout(dropMarker(i), i * 100);
            addResult(results[i], i, type);
          }
        } else console.log("no results for " + type + ": " + status)
      };
    })(type))
  })
}

function clearMarkers() {
  for (var j = 0; j < types.length; j++) {
    type = types[j];
    if (markers[type]) {
      for (var i = 0; i < markers[type].length; i++) {
        if (markers[type][i]) {
          markers[type][i].setMap(null);
        }
      }
      markers[type] = [];
    }
  }
}

function setAutocompleteCountry() {
  var country = document.getElementById('country').value;
  if (country == 'all') {
    autocomplete.setComponentRestrictions({
      'country': []
    });
    map.setCenter({
      lat: 15,
      lng: 0
    });
    map.setZoom(2);
  } else {
    autocomplete.setComponentRestrictions({
      'country': country
    });
    map.setCenter(countries[country].center);
    map.setZoom(countries[country].zoom);
  }
  clearResults();
  clearMarkers();
}

function dropMarker(i) {
  return function() {
    for (var j = 0; j < types.length; j++) {
      type = types[j];
      if (markers[type] && markers[type].length > i) {
        console.log("drop " + type + " " + i);
        markers[type][i].setMap(map);
      };
    }
  }
}
 


function addResult(result, i, type) {
	  var results = document.getElementById('results');
	  var results_ta=document.getElementById('result_ta');
	  var results_rest=document.getElementById('result_rest');

	  var markerLetter = String.fromCharCode('A'.charCodeAt(0) + (i % 26));
	  var markerIcon = markerlink + markerLetter + "/" + markerColor[type]; 
	  console.log(markerIcon);
	  var tr = document.createElement('tr');
	  tr.onclick = function() {
	    google.maps.event.trigger(markers[type][i], 'click');
	  };

	  var iconTd = document.createElement('td');
	  var nameTd = document.createElement('td'); 
	  var icon = document.createElement('img');
	  icon.src = markerIcon;
	  icon.setAttribute('class', 'placeIcon');
	  icon.setAttribute('className', 'placeIcon');
	  var name = document.createTextNode(result.name);
	  iconTd.appendChild(icon);
	  nameTd.appendChild(name); 
	  tr.appendChild(iconTd);
	  tr.appendChild(nameTd);   
	  
	  if(type==="lodging"){   //검색 결과를 타입별 컨테이너에 분류 
	  //results.appendChild(tr);
		  document.getElementById('results').appendChild(tr);
	  }else if(type==="tourist_attraction"){
		  document.getElementById('results_ta').appendChild(tr);
	  }else if(type==="restaurant"){
		  document.getElementById('results_rest').appendChild(tr);
	  }
	}

function clearResults() {
	  var results = document.getElementById('results');
	  while (results.childNodes[0]) {
	    results.removeChild(results.childNodes[0]);
	  }
	 
	  var results_ta = document.getElementById('results_ta');
	  while (results_ta.childNodes[0]) {
	    results_ta.removeChild(results_ta.childNodes[0]);
	  }
	  
	  var results_rest = document.getElementById('results_rest');
	  while (results_rest.childNodes[0]) {
	    results_rest.removeChild(results_rest.childNodes[0]);
	  }
}

function showInfoWindow() {
  var marker = this;
  places.getDetails({
      placeId: marker.placeResult.place_id
    },
    function(place, status) {
      if (status !== google.maps.places.PlacesServiceStatus.OK) {
        return;
      }
      infoWindow.close(map, marker);
      buildIWContent(place);
    });
}

function drop() {
clearMarkersOnMap(); 
for (var i = 0; i < markerOnMap.length; i++) {
 addMarkerWithTimeout(markerOnMap[i], i * 200);
 
 console.log(markerOnMap);
}
}
 
  

function addMarkerWithTimeout(location, timeout) {
      var image='img/heartmarker2.png';
      
      
window.setTimeout(() => {
   fixedMarkers.push(
   new google.maps.Marker({
     position: location,
     map,
     animation: google.maps.Animation.DROP,
     icon:image,
   })
 );
}, timeout); 
   

}

function addMarker(location, timeout) {
      var image='img/heartmarker2.png';
      window.setTimeout(() => {
   fixedMarkers.push(
   new google.maps.Marker({
       position: location,
       map: map,
       icon:image,
       animation: google.maps.Animation.DROP,
     })
     );
      }, timeout);
   }

function clearMarkersOnMap() {
for (let i = 0; i < fixedMarkers.length; i++) {
   fixedMarkers[i].setMap(null);
}
fixedMarkers = [];

}

function buildIWContent(place) {
	console.log(place);
	if(place.hasOwnProperty('photos')){
		$("#modalimage").html("<img src='" + place.photos[0].getUrl({'maxWidth':400, 'maxHeight':400}) + "'>");
	}else{
		$("#modalimage").html("<img src='" + place.icon + "'>");
	}
	
	document.getElementById('modalName').innerHTML = place.name;
	document.getElementById('modalAddress').textContent = place.vicinity;
	$("#modaldetailpage").html("<b><a href='" + place.url + "'>상세보기</a></b>");  
	
  document.getElementById('iw-icon').innerHTML = '<img class="hotelIcon" ' + 'src="' + place.icon + '"/>';
  document.getElementById('iw-url').innerHTML = '<b><a href="' + place.url + '">' + place.name + '</a></b>';
  document.getElementById('iw-address').textContent = place.vicinity;

  if (place.formatted_phone_number) {
    document.getElementById('iw-phone-row').style.display = '';
    document.getElementById('modalPhone').style.display = '';
    document.getElementById('iw-phone').textContent = place.formatted_phone_number;
    document.getElementById('modalPhone').textContent = place.formatted_phone_number;
  } else {
    document.getElementById('iw-phone-row').style.display = 'none';
    document.getElementById('modalPhone').style.display = 'none';
  }


  if (place.rating) {
    var ratingHtml = '';
    for (var i = 0; i < 5; i++) {
      if (place.rating < (i + 0.5)) {
        ratingHtml += '<img src="img/starhalf.png" style="width:3%;">';
      } else {
        ratingHtml += '<img src="img/star.png" style="width:3%;">';
      }
      document.getElementById('iw-rating-row').style.display = '';
      document.getElementById('iw-rating').innerHTML = ratingHtml;
      document.getElementById('modalRating').style.display = '';
      document.getElementById('modalRating').innerHTML = ratingHtml;
    }
  } else {
    document.getElementById('iw-rating-row').style.display = 'none';
    document.getElementById('modalRating').style.display = 'none';
  }

  if (place.website) {
    var fullUrl = place.website;
    var website = hostnameRegexp.exec(place.website);
    if (website === null) {
      website = 'http://' + place.website + '/';
      fullUrl = website;
    }
    document.getElementById('iw-website-row').style.display = '';
    document.getElementById('iw-website').textContent = website;
    document.getElementById('modalUrl').style.display = '';
	$("#modalUrl").removeAttr("href");
	$("#modalUrl").attr("href",website);
  } else {
    document.getElementById('iw-website-row').style.display = 'none';
    document.getElementById('modalUrl').style.display = 'none';
  }
  
  //---------modal input hidden-----------
  	$("#address").val(place.vicinity);
  	$("#url").val(place.url);
  	$("#lng").val(place.geometry.location.lng());
  	$("#lat").val(place.geometry.location.lat());
	for(var i = 0; i < place.address_components.length; i++){
		if(place.address_components[i].types[0] == 'country'){
			$("#nation").val(place.address_components[i].long_name); break;
		}	
	}
	for(var i = 0; i < place.address_components.length; i++){
		if(place.address_components[i].types[0] == 'administrative_area_level_1'){
			$("#city").val(place.address_components[i].long_name); break;
		}	
	}
  
  
}
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOFLxuHpLh-ga2m0oiOm5C66luLW65QQ&libraries=places&callback=initMap"
        async defer></script>
     <script src="https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT
  &key=AIzaSyDEOFLxuHpLh-ga2m0oiOm5C66luLW65QQ"></script>
  </body>
</html>






















