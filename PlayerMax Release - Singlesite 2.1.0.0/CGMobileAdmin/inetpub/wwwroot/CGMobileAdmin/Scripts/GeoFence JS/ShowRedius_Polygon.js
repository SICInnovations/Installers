

// declare variables that will be used in this example
var myMap;                  // holds the map object drawn on the 
var myDrawingManager;       // holds drawing tools
var myField;                // holds the polygon we draw using drawing tools
var myInfoWindow;           // when our polygon is clicked, a dialog box 
// will open up. This variable holds that info
var centerpoint;            // center point of the map
var fusionTablesLayer;      // fusion-tables layer
var myPoint;                // point marker

var myObject;
var myWin;
var polygon;
var cords;
var pointsData = new Array();
var zoomLevel = 7;
var circle;
var radius;
var isRadius = 0;
var OverlayType = [];
function SetCenterPoint(lat, long) {
    
    if (lat != '' && long != '') {
        centerpoint = new google.maps.LatLng(lat, long);
        zoomLevel = 13;
    }
    else {
        zoomLevel = 13;
        var centerpointlatlong = document.getElementById('MainContent_hdnDefaultMapLatLong').value;
        var xy = centerpointlatlong.split(",");
        centerpoint = new google.maps.LatLng(xy[0], xy[1]);
    }
}

function DrawPolygon(mapData1) {
    cords = [];
    if (mapData1 != '') {
        
        if (mapData1.indexOf("~") > 0) {
          
            pointsData = mapData1.split('~');           
            var len = pointsData.length;
            for (var i = 0; i <= len - 1; i++) {
                if (i < len - 1) {
                    cords = [];
                    var polygonlatlong = pointsData[i].split(" ");
                    if (polygonlatlong != '') {
                        for (var x = 0; x <= polygonlatlong.length - 1; x++) {
                            if (polygonlatlong != '') {
                                if (x < polygonlatlong.length - 1) {
                                    var xy = polygonlatlong[x].split(',');

                                    if (xy != '') {
                                        if (x == 0)
                                            centerpoint = new google.maps.LatLng(xy[0], xy[1]);

                                        var pt = new google.maps.LatLng(xy[0], xy[1]);
                                        cords.push(pt);
                                    }
                                }
                            }

                        }
                        isRadius = 0;
                        myObject = new Array();
                        drawPolygon_Radius(false);
                        
                    }
                }


            }
        }
        else {
            pointsData = mapData1.split(' ');
            var len = pointsData.length;
            for (var i = 0; i <= len - 1; i++) {
                if (i < len - 1) {
                    var xy = pointsData[i].split(",");
                    var pt = new google.maps.LatLng(xy[0], xy[1]);
                    cords.push(pt);
                }
            }
            isRadius = 0;
            myObject = new Array();
            drawPolygon_Radius(false);
        }
    }
}
function DrawRadius(mapData1, radiusData) {
    cords = [];

          
    if (mapData1 != '') {

        pointsData = mapData1.split(' ');
        var radiuskm = radiusData.split(',');
       
        var len = pointsData.length;
        for (var i = 0; i <= len - 1; i++) {
            if (i < len - 1) {

                if (radiuskm[i]!='')
                    radius = radiuskm[i];

                var xy = pointsData[i].split(",");
                if (xy!='')
                    centerpoint = new google.maps.LatLng(xy[0], xy[1]);
                isRadius = 1;
                myObject = new Array();
                drawPolygon_Radius(false);
            }
        }
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
    var mapOptions = {
        zoom: zoomLevel,
        center: centerpoint
    };

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

    // show fusion tables layer
    //ShowFusionTables();
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
        drawingControl: false,
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
    if (isRadius != 1)
        FieldPolygonDrawingCompletionListener();
    else
        FieldRadiusDrawingCompletionListener()

    // when point drawing is complete, an event is raised by the map
    // this function will listen to the event and work appropriately
    PointDrawingCompletionListener();
}

function drawPolygon_Radius(val) {

    //if (myObject == undefined) {
    //    myObject = new Array();
    //}
    myWin = null;
    if (isRadius != 1) {
       
        polygon = new google.maps.Polygon({
            center: centerpoint,
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
    }
    else {

        circle = new google.maps.Circle({
            center: centerpoint,
            radius:parseFloat( radius),
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
    }
  
    myWin = myObject[myObject.length - 1];
    myWin.setMap(myMap);

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

}
function GetPolygonCoordinates(polygon) {
    if (isRadius != 1) {
        var latlong = "";
        var coordinates = polygon.getPath().getArray();
        for (var i = 0; i < coordinates.length; i++) {

            if (i != coordinates.length - 1)
                latlong += coordinates[i].lat() + ', ' + coordinates[i].lng() + '~';
            else
                latlong += coordinates[i].lat() + ', ' + coordinates[i].lng();
        }
        document.getElementById("MainContent_hdnCoordinates").value = '';
        document.getElementById("MainContent_hdnCoordinates").value = latlong;
    }
}

function GetRadiusCoordinates(circle) {
    if (isRadius == 1) {
        var latlong = "";
        var coordinates = circle.getCenter();
        radius = circle.getRadius();
        latlong = coordinates.lat() + ', ' + coordinates.lng();
        document.getElementById("MainContent_hdnCoordinates").value = '';
        document.getElementById("MainContent_hdnCoordinates").value = latlong;
        document.getElementById("MainContent_hdnRadius").value = '';
        document.getElementById("MainContent_hdnRadius").value = radius;

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

    if (isRadius != 1) {

        coordinates = polygon.getPath().getArray();

        for (var i = 0; i < coordinates.length; i++) {
            if (i != coordinates.length - 1)
                latlong += coordinates[i].lat() + ', ' + coordinates[i].lng() + '~';
            else
                latlong += coordinates[i].lat() + ', ' + coordinates[i].lng();
        }
    }
    else {

        coordinates = polygon.getCenter();
        radius = polygon.getRadius();
        latlong = coordinates.lat() + ', ' + coordinates.lng();

    }
    message += '<div style="width:120px;" class="btn-groupSpecial clearfix" align="center" ><p><a href="#"  onclick="PolygonEditable(true); ">Edit</a>&nbsp;'
        + '<a href="#"  onclick="PolygonEditable(false);">Done</a>&nbsp;'
        + '<a href="#"    onclick="DeleteField(myField)">Delete</a>'
        + '</p></div>';

    document.getElementById("MainContent_hdnCoordinates").value = '';
    document.getElementById("MainContent_hdnCoordinates").value = latlong;
    document.getElementById("MainContent_hdnRadius").value = '';
    document.getElementById("MainContent_hdnRadius").value = radius;


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

