var express = require('express');
var router = express.Router();
const dbConn = require('./db');

router.get('/', function(req, res, next) {
    const sql = 'SELECT * FROM product';
    dbConn.query(sql, (err,data) => {
        console.log("produkty baza zapytanie");
        console.log(data);
        res.send({
            status: 'ok',
            data: data
        });
    });
});

module.exports = router;
