const mongoose = require('mongoose')

const movieSchema = new mongoose.Schema({
  title: {
    type: String,
    required: [true, 'Movie title must be provided'],
    unique: true
  },
  category:{ 
    type: [String],
    required: [true, 'Movie genre must be provided .'],
    enum: {
    values: ['action', 'comedy', 'science-fiction', 'drama', 'fantasy', 'tragedy', ],
    message: 'Category phai la: action, comedy, science-fiction, drama, fantasy, tragedy'
  }},
  ratingsAverage: {
    type: Number,
    default: 4.5,
    min: [1, 'Rating must be above 1.0'],
    max: [5, 'Rating must be below 5.0'],
    set: val => Math.round(val * 10) / 10 // 4.666666, 46.6666, 47, 4.7
  },
  ratingsQuantity: {
    type: Number,
    default: 0
  },
  imageCover: {
    type: String
  },
  actor: {
    type: [mongoose.Types.ObjectId],
    ref: 'Actor'
  },
  trailer: String,
  duration: Number,
  release_date: Date,
  description: String,
  country: String,
  status:{
    type:Boolean,
    default:true
  }
},
{
  toJSON: { virtuals: true },

  toObject: { virtuals: true }
})
movieSchema.index({price: 1, ratingsAverage: -1})
movieSchema.virtual('reviews', {
  ref: 'Review',
  foreignField: 'movie',
  localField: '_id'
})

const Movie = mongoose.model('Movie', movieSchema)
module.exports = Movie