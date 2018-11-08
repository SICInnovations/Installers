

// declare variables that will be used in this example
var myMap;                  // holds the map object drawn on the 
var myDrawingManager;       // holds drawing tools
var myField;                // holds the polygon we draw using drawing tools
var myInfoWindow;           // when our polygon is clicked, a dialog box 
// will open up. This variable holds that info
var centerpoint;            // center point of the map
var fusionTablesLayer;      // fusion-tables layer
var myPoint;                // point marker
var mapOptions;
var myObject;
var myWin;
var polygon;
var cords;
var pointsData = new Array();
var zoomLevel = 13;
var circle;
var marker;
var isMarker=0;
var radius;
var places;
var isRadius = 0;
var isChangeRadiusAndPolygon = 0;
var input;
var searchBox;
var OverlayType = [];


function SetCenterPoint(lat, long)
{
    //zoomLevel = 12;
    if (lat != '' && long != '')
        centerpoint = new google.maps.LatLng(lat, long);
    else {
        var centerpointlatlong = document.getElementById('MainContent_hdnDefaultMapLatLong').value;
        var xy = centerpointlatlong.split(",");
        centerpoint = new google.maps.LatLng(xy[0], xy[1]);
    }
}

function DrawPolygon(mapData1) {
    cords = [];
    if (mapData1 != '') {

        pointsData = mapData1.split(' ');
        var len = pointsData.length;
        for (var i = 0; i <= len - 1; i++) {
            if (i < len - 1) {
                var xy = pointsData[i].split(",");
                var pt = new google.maps.LatLng(xy[0], xy[1]);
                cords.push(pt);
            }
        }

    }
}

function DrawRadius(mapData1,val) {
    cords = [];
    
    if (val != '')
        radius =parseFloat( val);
    if (mapData1 != '') {
        pointsData = mapData1.split(',');
        var pt = new google.maps.LatLng(pointsData[0], pointsData[1]);
        cords.push(pt);
    }
}

function IsRadius(val) {
    isRadius = val;
    if (val == 1)
        OverlayType = google.maps.drawing.OverlayType.CIRCLE;
    else
        OverlayType = google.maps.drawing.OverlayType.POLYGON;
}

/**
     * Initialization function that sets up the map
     */
function initialize() {

    // build the map's center poiint
    // assign map the options of zoom, center point and set the map to
    // SATELLITE

    //If Center point not is null
    if (centerpoint != '') {

        mapOptions =
            {
                zoom: zoomLevel,
                center: centerpoint
            };
    }
    else {

        var SetCenterpointOnMap = '';
        if (isChangeRadiusAndPolygon == 1)
            SetCenterpointOnMap = myMap.getCenter();
        else {
            var centerpointlatlong = document.getElementById('MainContent_hdnDefaultMapLatLong').value;
            var xy = centerpointlatlong.split(",");
            SetCenterpointOnMap = new google.maps.LatLng(xy[0], xy[1]);
            zoomLevel = 13;
        }

        mapOptions =
            {
                zoom: zoomLevel,
                center: SetCenterpointOnMap
            };
    }
    // on our web page should be a <div> or <p> tag with id map-canvas
    // show the map in that element with the options listed above
    myMap = new google.maps.Map(
        document.getElementById('map-canvas'),
        mapOptions
    );
     
    // create a dialog box but don't bind it to anything yet
    myInfoWindow = new google.maps.InfoWindow();

    // show drawing tools
    DrawingTools();

    if (isRadius !== 1) {
        if (document.getElementById('MainContent_hdnPolygonLatLong').value != '') {
            drawPolygon_Radius(false);
        }
    }
    else {
        if (document.getElementById('MainContent_hdnRadiusLatLong').value != '') {
            drawPolygon_Radius(false);
        }
    }



    ///**********************************AutoComplete Funcitonality Initialize here ******************************************

    // Bias the SearchBox results towards places that are within the bounds of the
    // current map's viewport.
    var bounds = 0;
    SearchboxBuilder();
    google.maps.event.addListener(myMap, 'bounds_changed', function () {
      
        bounds = myMap.getBounds();
        searchBox.setBounds(bounds);
    });


    ///Set zoom level onchange map.
    google.maps.event.addListener(myMap, 'zoom_changed', function () {        
        SetZoomLevel(this.getZoom());
    });
    function SetZoomLevel(level) {
        zoomLevel= level;       
    }

    ///**********************************AutoComplete Funcitonality Initialize close here ******************************************

}
function ReigsterPolygonAndRadious()
{
    isChangeRadiusAndPolygon = 1;
    SetMapDrawingType();
}
/**
 * Show fusion table layer
 * URL: https://www.google.com/fusiontables/DataSource?docid=1Hky8qXEOcJQmTbndHmrHWo8-yhRBLV3U31HwEg#rows:id=1
 * Notice that the field geometry contains the KML
 */
