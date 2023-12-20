const express = require('express');
const catchAsync = require('../utils/catchAsync');
const router = express.Router()
const authCOntroller = require('./../controller/authController')
const bookingController = require('./../controller/bookingController')

router.get('/checkout/:showtimeId/:seats', authCOntroller.protect, bookingController.getCheckout)
module.exports = router