const mongoose = require('mongoose')

const cinemaSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Cinemas name must be provided'],
    unique: true
  },
  location:{ 
    type: {
      type: String,
      default: 'Point',
      enum: ['Point']
    },
    coordinates: [Number], // [longtitude, latitude]
    address: String,
    description: String
  }
})
cinemaSchema.index({ location: '2dsphere' })
const Cinema = mongoose.model('Cinema', cinemaSchema)
module.exports = Cinema