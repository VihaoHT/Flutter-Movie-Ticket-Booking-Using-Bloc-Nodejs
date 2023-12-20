const User = require('./../model/userModel')
const catchAsync = require('./../utils/catchAsync')
const AppError = require('./../utils/appError')
const factory = require('./handleFactory');
const multer = require('multer');
const sharp = require('sharp');
const Actor = require('../model/actorModel');

const multerStorage = multer.memoryStorage();

const multerFilter = (req, file, cb) => {
  if (file.mimetype.startsWith('image')) {
    cb(null, true);
  } else {
    cb(new AppError('Not an image! Please upload only images.', 400), false);
  }
};

const upload = multer({
  storage: multerStorage,
  fileFilter: multerFilter
});

exports.uploadActorPhoto = upload.single('avatar');

exports.resizeActorPhoto = catchAsync(async (req, res, next) => {
  if (!req.file) return next();

  req.file.filename = `actor-${Date.now()}.jpeg`;

  await sharp(req.file.buffer)
    .resize(500, 500)
    .toFormat('jpeg')
    .jpeg({ quality: 90 })
    .toFile(`public/img/actors/${req.file.filename}`);

  next();
});
const filterObj = (obj, ...allowedFields) => {
  const newObj = {};
  Object.keys(obj).forEach(el => {
    if (allowedFields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};
exports.createActor = factory.createOne(Actor)
exports.getAllActors = factory.getAll(Actor)
exports.getActor = factory.getOne(Actor)
exports.updateActor = catchAsync(async (req, res, next) => {
  // 2) Filtered out unwanted fields names that are not allowed to be updated
        //Chỉ được update những field này 
  const filteredBody = filterObj(req.body, 'avatar','name', 'dob', 'country');
  if (req.file) filteredBody.avatar = req.file.filename;

  // 3) Update actor document
  const updatedActor = await Actor.findByIdAndUpdate(req.params.id, filteredBody, {
    new: true,
    runValidators: true
  });

  res.status(200).json({
    status: 'success',
    data: {
      actor: updatedActor
    }
  });
});