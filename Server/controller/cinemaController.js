const catchAsync = require('../utils/catchAsync')
const Cinema = require('./../model/cinemaModel')
const factory = require('./handleFactory');


exports.createCinema = factory.createOne(Cinema)
exports.getAllCinemas = factory.getAll(Cinema)
exports.getCinema = catchAsync(async (req, res, next) => {
  if(!req.query.name) return next()
  const cinema = await Cinema.find({name: {$regex: req.query.name, $options: 'i'}})
  res.status(200).json({
    status: 'success',
    data: {
      data: cinema
    }
  })
})

exports.getCinemasWithin = catchAsync(async (req, res, next) => {
  const { distance, latlng } = req.params
  const [lat, lng] = latlng.split(',')
  const radius = distance / 6378.1 // earth radius
  if (!lat || !lng) return next(new AppError('Please provide latitude and longitude in the format lat,lng.', 400))
  const cinemas = await Cinema.find({ location: { $geoWithin: { $centerSphere: [[lng, lat], radius] } } })

  res.status(200).json({
    status: 'success',
    results: cinemas.length,
    data: {
      data: cinemas
    }
  })
})
exports.getDistance = catchAsync(async(req, res, next) => {
  const { latlng } = req.params
  const [lat, lng] = latlng.split(',')
  if (!lat || !lng) return next(new AppError('Please provide latitude and longitude in the format lat,lng.', 400))
 
  const distances = await Cinema.aggregate([
    {
      $geoNear: {
        near: {
          type: 'Point',
          coordinates: [lng * 1, lat * 1]
        },
        distanceField: 'distance',
        distanceMultiplier: 0.001
      }
    },
    {
      $project: {
        distance: 1,
        name: 1
      }
    }
  ])
  distances.map(item => item.distance = item.distance.toFixed(2))
  res.status(200).json({
    status: 'success',
    data: {
      distances
    }
  })
})