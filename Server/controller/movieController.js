const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const factory = require("./handleFactory");
const Movie = require("./../model/movieModel");
const multer = require("multer");
const sharp = require("sharp");
const dotenv = require("dotenv");
dotenv.config({ path: "./config.env" });
const { initializeApp } = require("firebase/app");
const {
  getStorage,
  ref,
  getDownloadURL,
  uploadBytesResumable,
} = require("firebase/storage");
// firebase config
const firebaseConfig = {
  apiKey: process.env.REACT_APP_FIREBASE_API_KEY,
  authDomain: process.env.REACT_APP_FIREBASE_AUTH_DOMAIN,
  databaseURL: process.env.REACT_APP_FIREBASE_DATABASE_URL,
  projectId: process.env.REACT_APP_FIREBASE_PROJECT_ID,
  storageBucket: process.env.REACT_APP_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.REACT_APP_FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.REACT_APP_FIREBASE_APP_ID,
};
initializeApp(firebaseConfig);
const storage = getStorage();

const multerStorage = multer.memoryStorage();
const upload = multer({
  storage: multerStorage,
});

exports.uploadMovieImageAndTrailer = upload.fields([
  { name: "imageCover", maxCount: 1 },
  { name: "trailer", maxCount: 1 },
]);
exports.resizeMovieImages = catchAsync(async (req, res, next) => {
  // if (!req.files || req.files.imageCover[0] === undefined) return next();
  // // 1) Cover image
  // req.body.imageCover = `movie-${Date.now()}-${
  //   req.files.imageCover[0].originalname
  // }-cover.jpeg`;
  // await sharp(req.files.imageCover[0].buffer)
  //   .toFormat("jpeg")
  //   .jpeg({ quality: 90 })
  //   .toFile(`public/img/movies/${req.body.imageCover}`);

  // next();

  if (!req.files || req.files.imageCover[0] == undefined) return next();
  const storageRef = ref(storage, `movies/${req.files.imageCover[0].originalname}`);
  // Create file metadata including the content type
  const metadata = {
    contentType: req.files.imageCover.mimetype,
  };

  // Upload the file in the bucket storage
  const snapshot = await uploadBytesResumable(
    storageRef,
    req.files.imageCover[0].buffer,
    metadata
  );
  //by using uploadBytesResumable we can control the progress of uploading like pause, resume, cancel

  // Grab the public url
  const downloadURL = await getDownloadURL(snapshot.ref);
  req.body.imageCover = downloadURL;
  next();
});

// Get all products
exports.TopSellingMovie = (req, res, next) => {
  req.query.limit = "5";
  req.query.sort = "-ratingsAverage";
  req.query.fields =
    "title, category, imageCover, duration, ratingsAverage, trailer, description, release_date, ratingsQuantity, actor, status";
  next();
};
exports.getAllMovies = factory.getAll(Movie, "actor");
exports.getMoviesByNameAndCategory = catchAsync(async (req, res, next) => {
  if (!req.query.title && !req.query.category) return next();
  if (req.query.category) req.query.category; 
  if (req.query.title)
    req.query.title = { $regex: req.query.title, $options: "i" };
  console.log(req.query);
  const data = await Movie.find(req.query).populate("actor");
  res.json({
    status: "success",
    results: data.length,
    data,
  });
});
//Get product by _id
exports.getMovieByID = factory.getOne(Movie, {
  path: "reviews",
  select: "-__v",
});
exports.getMovieByName = catchAsync(async (req, res, next) => {
  const title = req.query.title;
  const movie = await Movie.find({
    title: { $regex: title, $options: "i" },
  }).populate("actor");
  res.status(200).json({
    status: "success",
    movie,
  });
});

exports.saveMovieTrailerToStorage = catchAsync(async (req, res, next) => {
  if (!req.files || req.files.trailer[0] == undefined) return next();
  const storageRef = ref(storage, `trailer/${req.files.trailer[0].originalname}`);
  // Create file metadata including the content type
  const metadata = {
    contentType: req.files.trailer.mimetype,
  };

  // Upload the file in the bucket storage
  const snapshot = await uploadBytesResumable(
    storageRef,
    req.files.trailer[0].buffer,
    metadata
  );
  //by using uploadBytesResumable we can control the progress of uploading like pause, resume, cancel

  // Grab the public url
  const downloadURL = await getDownloadURL(snapshot.ref);
  req.body.trailer = downloadURL;
  next();
});
// Create new product
exports.createMovie = catchAsync(async (req, res, next) => {
  const movie = await Movie.create(req.body);
  res.status(201).json({
    status: "success",
    data: movie,
  });
});
exports.getCinemaByMovie = catchAsync(async (req, res, next) => {});
// Update product
exports.updateMovie = factory.updateOne(Movie);
exports.deleteMovie = factory.deleteOne(Movie);
