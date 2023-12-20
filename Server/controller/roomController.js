const Ticket = require('../model/ticketModel')
const factory = require('./handleFactory');
const catchAsync = require('../utils/catchAsync');
const AppError = require('../utils/appError');
const Cinema = require('../model/cinemaModel')
const Room = require('../model/roomModel')


exports.createRoom = factory.createOne(Room)
exports.getAllRooms = factory.getAll(Room, 'cinema')
exports.getRoom = factory.getOne(Room)
exports.deleteRoom = factory.deleteOne(Room)
exports.updateRoom = factory.updateOne(Room)



