// review / rating / createdAt / ref to movie / ref to user
const mongoose = require('mongoose')
const Movie = require('./movieModel')

const currentTimestamp = Date.now(); 
const offsetHours = 7; 
const date = new Date(currentTimestamp + offsetHours * 60 * 60 * 1000);
const reviewSchema = new mongoose.Schema({
  review: {
    type: String,
    required: [true, "Binh luan khong duoc de trong"]
  },
  rating: {
    type: Number,
    required: [true, 'Rating must be provided'],
    min: 1,
    max: 5
  },
  created_At: {
    type: Date,
    default: date.toLocaleString()
  },
  movie: {
    type: mongoose.Types.ObjectId,
    ref: 'Movie',
    required: [true, "Review must belong to a movie"]
  },
  user: {
    type: mongoose.Types.ObjectId,
    ref: 'User',
    required: [true, "Review must belong to a user"],
  }
},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  }
)
reviewSchema.pre(/^find/, function(next) {
  // this.populate({
  //   path: 'movie',
  //   select: 'title'
  // })
  this.populate({
    path: 'user',
    select: 'username avatar'
  })
  next()
})
reviewSchema.statics.calcAvgRating = async function (movieId) {
  const stats = await this.aggregate([
    {
      $match: {movie: movieId}
    },
    {
      $group: {
        _id: '$movie',
        nRating: { $sum: 1},
        avgRating: { $avg: '$rating'}
      }
    }
  ])
  if(stats.length > 0){
    await Movie.findByIdAndUpdate(movieId, {
      ratingsQuantity: stats[0].nRating,
      ratingsAverage: stats[0].avgRating
    })
  }
  else {
    await Movie.findByIdAndUpdate(movieId, {
      ratingsQuantity: 0,
      ratingsAverage: 4.5
    })
  }
}
reviewSchema.post('save', function () {
  this.constructor.calcAvgRating(this.movie)
})
reviewSchema.pre(/^findOneAnd/, async function(next) {
  this.review = await this.findOne()
  next()
})
reviewSchema.post(/^findOneAnd/, async function() {
  this.constructor.calcAvgRating(this.review.movie)
})
const Review = mongoose.model('Review', reviewSchema)
module.exports = Review