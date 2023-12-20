#!/usr/bin/env node

/**
 * Module dependencies.
 */

var app = require('./app');
var debug = require('debug')('server:server');
var http = require('http');
const mongoose = require('mongoose')
const dotenv = require('dotenv');
const { Server } = require('socket.io');
const SeatLogs = require('./model/seatLogs');
const catchAsync = require('./utils/catchAsync');

dotenv.config({ path: './config.env' });

// db connection
const DB = process.env.DATABASE.replace(
  '<PASSWORD>',
  process.env.DATABASE_PASSWORD
);

mongoose
  .connect(DB, {
    useNewUrlParser: true

  })
  .then(() => console.log('DB connection successful!'));


/**
 * Get port from environment and store in Express.
 */

var port = normalizePort(process.env.PORT || '3000');
app.set('port', port);

/**
 * Create HTTP server.
 */

var server = http.createServer(app);
const io = require("socket.io")(server, {
  cors: {
    origin: "*",
  }
});
io.on('connection', (socket) => {
  socket.on("showtime:list", async (data) => {
    try {
      const list = await SeatLogs.find({ showtime: data })
      socket.emit('seat_list', list);
    } catch (e) {
      console.log("list", e)
    }
  });
  socket.on('joinRoom', (room) => {
    socket.join(room);
    socket.on("showtime:modify", async (data) => {
      try {
        await SeatLogs.create({
          showtime: room,
          seat_number: data.seat_number,
          user: data.user,
          status: 'selected'
        })
        return socket.broadcast.to(room).emit('seat_changed', await SeatLogs.find({showtime: room}));
      } catch (e) {
        console.log("modify", e)
      }
    })
    socket.on("showtime:delete", async(data) => {
      try {
        await SeatLogs.findOneAndDelete({ showtime: room, seat_number: data.seatNumber })
        socket.broadcast.to(room).emit('seat_changed', await SeatLogs.find({ showtime: room }))
      } catch (e) {

      }
    })
    socket.on("showtime:reserved", async (data) => {
      try {
        await SeatLogs.updateMany({ showtime: room, user: data.user }, {
          status: "reserved"
        })
        return io.to(room).emit('seat_changed', await SeatLogs.find({ showtime: room }));
      } catch (e) {

      }
    })
  });
}
)


/**
 * Listen on provided port, on all network interfaces.
 */

server.listen(port);
server.on('error', onError);
server.on('listening', onListening);

/**
 * Normalize a port into a number, string, or false.
 */

function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}

/**
 * Event listener for HTTP server "error" event.
 */

function onError(error) {
  if (error.syscall !== 'listen') {
    throw error;
  }

  var bind = typeof port === 'string'
    ? 'Pipe ' + port
    : 'Port ' + port;

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case 'EACCES':
      console.error(bind + ' requires elevated privileges');
      process.exit(1);
      break;
    case 'EADDRINUSE':
      console.error(bind + ' is already in use');
      process.exit(1);
      break;
    default:
      throw error;
  }
}

/**
 * Event listener for HTTP server "listening" event.
 */

function onListening() {
  var addr = server.address();
  var bind = typeof addr === 'string'
    ? 'pipe ' + addr
    : 'port ' + addr.port;
  debug('Listening on ' + bind);
  console.log('Listening on ' + bind)
}