function ShowFusionTables() {
    layer = new google.maps.FusionTablesLayer({
        query: {
            select: 'geometry',
            from: '1Hky8qXEOcJQmTbndHmrHWo8-yhRBLV3U31HwEg'
        },
        styles: [{
            polygonOptions: {
                fillColor: '#fbefef',
                fillOpacity: 0.3
            }
        }]
    });
    layer.setMap(myMap);
}


/**
 * Show drawing tools
 */
function DrawingTools() {

    // drawingMode of NULL, which means that the map drawing tools will
    // have no default drawing tool selected. If drawingMode was set to 
    // google.maps.drawing.OverlayType.POLYGON, polygon would be auto-
    // selected
    // drawingModes can have multiple information. Over here we are adding
    // point (aka marker) and polygon capabilities.
    myDrawingManager = new google.maps.drawing.DrawingManager({
        drawingMode: null,
        drawingControl: true,
        drawingControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER,
            drawingModes: [
                OverlayType,
            ]
        },
        markerOptions: {
            icon: 'http://zedfox.us/projects/google-maps-demo/make-polygon-extended/waterdrop.png'
        },
        polygonOptions: {
            draggable: true,
            editable: true,
            fillColor: '#FF0000',
            fillOpacity: 0.5,
            strokeColor: '#FF0000',
        },
        circleOptions: {
            draggable: true,
            editable: true,
            fillColor: '#FF0000',
            fillOpacity: 0.5,
            strokeColor: '#FF0000',
        }
    });
    myDrawingManager.setMap(myMap);

    // when polygon drawing is complete, an event is raised by the map
    // this function will listen to the event and work appropriately
    if(isRadius!=1)
        FieldPolygonDrawingCompletionListener();
    else
        FieldRadiusDrawingCompletionListener()

    // when point drawing is complete, an event is raised by the map
    // this function will listen to the event and work appropriately
    PointDrawingCompletionListener();
}

function drawPolygon_Radius(val) {

    if (myObject == undefined) {
        myObject = new Array();
    }
    if (centerpoint == '' && document.getElementById('MainContent_hdnGeofencefocusLatLong').value!='') {
        var centerpointlatlong = document.getElementById('MainContent_hdnGeofencefocusLatLong').value;
        var xy = centerpointlatlong.split(",");
        centerpoint = new google.maps.LatLng(xy[0], xy[1]);
    }   
    myWin = null;
    if (isRadius != 1 && isMarker!=1)
    {
        polygon = new google.maps.Polygon({
            paths: cords,           
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
            editable: val,
            draggable: val
        });
        myObject.push(polygon);
        myField = polygon;

        myWin = myObject[myObject.length - 1];
        myWin.setMap(myMap);

        ShowDrawingTools(false);
        PolygonEditable(false);
        AddPropertyToField();
        FieldClickListener();
    }
    else if (isRadius == 1 && isMarker != 1) {
               
        circle = new google.maps.Circle({
            center: centerpoint,
            radius: radius,
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
            editable: val,
            draggable: val
        });
        myObject.push(circle);
        myField = circle;

        myWin = myObject[myObject.length - 1];
        myWin.setMap(myMap);

        ShowDrawingTools(false);
        PolygonEditable(false);
        AddPropertyToField();
        FieldClickListener();
    }
    else if (isMarker==1) {
       
        AddAndRemoveMarker();
    }
}

function AddAndRemoveMarker()
{
    if (myObject == undefined) {
        myObject = new Array();
    }

    if (isMarker == 1) {
        marker = new google.maps.Marker({
            position: centerpoint,

        });
        myObject.push(marker);
        myField = marker;

        myWin = myObject[myObject.length - 1];
        myWin.setMap(myMap);
        isMarker = 0;

        ShowDrawingTools(true);
        PolygonEditable(true);
        AddPropertyToField();
        FieldClickListener();

    }
   
}
/**
     * Show information box when a polygon is clicked
     */
