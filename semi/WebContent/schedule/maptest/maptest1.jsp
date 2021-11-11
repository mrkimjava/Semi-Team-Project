<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>       
    
<!DOCTYPE html>
<html>
  <head>
    <title>searchmap</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    
    <style>


 
 
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
}

<!--body {padding: 0 !important;}-->

table {
  font-size: 12px;
}
#map {width:80%; height:550px; bottom:50px; left:120px;}

.map-search {
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  background: #fff;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  left: 0;
  position: relative;
  top: 0;
  width: 440px;
  z-index: 1;
}

 

#findmaps {
  font-size: 14px;
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


#rating {
  font-size: 13px;
  font-family: Arial Unicode MS;
}

photos{
      "html_attributions" : [],
      "height" : 20,
      "width" : 20,
      "photo_reference" : "CnRvAAAAwMpdHeWlXl-lH0vp7lez4znKPIWSWvgvZFISdKx45AwJVP1Qp37YOrH7sqHMJ8C-vBDC546decipPHchJhHZL94RcTUfPa1jWzo-rSHaTlbNtjh-N68RkcToUCuY9v2HNpo5mziqkir37WU8FJEqVBIQ4k938TI3e7bf8xq-uwDZcxoUbO_ZJzPxremiQurAYzCTwRhE_V0"
   }
 
    </style>
  </head>

  <body>
 
      
    <div id="map"></div>
    
    <div class="map-search">
      <div id="findmaps">
      	search:
    </div>
      
      	<!-- 장소검색 -->  
    <div id="locationField">
      <input id="autocomplete" placeholder="Enter a city" type="text" />
    </div>
      <!-- area지정 국내(korea) / 국외(all) -->
    <div id="controls">
       <select id="country">
        <option value="all">세계</option>
        <option value="kr" selected>국내</option>
      </select>
      </div>
    </div>
       
       
    <div style="display: none">
      <div id="info-content">
        </div>
      </div>

  
  
 <script>  
var types = ["tourist_attraction","lodging", "restaurant"]; //명소, 호텔,식당 type 3가지만 검색 
var map, places, infoWindow;
var markers = [];
var autocomplete;
var countryRestrict = { //지도 시작시 기본 포커스 
  'country': 'kr'
};
var MARKER_PATH = 'https://developers.google.com/maps/documentation/javascript/images/marker_green'; 
var MARKER_BASEPATH = 'https://maps.google.com/mapfiles/ms/micons/'; 
var customIcons = { //지도상에서 type별 마커를 색으로 구분 
  tourist_attraction: {icon: MARKER_BASEPATH + "yellow.png"},
  lodging: {icon: MARKER_BASEPATH + "green.png"},
  restaurant: {icon: MARKER_BASEPATH + "red.png"}};
var hostnameRegexp = new RegExp('^https?://.+?/');
var countries = {
  'kr': { center: {lat: 37.55,lng: 126.84},zoom: 12},};



function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: countries['kr'].zoom,
    center: countries['kr'].center,
    mapTypeControl: false,
    panControl: false,
    zoomControl: false,
    streetViewControl: false
  });

  infoWindow = new google.maps.InfoWindow({
    content: document.getElementById('info-content')
  });

  // Create the autocomplete object and associate it with the UI input control.
  // Restrict the search to the default country, and to place type "cities".
  autocomplete = new google.maps.places.Autocomplete(
    /** @type {!HTMLInputElement} */
    (
      document.getElementById('autocomplete')), {
      types: ['(cities)'],
      componentRestrictions: countryRestrict
    });
  places = new google.maps.places.PlacesService(map);

  autocomplete.addListener('place_changed', onPlaceChanged);

  // Add a DOM event listener to react when the user selects a country.
  document.getElementById('country').addEventListener(
    'change', setAutocompleteCountry);
}

// When the user selects a city, get the place details for the city and
// zoom the map in on the city.
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

