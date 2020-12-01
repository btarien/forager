import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};
const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    const coordinates = JSON.parse(mapElement.dataset.coordinates);
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: [coordinates[1],coordinates[0]], // starting position [lng, lat]
      zoom: 12
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup()
      if(marker.infoWindow) {
        popup.setHTML(marker.infoWindow);
      }
      let mapMarker
      if(marker.imageUrl) {
        const element = document.createElement('div');
        element.className = 'marker';
        element.style.backgroundImage = `url('${marker.imageUrl}')`;
        element.style.backgroundSize = 'contain';
        element.style.width = '25px';
        element.style.height = '25px';
        mapMarker = new mapboxgl.Marker(element)
      } else {
        mapMarker = new mapboxgl.Marker()
      }
      mapMarker
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
  
  }
};

export { initMapbox };
