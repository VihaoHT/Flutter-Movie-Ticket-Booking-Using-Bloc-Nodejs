const viewController = require('../controller/viewController')
const express = require('express')
const router = express.Router()
const authController = require('../controller/authController')

router.get('/', viewController.loginPage)

router.get('/index', authController.protect,viewController.indexPage)

module.exports = router