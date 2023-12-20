const SeatLogs = require('./../model/seatLogs')
const factory = require('./handleFactory')

exports.createSeatLog = factory.createOne(SeatLogs)
exports.getAllSeatLogs = factory.getAll(SeatLogs, {path: 'user movie', select: 'username title'})
exports.deleteSeatLogs = factory.deleteOne(SeatLogs)
exports.updateSeatLogs = factory.updateOne(SeatLogs)

