require("@rails/ujs").start()

import 'bootstrap/dist/js/bootstrap'
import 'jquery/src/jquery'
import 'ekko-lightbox/ekko-lightbox'
import 'air-datepicker/dist/js/datepicker.min'

import '../scripts/map'
import '../scripts/lightbox'

import '../styles/application'

const images = require.context('../images', true)
