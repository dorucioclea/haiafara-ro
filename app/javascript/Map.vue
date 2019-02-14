<template>
  <div id="map"></div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import L from 'leaflet'
  import 'leaflet/dist/leaflet.css'

  export default {
    data() {
      return {
        map: null
      }
    },
    mounted() {
      this.$nextTick(function () {
        var customControl = L.Control.extend({
          options: {
          position: 'topright'
          },
          onAdd: function (map) {
            var container = L.DomUtil.create('div', 'leaflet-bar leaflet-control leaflet-control-custom')

            container.style.backgroundColor = 'white'
            container.style.width = '40px'
            container.style.height = '30px'
            container.style.padding = '5px'
            container.style.cursor = 'pointer'
            container.style.textAlign = 'center'
            container.innerHTML = 'Info'

            container.onclick = function() {
              eventBus.$emit('toggleInfoPanel')
            }

            return container;
          }
        });
        this.map = L.map('map', { maxZoom: 20, trackResize: true })
        var tileLayer = L.tileLayer("//tileserver.haiafara.ro/hot/{z}/{x}/{y}.png", {
          attribution: '&copy; Contribuitori <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
          maxZoom: 20
        });
        tileLayer.addTo(this.map)
        this.map.addControl(new customControl())
      })
    },
    created() {
      eventBus.$on('mapInvalidateSize', () => {
        this.map.invalidateSize(true)
      })
      eventBus.$on('mapSetView', (coordinates, zoom) => {
        this.map.setView(coordinates, zoom)
      })
      eventBus.$on('mapFitBounds', (bounds) => {
        this.map.fitBounds(bounds)
      })
    }
  }
</script>

<style>
  #map {
    z-index: 0;
    width: 100%;
    height: 100%;
  }
</style>