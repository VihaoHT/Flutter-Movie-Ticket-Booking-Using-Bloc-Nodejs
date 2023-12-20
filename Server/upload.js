var multer = require('multer');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './public/images/');
    },
    filename: function (req, file, cb) {
        const uniqueSffix = Date.now()+'-'+Math.round(Math.random()*1E9)
        cb(null, file.fieldname+'-'+ uniqueSffix+'-'+ file.originalname);
    }
});
module.exports = multer({storage:storage});