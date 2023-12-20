var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var usersRouter = require('./router/userRouter');
const productRouter = require('./router/movieRouter')
const cinemaRouter = require('./router/cinemaRouter')
const ticketRouter = require('./router/ticketRouter')
const paymentRouter = require('./router/paymentRouter')
const reviewRouter = require('./router/reviewRouter')
const showtimeRouter = require('./router/showtimeRouter')
const bookingRouter = require('./router/bookingRouter')
const actorRouter = require('./router/actorRouter')
const adminRouter = require('./router/adminRouter');
var exphbs = require('express-handlebars');


const globalErrorHandler = require('./controller/errorController');
const AppError = require('./utils/appError');
const SeatLogs = require('./model/seatLogs');


const app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

const hbs = exphbs.create({
  defaultLayout: "layout",
  extname: '.hbs',
  partialsDir: path.join(__dirname, 'views/partials/'),
});
app.engine("hbs", hbs.engine);
app.set("view engine", "hbs");
app.get('/api/users/reset-password/:token', (req, res, next) => {
  const currentUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
  res.render('ResetPassword', { token: req.params.token, currentUrl })
})

app.get('/api/logs', async(req, res, next) => {
  try{
    res.status(200).json({
      status: 'success',
      seat_logs: await SeatLogs.find(req.query)
    })
  } catch(err){
    res.status(400).json({
      status: 'failed',
      message: err.message
    })
  }
})
app.use('/api/showtimes', showtimeRouter)
app.use('/api/movies', productRouter)
app.use('/api/users', usersRouter)
app.use('/api/reviews', reviewRouter)
app.use('/api/cinemas', cinemaRouter)
app.use('/api/tickets', ticketRouter)
app.use('/api/payments', paymentRouter)
app.use('/api/bookings', bookingRouter)
app.use('/api/actors', actorRouter)
app.use('/api/rooms', require('./router/roomRouter'))
// error handler
app.use('/', adminRouter);

app.all('*', (req, res, next) => {
  next(new AppError(`Can't find ${req.originalUrl} on this server!`, 404));
});
app.use(globalErrorHandler)


module.exports = app;
