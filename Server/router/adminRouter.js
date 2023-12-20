const express = require('express');
const router = express.Router();
const authController = require('./../controller/authController');
const adminController = require('./../controller/adminController');
const movieController = require('./../controller/movieController');
const actorController = require('./../controller/actorController')
const multer = require('multer')

const upload = multer({ storage: multer.memoryStorage()})
//login
router.get('/', function(req, res, next) {
    res.render('login', {title:'Admin'});
});
router.post('/login', adminController.login);
//router.use(adminController.protect);
// trang chủ
router.get('/test', function(req, res, next) {

    res.render('test');
});

router.use(authController.isLoggedIn)
//Movie
router.get('/index', adminController.getAllMovies);
router.get('/index/detailmovie/:id', adminController.movieDetail);
router.get('/index/deletemovie/:id', adminController.movie_delete);
router.get('/index/insert_getmovie', adminController.insertMovieGet);
router.post('/index/insert_postmovie', movieController.uploadMovieImageAndTrailer, movieController.resizeMovieImages ,adminController.insertMoviePost);
router.post('/index/update_postmovie/:id',movieController.uploadMovieImageAndTrailer, movieController.resizeMovieImages ,adminController.updateMoviePost);

//User
router.get('/user', adminController.getAllUsers);

//Category
router.get('/category', adminController.getAllCategory);
router.post('/category/insert_postcategory', adminController.insertCategoryPost);
router.get('/category/deletecategory/:id', adminController.deleteCategory);
router.get('/category/:id', adminController.detailCategory);
router.post('/category/update_postcategory/:id', adminController.updateCategoryPost);

//Room
router.get('/room', adminController.getAllRoom);
router.post('/room/insert_postroom', adminController.insertRoomPost);
router.get('/room/deleteroom/:id', adminController.deleteRoom);

//Cinema
router.get('/cinema', adminController.getAllCinema);
router.get('/cinema/:id', adminController.detailCinema);
router.post('/cinema/insert_postcinema', adminController.insertCinemaPost);
router.get('/cinema/deletecinema/:id', adminController.deleteCinema);

//Showtime
router.get('/showtime', adminController.getAllShowtime);
//router.get('/showtime/:id', adminController.detailShowtime);
router.post('/showtime/insert_postshowtime', adminController.insertShowtimePost);
router.get('/showtime/deleteshowtime/:id', adminController.deleteShowtime);

//Actor
router.get('/actor', adminController.getAllActor);
router.post('/actor/insert_postActor', actorController.uploadActorPhoto, actorController.resizeActorPhoto, adminController.insertActorPost);
router.get('/actor/deleteactor/:id', adminController.deleteActor);

//Thống kê
router.get('/statistic', adminController.ThongkeDoanhThu);

module.exports = router