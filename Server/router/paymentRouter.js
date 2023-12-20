const express = require('express');
const catchAsync = require('../utils/catchAsync');
const router = express.Router()
const stripe = require('stripe')('sk_test_51NBvkEFht8KJ0hQJX5uWn1f9i7d1vSR40FBj5YiuOHRzlRAsEEld8Dq8tA9aR1GErLu2XpyvUediGPJRRNEg24sG00ZtTnUYyu')

router.post('/intents',catchAsync(async (req, res) => {
  const showtime = await Showtime.findById(req.params.showtimeId).populate({ path: 'movie cinema', select: 'title price name' })
  // Create payment intent
  const paymentIntent = await stripe.paymentIntents.create({
    amount: showtime.movie.id * req.params.seats,
    currency: "vnd",
    automatic_payment_methods: {
      enabled: true
    }
  })
  // Return the secret
  res.status(200).json({paymentIntent: paymentIntent.client_secret})
}))
module.exports = router