const Ticket = require("../model/ticketModel");
const factory = require("./handleFactory");
const catchAsync = require("../utils/catchAsync");
const Showtime = require("../model/showtimeModel");
const AppError = require("../utils/appError");
const SeatLogs = require("../model/seatLogs");
const User = require("../model/userModel");
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

exports.createTicket = catchAsync(async function (req, res, next) {
  const ticket = await Ticket.create({
    showtime: req.body.showtime,
    user: req.body.user,
    movie: req.body.movie,
    seat_number: req.body.seat_number,
  });
  res.status(201).json({
    status: "success",
    data: ticket,
  });
});
exports.getAllTickets = factory.getAll(Ticket);
exports.getTicket = factory.getOne(Ticket, {
  path: "showtime",
  populate: [
    {
      path: "room",
      model: "Room",
      select: "name",
      populate: { path: "cinema", model: "Cinema", select: "name" },
    },
    { path: "movie", model: "Movie", select: "title imageCover" },
  ],
});
exports.deleteTicket = factory.deleteOne(Ticket);
exports.updateTicket = factory.updateOne(Ticket);

exports.getShowtime = catchAsync(async (req, res, next) => {
  req.showtime = await Showtime.findById(req.params.showtimeId).populate(
    "room movie",
    "cinema name title imageCover"
  );
  next();
});
exports.getTicketFromOneUser = catchAsync(async (req, res, next) => {
  const user = req.user.id;
  const tickets = await Ticket.find({ user });
  res.status(200).json({
    status: "success",
    data: {
      tickets,
    },
  });
});
exports.seatsCheck = catchAsync(async (req, res, next) => {
  const arrSeats = req.body.seats;
  const seats = await SeatLogs.find({
    seat_number: { $in: arrSeats },
    showtime: req.showtime._id,
    user: req.user.id,
  });
  const seats_in_db = seats.map((item) => item.seat_number);
  if (arrSeats.length != seats_in_db.length) {
    return next(
      new AppError(`Your seats in this showtime are: ${seats_in_db}`, 400)
    );
  }
  next();
});
exports.checkOut = catchAsync(async (req, res, next) => {
  // Create payment intent
  // check voucher
  var amount;
  amount = req.showtime.price * req.body.seats.length;
  console.log(amount);

  const paymentIntent = await stripe.paymentIntents.create({
    amount,
    currency: "vnd",
    automatic_payment_methods: {
      enabled: true,
    },
    metadata: {
      name: req.user.username,
    },
  });
  // Return the secret
  res.status(200).json({
    status: "success",
    paymentIntent: paymentIntent.client_secret,
  });
});
exports.createTicketCheckout = catchAsync(async (req, res, next) => {
  const showtime = req.showtime;
  const { seat_number } = req.body;

  if (!req.user.id || !showtime || !seat_number)
    return next(
      new AppError("Don't have enough fields to create a ticket"),
      400
    );

  const ticket = Ticket.create({
    user: req.user.id,
    showtime: showtime._id,
    seats: seat_number,
  });
  res.status(201).json({
    status: "success",
    data: await ticket,
  });
});
exports.ThongKeVeTheoThangNam = catchAsync(async function (req, res, next) {
  const query = await Ticket.aggregate([
    {
      $match: {
        $expr: {
          $and: [
            { $eq: [{ $month: "$booking_time" }, parseInt(req.query.month)] },
            { $eq: [{ $year: "$booking_time" }, parseInt(req.query.year)] },
          ],
        },
      },
    },
  ]);
  const results = await Ticket.populate(query, "showtime");
  const priceArr = results.map((item) => item.showtime.price);
  res.json({
    status: "success",
    so_luong_ve: results.length,
    tong_tien: priceArr.reduce(
      (accumulator, currentValue) => accumulator + currentValue,
      0
    ),
  });
});
exports.ThongKeVeTheoNam = catchAsync(async (req, res, next) => {
  res.json({
    data: await Ticket.calculatePriceYearly(req.query.year),
  });
});
