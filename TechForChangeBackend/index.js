let mongoose = require('mongoose')
let express = require('express')
let bodyParser = require('body-parser')
let path = require('path')
let axios = require('axios')
let cors = require('cors')
let multer  = require('multer')
let fs = require('fs')
const ENTRY = require('./schemas/entries.js')
const USER = require('./schemas/users.js')
let app = express()
app.use(cors())
let router = express.Router()
app.use(bodyParser.json({
    type: 'application/json'
}))
let options = {
    useNewUrlParser: true,
    useFindAndModify: false,
    useCreateIndex: true
}
let destx = 'uploads/';
let upload = multer({ dest: destx });

async function checkExistence(data, stat){
    let status = false;
    let alpha = {
        'email': data.email,
        'pass': data.pass
    }
    if(stat){
        alpha = {'email': data.email}
    }
    let promiseforcheck = new Promise(function (resolve, reject) {
        var userrecord = USER.find(alpha, function (err, docs) {
            if (err || typeof docs[0] === 'undefined') {
                status=!stat;
                resolve();
            } else {
                status=stat;
                resolve();
            }
        });
    });
    await promiseforcheck;
    return status;
}

async function reglog(data, stat){
    return checkExistence(data, stat).then(async (k) => {
        if(!k){
            if(stat) {
                let prom = new Promise((resolve, reject) => {
                    let newUser = new USER({
                        _id: new mongoose.Types.ObjectId(),
                        email: data.email,
                        pass: data.pass,
                        name: data.name
                    })
                    newUser.save((err) => {
                        if (err) {
                            console.log(err)
                            reject()
                        }
                        resolve()
                    })
                });
                await prom;
            }
            return data.email;
        }
        else{
            return "sucker";
        }
    }).catch((err) => {
        return "sucker";
    })
}

async function makeEntry(uid, fname, dest){
    let prom = new Promise((resolve, reject) => {
        let newEntry = new ENTRY({
            _id: new mongoose.Types.ObjectId(),
            status: false,
            uid,
            fname,
            dest
        })
        newEntry.save((err) => {
            if (err) {
                console.log(err)
                reject()
            }
            resolve()
        })
    });
    await prom;
}

app.post('/putAudio', upload.single('audio'), (req, res, next) => {
    let uid = req.body.uid;
    let fname = uid+req.file.originalname;
    let src = destx+req.file.filename;
    let dest = 'unprocessed/'+fname;
    fs.copyFileSync(src, dest);
    fs.unlinkSync(src);
    makeEntry(uid, fname, dest);
    res.json({
        'status': true,
    });
    res.end();
})

router.post('/makeUser', (req, res) => {
    reglog({"pass": req.body.pass, "email": req.body.email, "name": req.body.name}, true).then((idx) => {
        idx={
            idx,
            "status": true
        }
        if(idx.idx=="sucker"){
            idx.status=false
        }  
        res.json(idx);
        res.end();
    }).catch((err) => {
        res.json({
            "idx": "sucker",
            "status": false
        })
        res.end();
    })
})

router.post('/login', (req, res) => {
    reglog({"pass": req.body.pass, "email": req.body.email}, false).then((idx) => {
        idx={
            idx,
            "status": true
        }
        if(idx.idx=="sucker"){
            idx.status=false
        }  
        res.json(idx);
        res.end();
    }).catch((err) => {
        res.json({
            "idx": "sucker",
            "status": false
        })
        res.end();
    })
})

// var url = 'mongodb://127.0.0.1:27017/tfc'
var url = 'mongodb+srv://utkarsh:9044682600@heroku-ia22v.mongodb.net/snt?retryWrites=true&w=majority';
var port = 8000
port = process.env.PORT
if (port == null || port == "") {
  port = 8000
}
mongoose.connect(url, options, function (err) {
    app.use('/', router)
    app.listen(port)
    console.log("Connected and waiting at port = "+port);
});