const express = require('express');
const router = express.Router()
const actorController = require('./../controller/actorController')

router.patch('/update/:id', actorController.uploadActorPhoto, actorController.resizeActorPhoto, actorController.updateActor)
router.post('/add', actorController.uploadActorPhoto, actorController.resizeActorPhoto,actorController.createActor)
router.route('/').get(actorController.getAllActors)
router.route('/:id').get(actorController.getActor)
module.exports = router