function showInformation(event) {

    var message = GetMessage(this, false);
    myInfoWindow.setOptions({ content: message });
    myInfoWindow.setPosition(event.latLng);
    myInfoWindow.open(myMap);
}
/**
 * Using the drawing tools, when a polygon is drawn an event is raised. 
 * This function catches that event and hides the drawing tool. It also
 * makes the polygon non-draggable and non-editable. It adds custom 
 * properties to the polygon and generates a listener to listen to click
 * events on the created polygon
 */
function FieldPolygonDrawingCompletionListener() {
    // capture the field, set selector back to hand, remove drawing
    google.maps.event.addListener(
        myDrawingManager,
        'polygoncomplete',
        function (polygon) {
            myField = polygon;
            ShowDrawingTools(false);
            GetPolygonCoordinates(polygon);
            PolygonEditable(false);
            AddPropertyToField();
            FieldClickListener();
        }
    );

}
function FieldRadiusDrawingCompletionListener() {
    // capture the field, set selector back to hand, remove drawing
    google.maps.event.addListener(
        myDrawingManager,
        'circlecomplete',
        function (circle) {
            myField = circle;
            ShowDrawingTools(false);
            GetRadiusCoordinates(circle);
            PolygonEditable(false);
            AddPropertyToField();
            FieldClickListener();
        }
    );
  
}

/**
 * Using the drawing tools, when a point is drawn an event is raised. 
 * This function catches that event and hides the drawing tool. 
 * It generates a listener to listen to click events on the created point
 */
function PointDrawingCompletionListener() {
    // capture the point, set selector back to hand, remove drawing
    google.maps.event.addListener(
        myDrawingManager,
        'markercomplete',
        function (marker) {
            myPoint = marker;
            ShowDrawingTools(false);
            PointClickListener();

        }
    );
}

/**
 * Show or hide drawing tools
 */
function ShowDrawingTools(val) {
    myDrawingManager.setOptions({
        drawingMode: null,
        drawingControl: val
    });
    AddAndRemoveMarker();
}
function GetPolygonCoordinates(polygon) {
    if (isRadius != 1) {
        var latlong = "";
        if (polygon != null) {
            var coordinates = polygon.getPath().getArray();
            for (var i = 0; i < coordinates.length; i++) {

                if (i != coordinates.length - 1)
                    latlong += coordinates[i].lat() + ', ' + coordinates[i].lng() + '~';
                else
                    latlong += coordinates[i].lat() + ', ' + coordinates[i].lng();
            }
            document.getElementById("MainContent_hdnCoordinates").value = '';
            document.getElementById("MainContent_hdnCoordinates").value = latlong;
            document.getElementById("MainContent_hdnRadius").value = '';
        }
    }
    
}

function GetRadiusCoordinates(circle) {
    if (isRadius == 1) {
        var latlong = "";
        try {
            if (circle != '' && circle != null) {
                var coordinates = circle.getCenter();
                radius = circle.getRadius();
                latlong = coordinates.lat() + ', ' + coordinates.lng();
                document.getElementById("MainContent_hdnCoordinates").value = '';
                document.getElementById("MainContent_hdnCoordinates").value = latlong;
                document.getElementById("MainContent_hdnRadius").value = '';
                document.getElementById("MainContent_hdnRadius").value = radius;
            }
        } catch (e) {}
    }
}
/**
 * Get coordinates of the polygon and display information that should 
 * appear in the polygon's dialog box when it is clicked
 */


function GetMessage(polygon) {

    var coordinates;
    var message = '';
    var latlong = "";
    
    if (isRadius != 1)
    {
       
        coordinates = polygon.getPath().getArray();

        for (var i = 0; i < coordinates.length; i++) {
            if (i != coordinates.length - 1)
                latlong += coordinates[i].lat() + ', ' + coordinates[i].lng() + '~';
            else
                latlong += coordinates[i].lat() + ', ' + coordinates[i].lng();
        }
        document.getElementById("MainContent_hdnRadius").value = '';
    }
    else
    {
      
        coordinates = polygon.getCenter();
        radius = polygon.getRadius();
        latlong = coordinates.lat() + ', ' + coordinates.lng();
        document.getElementById("MainContent_hdnRadius").value = '';
        document.getElementById("MainContent_hdnRadius").value = radius;
    }
    message += '<div style="width:120px;" class="btn-groupSpecial clearfix" align="center" ><p><a href="#"  onclick="PolygonEditable(true); ">Edit</a>&nbsp;'
        + '<a href="#"  onclick="PolygonEditable(false);">Done</a>&nbsp;'
        + '<a href="#"    onclick="DeleteField(myField)">Delete</a>'
        + '</p></div>';

    document.getElementById("MainContent_hdnCoordinates").value = '';
    document.getElementById("MainContent_hdnCoordinates").value = latlong;   
   
    return message;
}
/**
 * Allow or disallow polygon to be editable and draggable 
 */
