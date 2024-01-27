const mongoose = require('mongoose');
const eprofileSchema =new mongoose.Schema({
    nickname: {
        type:String,
        default:"udaya",
    },
    profileId: {
        type:String,
    },
    socketId: {
        type:String, 
    },
    email: {
        type:String,
    },
    password: {
        type:String,
    },

    });

    // const eprofileModel = mongoose.model('Eprofile',eprofileSchema);
    // module.exports =eprofileModel ;
    module.exports =eprofileSchema ;
