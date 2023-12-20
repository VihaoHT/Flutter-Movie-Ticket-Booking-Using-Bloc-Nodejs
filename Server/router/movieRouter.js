const express = require('express');
const router = express.Router()
const authController = require('./../controller/authController')
const movieController = require('./../controller/movieController')
const reviewRouter = require('./reviewRouter')
const multer = require('multer')

const upload = multer({ storage: multer.memoryStorage()})

router.use('/:movieId/reviews', reviewRouter)
router.route('/top-5').get(movieController.TopSellingMovie, movieController.getAllMovies)
router
  .route('/')
  .get(movieController.getMoviesByNameAndCategory)
  .get(movieController.getAllMovies)
  .post(authController.protect, authController.restrictTo('admin'), movieController.uploadMovieImageAndTrailer, movieController.resizeMovieImages, movieController.saveMovieTrailerToStorage, movieController.createMovie)
router.get('/search', movieController.getMovieByName)
router
  .route('/id/:id')
  .get(movieController.getMovieByID)
  .patch(authController.protect, authController.restrictTo('admin'),movieController.uploadMovieImageAndTrailer, movieController.resizeMovieImages, movieController.saveMovieTrailerToStorage, movieController.updateMovie)
  .delete(authController.protect, authController.restrictTo('admin'), movieController.deleteMovie)



module.exports = router