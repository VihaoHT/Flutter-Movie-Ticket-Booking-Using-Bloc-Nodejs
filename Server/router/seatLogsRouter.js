const express = require('express');
const seatLogsController = require('./../controller/seatLogsController')
const router = express.Router()

router.use(authController.protect);

router
  .route('/')
  .get(seatLogsController.getAllSeatLogs)
  .post(seatLogsController.createSeatLog)

router.route('/:id')
  .delete(seatLogsController.deleteSeatLogs)
  .patch(seatLogsController.updateSeatLogs)

module.exports = router