const express = require('express');
const cinemaController = require('./../controller/cinemaController')
const router = express.Router()

router.route('/').get(cinemaController.getCinema).get(cinemaController.getAllCinemas).post(cinemaController.createCinema)
router.route('/:id').get(cinemaController.getCinema)
router.route('/cinema-within/:distance/center/:latlng').get(cinemaController.getCinemasWithin)
router.route('/distances/:latlng').get(cinemaController.getDistance)

module.exports = router