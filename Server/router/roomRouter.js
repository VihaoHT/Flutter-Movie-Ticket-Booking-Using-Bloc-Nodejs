const express = require('express');
const roomController = require('./../controller/roomController');
const router = express.Router()

router.route('/').post(roomController.createRoom).get(roomController.getAllRooms)
router.route('/:id').get(roomController.getRoom).patch(roomController.updateRoom).delete(roomController.deleteRoom)
module.exports = router