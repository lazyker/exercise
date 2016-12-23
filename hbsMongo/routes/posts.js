var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
    res.render('posts/list');
});

router.get('/write', function(req, res) {
    res.render('posts/edit');
});

module.exports = router;