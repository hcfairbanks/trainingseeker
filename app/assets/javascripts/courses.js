// http://ubilabs.github.io/geocomplete/jquery.geocomplete.js


function hide_me(div_id){
$( "#"+ div_id ).slideToggle( "fast", function() {
  if ( document.getElementById("searched").value == "true")
    {
      // TODO
      // This flow / logic needs to be moved to the controller
      document.getElementById("searched").value = "false";
      document.getElementById("start_date").value = "";
      document.getElementById("end_date").value = "";
      document.getElementById("min_price").value = "";
      document.getElementById("max_price").value = "";
      document.getElementById("availability").value = "";
      document.getElementById("order_by").selectedIndex = 0;
    }
  else
    { document.getElementById("searched").value = "true"; }
  });
}

function wireupDeleteButtons() {
    $('.delete_seat button').off('click');
    $('.delete_seat button').on('click', function(e) {
        e.preventDefault();
        $(e.currentTarget).closest('.seat_row').remove();
        var i = parseInt($('input#num_seats').val());
        i--;
        document.getElementById('num_seats').value = i;
        seatprice = document.getElementById('seatprice');
        seatcost = document.getElementById('seatcost');
        newseatcost = seatprice.value * i;
        seatcost.value = newseatcost;
    });
}

$(document).ready(function() {
    if ($('#error_explanation').length > 0) {
        $('#purchase_modal').modal('show');
    }
    wireupDeleteButtons();
});


  function createSeatRow(e){
    e.preventDefault();
    var i = parseInt($('input#num_seats').val());
    i++;
    var formData = $('#seats_form_data');
    var template = document.getElementById("template_seat_form_row");
    var templateHtml = template.innerHTML;
    var newRow = templateHtml.replace(/{{idx}}/g, i);
    formData.append(newRow);

    document.getElementById('num_seats').value = i;
    seatprice = document.getElementById('seatprice');
    seatcost = document.getElementById('seatcost');
    newseatcost = seatprice.value * i;
    seatcost.value = newseatcost;
    wireupDeleteButtons();
    return false;
  }