function PolygonEditable(val) {

    myField.setOptions({
        editable: val,
        draggable: val
    });
    myInfoWindow.close();
    return false;
}

/**
 * Add custom property to the polygon
 */
function AddPropertyToField() {
    var obj = {
        'id': 5,
        'grower': 'B',
        'farm': 'Dream Farm'
    };
    myField.objInfo = obj;
}

/**
 * Attach an event listener to the polygon. When a user clicks on the 
 * polygon, get a formatted message that contains links to re-edit the 
 * polygon, mark the polygon as complete, or delete the polygon. The message
 * appears as a dialog box
 */
function FieldClickListener() {
    google.maps.event.addListener(
        myField,
        'click',
        function (event) {
            var message = GetMessage(myField);
            GetPolygonCoordinates(myField);
            GetRadiusCoordinates(myField);
            myInfoWindow.setOptions({ content: message });
            myInfoWindow.setPosition(event.latLng);
            myInfoWindow.open(myMap);
        }
    );

  
}

/**
 * Attach an event listener to the point. When a user clicks on the 
 * point, get a formatted message that contains link to delete the 
 * point. The message appears as a dialog box
 */
function PointClickListener() {
    google.maps.event.addListener(
        myPoint,
        'click',
        function (event) {
            var message = GetMessagePoint(myPoint);
            GetPolygonCoordinates(myPoint);
            GetRadiusCoordinates(myPoint);
            myInfoWindow.setOptions({ content: message });
            myInfoWindow.setPosition(event.latLng);
            myInfoWindow.open(myMap);
        }
    );

}

/**
 * Delete the polygon and show the drawing tools so that new polygon can be
 * created
 */
function DeleteField() {
    myInfoWindow.close();
    if (myField != null && myField != undefined) {
        myField.setMap(null);
    }//
    if (myWin != null && myWin != undefined) {
        myWin.setMap(null);
    }
    ShowDrawingTools(true);
}

/**
 * Delete the ppoint and show the drawing tools so that new items can be
 * created
 */
function DeletePoint() {
    
    if (myPoint != null && myPoint != undefined) {
        myPoint.setMap(null);
    }

    if (myWin != null && myWin != undefined) {
        myWin.setMap(null);
        myObject = null;
    }
    myInfoWindow.close();
    ShowDrawingTools(true);
}



/**
 * Get lat/lon of the point and display information that should 
 * appear in the point's dialog box when it is clicked
 */
function GetMessagePoint(marker) {
    var message =
        '<p style="color:#000">'
        + 'This point is drawn at position '
        + myPoint.getPosition().lat() + ', '
        + myPoint.getPosition().lng() + '</p>'
        + '<p>'
        + '<a href="#" onclick="DeletePoint(myPoint)">Delete</a></p>';
    return message;
}

/**
 * Get area of the drawn polygon
 */
function GetArea(poly) {
    var result = parseFloat(google.maps.geometry.spherical.computeArea(poly.getPath())) * 0.000247105;
    return result.toFixed(4);
}




//******************************************AutoComplete common funcitons **********************************

function SearchboxBuilder() {
    // Create the search box and link it to the UI element.
    input = document.getElementById('MainContent_txtSearchLatLongMap');
    //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
    searchBox = new google.maps.places.SearchBox(input);

    // Listen for the event fired when the user selects an item from the
    // pick list. Retrieve the matching places for that item.
    google.maps.event.addListener(searchBox, 'places_changed', function () {
        try {
            var place = searchBox.getPlaces()[0];
            if (!place.geometry) return;
            // If the place has a geometry, then present it on a map.
            if (place.geometry.viewport) {
                myMap.fitBounds(place.geometry.viewport);
                // myMap.setZoom(zoomLevel);
            } else {
                myMap.setCenter(place.geometry.location);
                //myMap.setZoom(zoomLevel);
            }       
            DeleteField();
            isMarker = 1;
            centerpoint = place.geometry.location;
            AddAndRemoveMarker();
        } catch (e) {}
    });
}

google.maps.event.addDomListener(window, 'load', SearchboxBuilder);

//******************************************AutoComplete common funcitons **********************************