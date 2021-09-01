import * as turf from '@turf/turf';
import {initSweetAlert} from './init_sweetalert';


const initUserLocation = () => {
  if (document.querySelector(".show-head")) {
    navigator.geolocation.getCurrentPosition((userLocation) => {
      const currentLat = userLocation.coords.latitude;
      const currentLong = userLocation.coords.longitude;
      const spot = document.querySelector("#spot-name");
      const spotCoords = [parseFloat(spot.dataset.lat), parseFloat(spot.dataset.long)]
      const from = turf.point([currentLat, currentLong])
      const to = turf.point(spotCoords)
      const distance = turf.distance(from, to)


      if (distance >= 0.5) {
        initSweetAlert()
      }
    });
  }
}

export { initUserLocation };