// Search for hotels in the selected city, within the viewport of the map.
function search() {
  var FirstEsecution = true;

  types.forEach(type => {
    var search = {
      bounds: map.getBounds(),
      types: [type]
    };
    

    places.nearbySearch(search, (function(type) { //검색 도시 주변반경 검색 
      return function(results, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          console.log("processing " + results.length + " for type=" + type);
          if (FirstEsecution) {
            clearResults();
            clearMarkers();
            FirstEsecution = false;
          }
          // Create a marker for each hotel found, and
          // assign a letter of the alphabetic to each marker icon.
          for (var i = 0; i < results.length; i++) {
            var markerLetter = String.fromCharCode(
              "A".charCodeAt(0) + (i % 26)
            );
            var markerIcon = MARKER_PATH + markerLetter + ".png";
            // Use marker animation to drop the icons incrementally on the map.
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
            // If the user clicks a hotel marker, show the details of that hotel
            // in an info window.
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
// Set the country restriction based on user input.
// Also center and zoom the map on the given country.
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

<!--listing !! --> <!--createSchedule.jsp의 thead id=results/_ta/_rest로 연결-->
function addResult(result, i, type) {
  var results = document.getElementById('results');
  var results_ta=document.getElementById('result_ta');
  var results_rest=document.getElementById('result_rest');

  var markerLetter = String.fromCharCode('A'.charCodeAt(0) + (i % 26));
  var markerIcon = MARKER_PATH + markerLetter + '.png'; 
  var tr = document.createElement('tr');
  //tr.style.backgroundColor = (i % 2 === 0 ? '#F0F0F0' : '#FFFFFF'); 퐁당퐁당 배경색 일단지움..
  tr.onclick = function() {
    google.maps.event.trigger(markers[type][i], 'click');
  };

  var iconTd = document.createElement('td');
  var nameTd = document.createElement('td'); 
  var icon = document.createElement('img');
  icon.src = markerIcon;
  icon.setAttribute('class', 'placeIcon');
  icon.setAttribute('className', 'placeIcon');
  //var name = document.createTextNode(type + ":" + result.name); //제목에 type표시 일단지움..
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

// Get the place details for a hotel. Show the information in an info window,
// anchored on the marker for the hotel that the user selected.
function showInfoWindow() {
  var marker = this;
  places.getDetails({
      placeId: marker.placeResult.place_id
    },
    function(place, status) {
      if (status !== google.maps.places.PlacesServiceStatus.OK) {
        return;
      }
      infoWindow.open(map, marker);
      buildIWContent(place);
    });
}

<!--Modal : infowindow-->
function buildIWContent(place) {

  document.getElementById('modalimage').innerHTML = '<img src="'+place.photos[0].getUrl({'maxWidth': 400, 'maxHeight': 400})+'">';  
  document.getElementById('modalName').innerHTML = '<b><a href="' + place.url +  '">' + place.name + '</a></b>';
  document.getElementById('modalAddress').textContent = place.vicinity;
  document.getElementById('modalPhone').textContent = place.formatted_phone_number;
  
  // Assign a five-star rating to the hotel, using a black star ('&#10029;')
  // to indicate the rating the hotel has earned, and a white star ('&#10025;')
  // for the rating points not achieved.
  if (place.rating) {
    var ratingHtml = '';
    for (var i = 0; i < 5; i++) {
      if (place.rating < (i + 0.5)) {
        ratingHtml += '&#10025;';
      } else {
        ratingHtml += '&#10029;';
      }
      document.getElementById('modalRating').style.display = '';
      document.getElementById('modalRating').innerHTML = ratingHtml;
    }
  } else {
    document.getElementById('modalRating').style.display = 'none';
  }

  document.getElementById('modalUrl').textContent = website;
  // The regexp isolates the first part of the URL (domain plus subdomain)
  // to give a short URL for displaying in the info window.
  if (place.website) {
    var fullUrl = place.website;
    var website = hostnameRegexp.exec(place.website);
    if (website === null) {
      website = 'http://' + place.website + '/';
      fullUrl = website;
    } 
    document.getElementById('modalUrl').textContent = website;
  }   
}
    </script> 
          <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEOFLxuHpLh-ga2m0oiOm5C66luLW65QQ&libraries=places&callback=initMap" async defer></script>
     <script src="https://maps.googleapis.com/maps/api/place/photo?maxwidth=20&photo_reference=Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT
  &key=AIzaSyDEOFLxuHpLh-ga2m0oiOm5C66luLW65QQ"></script>
  </body>
</html>