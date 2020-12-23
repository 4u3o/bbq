'use static'

ymaps.ready(init);

function init(){
  var map;

  ymaps.geolocation.get().then(function (res) {
    const mapContainer = document.getElementById('map'),
      bounds = res.geoObjects.get(0).properties.get('boundedBy'),
      mapState = ymaps.util.bounds.getCenterAndZoom(
        bounds,
        [mapContainer.offsetWidth, mapContainer.offsetHeight]
      ),
      address = document.getElementById('map').dataset.address;

    createMap(mapState);

    ymaps.geocode(address, {
      boundedBy: map.getBounds(),
      results: 1
    }).then(function (res) {
      if (res.geoObjects.get(0)) {
        var firstGeoObject = res.geoObjects.get(0),
          coords = firstGeoObject.geometry.getCoordinates();

        firstGeoObject.options.set('preset', 'islands#darkBlueDotIconWithCaption');
        firstGeoObject.properties.set('iconCaption', firstGeoObject.getAddressLine());

        map.setCenter(coords);

        map.geoObjects.add(firstGeoObject);
      } else {
        map.hint.open(map.getCenter(), "Не смогли найти такое место");
      };
    });
  }, function (e) {
    createMap({
      center: [55.751574, 37.573856],
      zoom: 2
    });
  });

  function createMap (state) {
    map = new ymaps.Map('map', state);
  };
}
