var cl = console.log;
var airportDatabase = null;
var _airport = null;
var map = null;
var floor = null;

function show_results(results,center) {
    var poiDatabase = _airport.poiDatabase();
    //console.log(results);
    $.each(results.getResults(),function (i,result) {
        //console.log(result);
        if (center) {
            map.setRadius(10.0);
            map.setCenter(result.position.latLng);
        }
        var circle = new locuslabs.maps.Circle({ 
            center : result.position.latLng,
            radius : 3,
            map : map,
            fillColor : 'red',
            strokeWeight : 1,
            strokeColor : 'black',
            zIndex : 5
        });
    });
}

function load_pois() 
{
//    map.setRadius(2.0);
    var search = _airport.search();
    //search.search('bathroom',show_results);
}

var beaconCircles = [];

function map_loaded(_map)
{
    var path = new locuslabs.maps.Path();
    map = _map;
    load_pois();
    console.log(map);

    floor.listBeacons(function (beacons) {
        console.log(beacons);
        $.each(beacons,function (i,beacon) {
            var floorView = map.getView().getFloorView(beacon.floorId);
            var circle = new locuslabs.maps.Circle({ 
                center : beacon.position,
                radius : 3,
                floor : floorView,
                fillColor : 'red',
                strokeWeight : 1,
                strokeColor : 'black',
                zIndex : 5
            });
            beaconCircles.push(circle);
        });
    });

    /* -------------------------  Circles  ------------------------- */
    // var circle = new locuslabs.maps.Circle({ 
    //     center : new locuslabs.maps.LatLng(32.89756397429854,-97.04451934298332), 
    //     radius : 10,
    //     map : map,
    //     fillColor : 'red',
    //     strokeWeight : 1,
    //     strokeColor : 'black',
    //     zIndex : 5
    // });

    /* -------------------------  Markers  ------------------------- */
    // var marker = new locuslabs.maps.Marker({
    //     position : new locuslabs.maps.LatLng(32.899044365968116,
    //                                          -97.04462256145348), 
    //     icon : { url :'images/pin.png'
    // 		 // origin : new locuslabs.maps.Point(5, 5), 
    // 		 // scaledSize : new locuslabs.maps.Size(100, 27), 
    // 		 // size : new locuslabs.maps.Size(8, 27) 
    // 	       },
    //     map : map,
    // 	draggable : true
    // });

    // sprites example
    // var marker0 = new locuslabs.maps.Marker({
    //     position : new locuslabs.maps.LatLng(32.899044365968116,
    //                                          -97.04462256145348), 
    //     icon : { url :'images/pin.png',
    // 		 origin : new locuslabs.maps.Point(5, 5)
    // 		 // scaledSize : new locuslabs.maps.Size(100, 27), 
    // 		 // size : new locuslabs.maps.Size(8, 27) 
    // 	       },
    //     map : map,
    // 	draggable : true
    // });

    // var marker1 = new locuslabs.maps.Marker({
    //     position : new locuslabs.maps.LatLng(32.898644365968116,
    //                                          -97.04402256145348),
    // 	icon : { anchor: new locuslabs.maps.Point(30, 10),
    // 		 path: 'M 125,5 155,90 245,90 175,145 200,230 125,180 50,230 75,145 5,90 95,90 z',
    // 		 fillColor: 'yellow',
    // 		 fillOpacity: 0.8,
    // 		 scale: 0.5,
    // 		 rotation: 30,
    // 		 strokeColor: 'gold',
    // 		 strokeWeight: 14 },
    //     map : map,
    // 	draggable : true
    // });

    /* ------------------------  InfoWindows  ------------------------ */
    var contentString = '<div id="content">'+
	'<div id="siteNotice">'+
	'</div>'+
	'<h1 id="firstHeading" class="firstHeading">Uluru</h1>'+
	'<div id="bodyContent">'+
	'<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
	'sandstone rock formation in the southern part of the '+
	'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) '+
	'south west of the nearest large town, Alice Springs; 450&#160;km '+
	'(280&#160;mi) by road. Kata Tjuta and Uluru are the two major '+
	'features of the Uluru - Kata Tjuta National Park. Uluru is '+
	'sacred to the Pitjantjatjara and Yankunytjatjara, the '+
	'Aboriginal people of the area. It has many springs, waterholes, '+
	'rock caves and ancient paintings. Uluru is listed as a World '+
	'Heritage Site.</p>'+
	'<p>Attribution: Uluru, <a href="http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
	'http://en.wikipedia.org/w/index.php?title=Uluru</a> '+
	'(last visited June 22, 2009).</p>'+
	'</div>'+
	'</div>';
    // var info = new locuslabs.maps.InfoWindow({
    // 	map : map,
    // 	maxWidth : 300,
    // 	arrowPosition : 40,
	
    // 	position : new locuslabs.maps.LatLng(32.898644365968116,
    //                                          -97.04402256145348),
    // 	content : '<p>hi</p>'
    // 	//content : contentString
    // });
    // info.open(map, marker);

    /* -----------------------  Gestures and Events  ----------------------- */
    // $('html').bind('gestureend', function(event) {
    // 	info.close();
    //  });
    
    var listener = map.addListener('click',function (event) {
        console.log(map.getView().fromLatLng(event.latLng), +' '+
		   event.latLng);
    });

    // var listener2 = marker.addListener('mouseup', function (event) {
    // 	console.log("clicked");
    //     console.log(map._fromLatLng(event.latLng));
    // });

    /* -----------------------  Navigation  ----------------------- */
    var marker3 = new locuslabs.maps.Marker({
        position : new locuslabs.maps.LatLng(32.899044365968116,
                                             -97.04462256145348), 
        icon : { url :'images/pin.png' },
        map : map,
	draggable : true
    });
    var marker4 = new locuslabs.maps.Marker({
        position : new locuslabs.maps.LatLng(32.899044365968116,
                                             -97.04462256145348), 
        icon : { url :'images/pin.png' },
        map : map,
	draggable : true
    });
    var marker5 = new locuslabs.maps.Marker({
        position : new locuslabs.maps.LatLng(32.899044365968116,
                                             -97.04462256145348), 
        icon : { url :'images/pin-plane-takeoff.png' },
        map : map,
    	draggable : true
    });

    var navCallback = function() {
	var route1 = [];
	
	var s = { latLng : marker3.getPosition() };
	var t = { latLng : marker4.getPosition() };
	var d = { latLng : marker5.getPosition() };
	var navigationPath1 = _airport.navigate(s,[t, d]);
	$.each(navigationPath1.waypoints,function (i,waypoint) {
            route1.push(waypoint.latLng);
        });
        

	if ((typeof polyline1 != 'undefined')) { polyline1.setMap(null); }
	polyline1 = new locuslabs.maps.Polyline({
            map : map,
            path : route1,
            strokeColor : "blue",
            strokeWeight : 10,
            strokeOpacity : 0.5
	});
    };
    var listener3 = marker3.addListener('dragend', function() {
	cl.call(console, 'start');
	navCallback();
    });

    var listener4 = marker4.addListener('dragend', function() {
	cl.call(console, 'middle');
	navCallback();
    });
    var listener5 = marker5.addListener('dragend', function() {
    	cl.call(console, 'end');
    	navCallback();
    });


}






function floor_loaded(_floor)
{
    floor = _floor;
    console.log("floor_loaded");
    floor.loadMap(document.getElementById('map-canvas'),map_loaded);
}

function building_loaded(building)
{
    building.listFloors(function (floors) {
        console.log(floors);
        building.loadFloor(floors[1].floorId,floor_loaded);
    });
}

function airport_loaded(airport)
{
    _airport = airport;
    console.log(airport);
    airport.listBuildings(function (buildings) {
        console.log(buildings);
        airport.loadBuilding(buildings[0].buildingId,building_loaded);
    });
}

$(document).ready(function () {
    locuslabs.setup({},function () {
        airportDatabase = new locuslabs.maps.AirportDatabase();
        airportDatabase.listAirports(function (airports) {
            console.log(airports);
            airportDatabase.loadAirport('mia',airport_loaded);
        });
    });
});
