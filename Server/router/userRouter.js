const express = require('express');
const router = express.Router()
const authController = require('./../controller/authController')
const userController = require('./../controller/UserController')

router.post('/register', authController.register)
router.post('/login', authController.login)
router.post('/forget-password', authController.forgetPassword)
router.post('/reset-password/:token', authController.resetPassword)

// protect all routes below
router.use(authController.protect)
router.get('/me', userController.getMe, userController.getUser)
router.post('/update-user-avatar', userController.uploadUserPhoto, userController.resizeUserPhoto)
router.patch('/update-me', userController.updateMe)
router.patch('/change-password', authController.changePassword)
router.get('/my-tickets', userController.getMyTickets)
router.post('/voucher', userController.generateVoucher)
router.delete('/voucher', userController.deleteVoucher)
router.use(authController.restrictTo('admin'))
router.route('/').get(userController.getAllUsers)
router.route('/:id').get(userController.getUser).patch(authController.restrictTo('admin'), userController.updateUser)
module.exports = router