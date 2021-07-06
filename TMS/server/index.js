var express = require('express');
var path = require('path');
var app = express();

app.listen(3000);
app.use(express.json());

app.get('/', (req, res) => {
    res.json('hi');
});


app.get('/kakaoLogin', (req, res) => {
    var { code } = req.query
    // var code = req.query.code;
    console.log(code);
    if (code) {
        // return res.json(true);
        return res.sendFile(path.join(__dirname, './views/kakao.html'));
    }
    return res.json(false);
});

