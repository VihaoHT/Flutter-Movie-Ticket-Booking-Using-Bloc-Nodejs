const mongoose = require('mongoose')

const actorSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Actor name must be provided'],
    unique: true
  },
  dob: Date,
  country: String,
  avatar: String
})
const Actor = mongoose.model('Actor', actorSchema)
module.exports = Actor