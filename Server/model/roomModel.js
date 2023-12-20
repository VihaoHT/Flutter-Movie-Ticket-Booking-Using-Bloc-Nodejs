const mongoose = require('mongoose')

const roomSchema = new mongoose.Schema({
  cinema: {
      type: mongoose.Schema.ObjectId,
      ref: 'Cinema'
  },
  name: String
})

const Room = mongoose.model('Room', roomSchema)
module.exports = Room