function preview(){
  //document.getElementById("image_uploader").value =""
  input = document.getElementById("course[avatar]");
  fReader = new FileReader();
  fReader.readAsDataURL(input.files[0]);
  fReader.onloadend = function(event){

    img = document.getElementById("preview_image");
    img.style.display = "block";

    document.getElementById("initial_course_avatar").style.display="none";
    img.src = event.target.result;
    // http://stackoverflow.com/questions/4851595/how-to-resolve-the-c-fakepath
    // https://blueimp.github.io/jQuery-File-Upload/index.html
  };
}



  var placeSearch, autocomplete;
  var componentForm = {
    locality: 'long_name',
    administrative_area_level_1: 'long_name'
  };

  var componentForm2 = {
    street_number: 'short_name',
    route: 'long_name',
    locality: 'long_name',
    administrative_area_level_1: 'long_name',
    postal_code: 'short_name'
  };





  function initAutocomplete() {
    // Create the autocomplete object, restricting the search to geographical
    // location types.
    autocomplete = new google.maps.places.Autocomplete(
        /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
        {types: ['geocode']});

    // When the user selects an address from the dropdown, populate the address
    // fields in the form.
    autocomplete.addListener('place_changed', fillInAddress);
  }

  function fillInAddress() {
    // Get the place details from the autocomplete object.
    var place = autocomplete.getPlace();

    for (var component in componentForm) {
      document.getElementById(component).value = '';
      // Might need to remove the next line
      document.getElementById(component).disabled = false;
    }
    // Get each component of the address from the place details
    // and fill the corresponding field on the form.
    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (componentForm[addressType]) {
        var val = place.address_components[i][componentForm[addressType]];
        document.getElementById(addressType).value = val;
      }
    }
  }

  // Bias the autocomplete object to the user's geographical location,
  // as supplied by the browser's 'navigator.geolocation' object.
  function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        var circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////s

  function initMap() {
    var myLatLng = {lat: 57.62111351020163, lng: -93.804110675};
    var map = new google.maps.Map(document.getElementById('map'), {
      center: myLatLng,
      zoom: 4,
      streetViewControl: false
    });
    var input = document.getElementById('pac-input');
    var autocomplete = new google.maps.places.Autocomplete(input);

    // Bind the map's bounds (viewport) property to the autocomplete object,
    // so that the autocomplete requests use the current map bounds for the
    // bounds option in the request.
    autocomplete.bindTo('bounds', map);

    var infowindow = new google.maps.InfoWindow();
    var infowindowContent = document.getElementById('infowindow-content');
    infowindow.setContent(infowindowContent);
    var marker = new google.maps.Marker({
      map: map,
      draggable:true,
      labelContent: "$425K",
      anchorPoint: new google.maps.Point(0, -29)
    });

    marker.addListener('dragend', function() {
      document.getElementById('course[latitude]').value = this.getPosition().lat();
      document.getElementById('course[longitude]').value = this.getPosition().lng();
      //map.setZoom(8);
      //map.setCenter(marker.getPosition());
    });

    autocomplete.addListener('place_changed', function() {
      infowindow.close();
      marker.setVisible(false);
      var place = autocomplete.getPlace();
      if (!place.geometry) {
        // User entered the name of a Place that was not suggested and
        // pressed the Enter key, or the Place Details request failed.
        window.alert("No details available for input: '" + place.name + "'");
        return;
      }

      // If the place has a geometry, then present it on a map.
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);  // Why 17? Because it looks good.
      }
      marker.setPosition(place.geometry.location);
      marker.setVisible(true);
      //alert(place.address_components[0].short_name);

      document.getElementById('course[latitude]').value = place.geometry.location.lat();
      document.getElementById('course[longitude]').value = place.geometry.location.lng();
      document.getElementById('course[avatar]').disabled = false;
      document.getElementById('course[availability]').disabled = false;
      document.getElementById('course[start_date]').disabled = false;
      document.getElementById('course[start_time]').disabled = false;
      document.getElementById('course[end_date]').disabled = false;
      document.getElementById('course[price]').disabled = false;
      document.getElementById('course[course_name]').disabled = false;


      for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];
        if (componentForm2[addressType]) {
          var val = place.address_components[i][componentForm2[addressType]];
          document.getElementById(addressType).value = val;
          document.getElementById(addressType).disabled = false;
        }
      }

      var address = '';
      if (place.address_components) {
      address = [
          (place.address_components[0] && place.address_components[0].short_name || ''),
          (place.address_components[1] && place.address_components[1].short_name || ''),
          (place.address_components[2] && place.address_components[2].short_name || '')
        ].join(' ');
      }

      infowindowContent.children['place-icon'].src = place.icon;
      infowindowContent.children['place-name'].textContent = place.name;
      infowindowContent.children['place-address'].textContent = address;
      infowindow.open(map, marker);
    });

  }


  var gmarkers = [];
  function initMap1() {
    var latitude = parseFloat(document.getElementById('course[latitude]').value);
    var longitude = parseFloat(document.getElementById('course[longitude]').value);
    var myLatLng = {lat: latitude, lng: longitude};

    var map = new google.maps.Map(document.getElementById('map'), {
      center: {lat:  latitude, lng:  longitude},
      zoom: 4,
      streetViewControl: false
    });

    var marker = new google.maps.Marker({
       draggable:true,
       position: myLatLng,
       map: map,
       title: 'Hello World!'
     });
     gmarkers.push(marker);

    gmarkers[0].addListener('dragend', function() {
       document.getElementById('course[latitude]').value = this.getPosition().lat();
       document.getElementById('course[longitude]').value = this.getPosition().lng();
    });



    var card = document.getElementById('pac-card');
    var input = document.getElementById('pac-input');
    var types = document.getElementById('type-selector');
    var strictBounds = document.getElementById('strict-bounds-selector');

    map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

    var autocomplete = new google.maps.places.Autocomplete(input);

    // Bind the map's bounds (viewport) property to the autocomplete object,
    // so that the autocomplete requests use the current map bounds for the
    // bounds option in the request.
    autocomplete.bindTo('bounds', map);

    var infowindow = new google.maps.InfoWindow();
    var infowindowContent = document.getElementById('infowindow-content');
    infowindow.setContent(infowindowContent);
    var marker = new google.maps.Marker({
      map: map,
      draggable:true,
      labelContent: "$425K",
      anchorPoint: new google.maps.Point(0, -29)
    });

    marker.addListener('dragend', function() {


    document.getElementById('course[latitude]').value = this.getPosition().lat();
    document.getElementById('course[longitude]').value = this.getPosition().lng();
      //map.setZoom(8);
      //map.setCenter(marker.getPosition());
    });

    autocomplete.addListener('place_changed', function() {
      infowindow.close();
      marker.setVisible(false);
      var place = autocomplete.getPlace();
      if (!place.geometry) {
        // User entered the name of a Place that was not suggested and
        // pressed the Enter key, or the Place Details request failed.
        window.alert("No details available for input: '" + place.name + "'");
        return;
      }

      // If the place has a geometry, then present it on a map.
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);  // Why 17? Because it looks good.
      }
      marker.setPosition(place.geometry.location);
      marker.setVisible(true);
      //alert(place.address_components[0].short_name);
      gmarkers[0].setMap(null);

      document.getElementById('course[latitude]').value = place.geometry.location.lat();
      document.getElementById('course[longitude]').value = place.geometry.location.lng();

      // TODO Clear out fields like postal, incase they dont get added in by google

      for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];
        if (componentForm2[addressType]) {
          var val = place.address_components[i][componentForm2[addressType]];
          document.getElementById(addressType).value = val;
        }
      }

      var address = '';
      if (place.address_components) {
      address = [
          (place.address_components[0] && place.address_components[0].short_name || ''),
          (place.address_components[1] && place.address_components[1].short_name || ''),
          (place.address_components[2] && place.address_components[2].short_name || '')
        ].join(' ');
      }

      infowindowContent.children['place-icon'].src = place.icon;
      infowindowContent.children['place-name'].textContent = place.name;
      infowindowContent.children['place-address'].textContent = address;
      infowindow.open(map, marker);
    });

  }

  var gmarkers = [];
  function initMap2() {
    var latitude = parseFloat(document.getElementById('course[latitude]').value);
    var longitude = parseFloat(document.getElementById('course[longitude]').value);
    var myLatLng = {lat: latitude, lng: longitude};

    var map = new google.maps.Map(document.getElementById('map'), {
      center: {lat:  latitude, lng:  longitude},
      zoom: 12,
      streetViewControl: false
    });

    var marker = new google.maps.Marker({
       draggable:true,
       position: myLatLng,
       map: map,
       title: 'Hello World!'
     });
     gmarkers.push(marker);

    gmarkers[0].addListener('dragend', function() {
       document.getElementById('course[latitude]').value = this.getPosition().lat();
       document.getElementById('course[longitude]').value = this.getPosition().lng();
    });



    var card = document.getElementById('pac-card');
    var input = document.getElementById('pac-input');
    var types = document.getElementById('type-selector');
    var strictBounds = document.getElementById('strict-bounds-selector');

    map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

    var autocomplete = new google.maps.places.Autocomplete(input);

    // Bind the map's bounds (viewport) property to the autocomplete object,
    // so that the autocomplete requests use the current map bounds for the
    // bounds option in the request.
    autocomplete.bindTo('bounds', map);

    var infowindow = new google.maps.InfoWindow();
    var infowindowContent = document.getElementById('infowindow-content');
    infowindow.setContent(infowindowContent);
    var marker = new google.maps.Marker({
      map: map,
      draggable:true,
      labelContent: "$425K",
      anchorPoint: new google.maps.Point(0, -29)
    });

    marker.addListener('dragend', function() {


    document.getElementById('course[latitude]').value = this.getPosition().lat();
    document.getElementById('course[longitude]').value = this.getPosition().lng();
      //map.setZoom(8);
      //map.setCenter(marker.getPosition());
    });

    autocomplete.addListener('place_changed', function() {
      infowindow.close();
      marker.setVisible(false);
      var place = autocomplete.getPlace();
      if (!place.geometry) {
        // User entered the name of a Place that was not suggested and
        // pressed the Enter key, or the Place Details request failed.
        window.alert("No details available for input: '" + place.name + "'");
        return;
      }

      // If the place has a geometry, then present it on a map.
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);  // Why 17? Because it looks good.
      }
      marker.setPosition(place.geometry.location);
      marker.setVisible(true);
      //alert(place.address_components[0].short_name);
      gmarkers[0].setMap(null);

      document.getElementById('course[latitude]').value = place.geometry.location.lat();
      document.getElementById('course[longitude]').value = place.geometry.location.lng();

      // TODO Clear out fields like postal, incase they dont get added in by google

      for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];
        if (componentForm2[addressType]) {
          var val = place.address_components[i][componentForm2[addressType]];
          document.getElementById(addressType).value = val;
        }
      }

      var address = '';
      if (place.address_components) {
      address = [
          (place.address_components[0] && place.address_components[0].short_name || ''),
          (place.address_components[1] && place.address_components[1].short_name || ''),
          (place.address_components[2] && place.address_components[2].short_name || '')
        ].join(' ');
      }

      infowindowContent.children['place-icon'].src = place.icon;
      infowindowContent.children['place-name'].textContent = place.name;
      infowindowContent.children['place-address'].textContent = address;
      infowindow.open(map, marker);
    });

  }
