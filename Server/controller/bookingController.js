const Showtime = require("../model/showtimeModel")
const catchAsync = require("../utils/catchAsync")
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY)

exports.getCheckout1 = catchAsync(async (req, res, next) => {
  const showtime = await Showtime.findById(req.params.showtimeId).populate({ path: 'movie cinema', select: 'title price name' })
  const session = await stripe.checkout.sessions.create({
    payment_method_types: ['card'],
    customer_email: req.user.email,
    success_url: `${req.protocol}://${req.get('host')}/`,
    cancel_url: `${req.protocol}://${req.get('host')}/`,
    client_reference_id: req.params.showtimeId,
    line_items: [
      {
        price_data: {
          currency: 'vnd',
          product_data: {
            name: `${showtime.movie.title}`,
          },
          unit_amount: showtime.movie.price * 100 ,
        },
        quantity: req.params.seats,
      }
    ],
    mode: 'payment'
  })

  res.status(200).json({
    status: 'success',
    session
  })
})
exports.getCheckout = catchAsync(async (req, res, next) => {
  const showtime = await Showtime.findById(req.params.showtimeId).populate({ path: 'movie cinema', select: 'title price name' })
  // Create payment intent
  const paymentIntent = await stripe.paymentIntents.create({
    amount: showtime.movie.price * req.params.seats,
    currency: "vnd",
    automatic_payment_methods: {
      enabled: true
    }
  })
  // Return the secret
  res.status(200).json({paymentIntent: paymentIntent.client_secret})
})