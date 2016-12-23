var express = require('express');
var router = express.Router();
var BoardModel = require('../models/BoardModel');

router.get('/', function(req, res){
    BoardModel.find({}, function(err, boardList) {
        res.render('board/list', {boardList : boardList});
    })
});

router.get('/write', function(req, res){
    res.render('board/edit');
});

router.post('/write', function(req, res) {
    var Board = new BoardModel({
        title : req.body.title,
        content : req.body.content
    });
    Board.save(function(err) {
        res.redirect('/board');
    });
});

router.get('/detail/:id', function(req, res) {
    BoardModel.findOne({'id' : req.params.id}, function(err, boardDetail) {
        res.render('board/detail', {boardDetail : boardDetail});
    });
});

router.get('/delete/:id', function(req, res) {
    BoardModel.remove({id : req.params.id}, function(err) {
        res.redirect('/board');
    });
});

module.exports = router;