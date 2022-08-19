const multer = require('multer');

//where to store our files = images.video.txt files anything
const Storage = multer.diskStorage({
    //where and with what name
    destination : function (req,file,cb){
        cb (null,'./files')//where files are in foldname
    },
    filename: function (req,file,cb){
        const newImageName = Date.now()+ file.originalname
        req.imageName = newImageName
        cb(null, newImageName)
    }

})

const upload = multer({
storage:Storage,
});


module.exports = upload;