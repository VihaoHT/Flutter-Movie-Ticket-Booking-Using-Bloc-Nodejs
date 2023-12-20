const mongoose = require('mongoose')
const Movie = require('./movieModel');
const Showtime = require('./showtimeModel');
const AppError = require('../utils/appError');
const { getShowtimeByCinema } = require('../controller/showtimeController');

const currentTimestamp = Date.now();
const offsetHours = 7;
const date = new Date(currentTimestamp + offsetHours * 60 * 60 * 1000);
const ticketSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.ObjectId,
    ref: 'User'
  },
  showtime: {
    type: mongoose.Schema.ObjectId,
    ref: 'Showtime'
  },
  seats: [String],
  booking_time: {
    type: Date,
    default: date.toLocaleString()
  },
  ticket_code: {
    type: String,
    default: generateRandomString(5) // random strings for ticket codes
  }
})
function generateRandomString(length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let result = '';
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    result += characters.charAt(randomIndex);
  }
  return result;
}
ticketSchema.statics.calculatePriceYearly = async function (year) {
  try {
    const result = await Ticket.aggregate([
      {
        $match: {
          booking_time: {
            $gte: new Date(`${year}-01-01`),
            $lt: new Date(`${year + 1}-01-01`)
          }
        }
      },
      {
        $lookup: {
          from: 'showtimes',
          localField: 'showtime',
          foreignField: '_id',
          as: 'showtime'
        }
      },
      {
        $unwind: '$showtime'
      },
      {
        $unwind: '$seats'
      },
      {
        $group: {
          _id: { $month: '$booking_time' }, // Group by month
          totalRevenue: { $sum: '$showtime.price' }
        }
      },
      {
        $sort: {
          '_id': 1 // Sort by month
        }
      }
    ]);
    //return result
    const monthlyRevenues = result.reduce((acc, monthlyResult) => {
      acc[monthlyResult._id] = monthlyResult.totalRevenue;
      return acc;
    }, {});
    //const monthlyRevenues = result.map(month => month.totalRevenue)
    // Fill in missing months with totalRevenue set to 0

    for (let month = 1; month <= 12; month++) {
      if (!monthlyRevenues[month]) {
        monthlyRevenues[month] = 0;
      }
    }
    // return cap key value la month & totalRevenue: 
    // return Object.keys(monthlyRevenues).map(month => ({
    //   month: parseInt(month),
    //   totalRevenue: monthlyRevenues[month]
    // }));

    // return moi totalRevenue:
    return Object.keys(monthlyRevenues).map(month => monthlyRevenues[month]);
  } catch (error) {
    console.error('Error calculating yearly revenue:', error);
    throw error;
  }
};
ticketSchema.pre(/^find/, async function (next) {
  this.populate({
    path: 'showtime',
    populate: [
      { path: 'room', model: 'Room', select: 'name', populate: { path: 'cinema', model: 'Cinema', select: 'name location' } },
      { path: 'movie', model: 'Movie', select: 'title imageCover' }
    ]
  })
  next();
})
const Ticket = mongoose.model('Ticket', ticketSchema)
module.exports = Ticket