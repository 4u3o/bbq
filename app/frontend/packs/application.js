require("@rails/ujs").start()

import '../styles/application'

import 'bootstrap/dist/js/bootstrap'
import 'jquery/src/jquery'
import 'ekko-lightbox/ekko-lightbox'
import 'air-datepicker/dist/js/datepicker.min'

import '../scripts/map'
import '../scripts/lightbox'
import '../scripts/air_timepicker'

const images = require.context('../images', true)
