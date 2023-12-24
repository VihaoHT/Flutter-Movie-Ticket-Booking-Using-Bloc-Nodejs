const User = require("./../model/userModel");
const catchAsync = require("./../utils/catchAsync");
const AppError = require("./../utils/appError");
const factory = require("./handleFactory");
const Ticket = require("../model/ticketModel");
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

const multerFilter = (req, file, cb) => {
  if (file.mimetype.startsWith("image")) {
    cb(null, true);
  } else {
    cb(new AppError("Not an image! Please upload only images.", 400), false);
  }
};

const upload = multer({
  storage: multerStorage,
  fileFilter: multerFilter,
});

exports.uploadUserPhoto = upload.single("avatar");

exports.resizeUserPhoto = catchAsync(async (req, res, next) => {
  // if (!req.file) return next();

  // req.file.filename = `user-${req.user.id}-${Date.now()}.jpeg`;

  // await sharp(req.file.buffer)
  //   .resize(500, 500)
  //   .toFormat('jpeg')
  //   .jpeg({ quality: 90 })
  //   .toFile(`public/img/users/${req.file.filename}`);

  // res.status(201).json({
  //   status: 'success',
  //   avatar: req.file.filename
  // })
  // next();
  if (!req.file) return next();
  const storageRef = ref(storage, `users/${req.file.originalname}`);
  // Create file metadata including the content type
  const metadata = {
    contentType: req.file.mimetype,
  };

  // Upload the file in the bucket storage
  const snapshot = await uploadBytesResumable(
    storageRef,
    req.file.buffer,
    metadata
  );
  //by using uploadBytesResumable we can control the progress of uploading like pause, resume, cancel

  // Grab the public url
  const downloadURL = await getDownloadURL(snapshot.ref);
  req.file.filename = downloadURL;
  res.status(201).json({
    status: "success",
    avatar: req.file.filename,
  });
  next();
});
const filterObj = (obj, ...allowedFields) => {
  const newObj = {};
  Object.keys(obj).forEach((el) => {
    if (allowedFields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};
exports.getMe = (req, res, next) => {
  req.params.id = req.user.id;
  next();
};
exports.getMyTickets = catchAsync(async (req, res, next) => {
  // // 1.Find all tickets
  // const tickets = await Ticket.find({ user: req.user.id})
  // // 2. Find tickets that contain user's id
  // const movieIDs = tickets.map(el => el.movie)
  // const movies = await Movie.find({ _id: { $in: movieIDs } })
  const tickets = await Ticket.find({ user: req.user.id });
  res.status(200).json({
    status: "success",
    tickets,
  });
});
exports.getAllUsers = factory.getAll(User);
exports.getUser = factory.getOne(User);
exports.updateMe = catchAsync(async (req, res, next) => {
  // 1) Create error if user POSTs password data
  if (req.body.password || req.body.passwordConfirm) {
    return next(
      new AppError(
        "This route is not for password updates. Please use /change-password.",
        400
      )
    );
  }
  // 2) Filtered out unwanted fields names that are not allowed to be updated
  //Chỉ được update những field này

  const filteredBody = filterObj(
    req.body,
    "avatar",
    "username",
    "email",
    "phone_number",
    "address",
    "location"
  );

  // 3) Update user document
  const updatedUser = await User.findByIdAndUpdate(req.user.id, filteredBody, {
    new: true,
    runValidators: true,
  });

  res.status(200).json({
    status: "success",
    data: {
      user: updatedUser,
    },
  });
});
exports.updateUser = factory.updateOne(User);
exports.generateVoucher = catchAsync(async (req, res, next) => {
  const voucher = generateRandomString(7);
  await User.findByIdAndUpdate(req.user.id, {
    voucher: {
      code: voucher,
    },
  });
  res.json({
    status: "success",
    message: "Chúc mừng, bạn đã nhận được một voucher!",
    voucher,
  });
});
exports.deleteVoucher = catchAsync(async (req, res, next) => {
  await User.findByIdAndUpdate(req.user.id, {
    voucher: null,
  });
  res.json({ message: "deleted" });
});
function generateRandomString(length) {
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let result = "";
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    result += characters.charAt(randomIndex);
  }
  return result;
}
