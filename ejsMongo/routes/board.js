var express = require('express');
var router = express.Router();
var BoardModel = require('../models/BoardModel');

router.get('/', function(req, res){
    BoardModel.find({}, function(err, boardList) {
        res.render('board/list', {boardList : boardList});
    })
});

router.get('/write', function(req, res){
    var boardDetail = {};
    res.render('board/edit', {boardDetail : boardDetail});
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

router.get('/edit/:id', function(req, res) {
    BoardModel.findOne({'id' : req.params.id}, function(err, boardDetail) {
        res.render('board/edit', {boardDetail, boardDetail});
    });
});

router.post('/edit/:id', function(req, res) {
    var query = {
        title : req.body.title,
        content : req.body.content
    }
    BoardModel.update({'id' : req.params.id}, {$set : query}, function(err) {
        res.redirect('/board');    
    })
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