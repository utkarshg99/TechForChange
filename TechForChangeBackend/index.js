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

async function makeEntry(uid, uidx, fname, dest, gender, weight, height, bmi, symptoms, remarks, date){
    let prom = new Promise((resolve, reject) => {
        let newEntry = new ENTRY({
            _id: new mongoose.Types.ObjectId(),
            status: false,
            uid, uidx,
            fname,
            dest, gender, weight, height, bmi, symptoms, remarks, date, age
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

async function findReports(uid) {
    let report={};
    let alpha={
        uid,
        status: true
    };
    let promiseforcheck = new Promise(function (resolve, reject) {
        var userrecord = ENTRY.find(alpha, function (err, docs) {
            if (err || typeof docs[0] === 'undefined') {
                report.status=false
                resolve();
            } else {
                report.status=true
                report.data=docs;
                resolve();
            }
        });
    });
    await promiseforcheck;
    return report;
}

async function updateUser(data){
    var conditions = {email: data.email}
    var update = {$set : { 
        name: data.name,
        age: data.age,
        gender: data.gender,
        phone: data.phone
     }}
    var opts = {multi : true}
    var prom = new Promise((resolve, reject) => {
        USER.update(conditions, update, opts, function(err, numAffected){
            resolve();
        })
    })
    await prom;
    return "Success";
}

async function getUser(data){
    let data2 = {};
    let alpha = {'email': data.email}
    let promiseforcheck = new Promise(function (resolve, reject) {
        var userrecord = USER.find(alpha, function (err, docs) {
            if (err || typeof docs[0] === 'undefined') {
                resolve();
            } else {
                data2=docs[0];
                resolve();
            }
        });
    });
    await promiseforcheck;
    return data2;
}

app.post('/putAudio', upload.single('audio'), (req, res, next) => {
    let uid = req.body.uid;
    let uidx = req.body.uidx;
    let fname = uidx+req.file.originalname;
    let src = destx+req.file.filename;
    let dest = 'unprocessed/'+fname;
    let gender=req.body.gender;
    let weight = parseFloat(req.body.weight);
    let height = parseFloat(req.body.height);
    let bmi = weight/(height*height);
    let symptoms = req.body.symptoms;
    let remarks = req.body.remarks;
    let date = req.body.date;
    let age = parseInt(req.body.age);
    fs.copyFileSync(src, dest);
    fs.unlinkSync(src);
    // console.log({uid, uidx, fname, dest, gender, weight, height, bmi, symptoms, remarks, date, age});
    makeEntry(uid, uidx, fname, dest, gender, weight, height, bmi, symptoms, remarks, date, age).then(()=>{
        res.json({
            'status': true,
        });
        res.end();
    }).catch(()=>{
        res.json({
            'status': false
        })
        res.end();
    })
})

router.post('/getReport', (req, res)=>{
    let uid = req.body.uid;
    findReports(uid).then((idx) => {
        res.json(idx);
        res.end();
    }).catch(() => {
        res.json({
            status: false,
        });
        res.end();
    });
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

router.post('/updateUser', (req, res) => {
    updateUser({
        "email": req.body.email, 
        "name": req.body.name, 
        "age": req.body.age, 
        "gender": req.body.gender, 
        "phone": req.body.phone
    }).then((idx) => {
        res.json({
            "status": idx
        });
        res.end();
    })
})

router.post('/getUser', (req, res) => {
    getUser({
        'email': req.body.email
    }).then( (idx) => {
        if(idx!={})
            res.json({ "data": idx, "status": true })
        else
            res.json({ "data": idx, "status": false })
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

router.get('/bitch', (req, res) => {
    res.json({
        "bitch":"sneaky lil bitch"
    });
    res.end();
})

var url = 'mongodb://127.0.0.1:27017/tfc'
// var url = 'mongodb+srv://utkarsh:9044682600@heroku-ia22v.mongodb.net/snt?retryWrites=true&w=majority';
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