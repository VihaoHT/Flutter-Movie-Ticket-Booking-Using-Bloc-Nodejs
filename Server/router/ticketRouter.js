const express = require('express');
const ticketController = require('./../controller/ticketController')
const router = express.Router()
const authCOntroller = require('../controller/authController')

router.use(authCOntroller.protect)

router.post('/checkout/:showtimeId', authCOntroller.protect, ticketController.getShowtime,
ticketController.seatsCheck, ticketController.checkOut)
router.post('/checkout/:showtimeId/create-ticket',ticketController.getShowtime, ticketController.createTicketCheckout) 
router.route('/user').get(ticketController.getTicketFromOneUser)
router.route('/thong-ke')
  .get(ticketController.ThongKeVeTheoThangNam)
router.get('/thong-ke/yearly', ticketController.ThongKeVeTheoNam)
router.route('/:id')
  .get(ticketController.getTicket)
  .patch(ticketController.updateTicket)
  .delete(ticketController.deleteTicket)

router.use(authCOntroller.restrictTo('admin'))
router
  .route('/')
  .get(ticketController.getAllTickets)
  .post(ticketController.createTicket)
module.exports = router