// Load the http module to create an http server.
var http = require('http'),
express = require('express'),
path = require('path'); //module for handling and transforming file paths
MongoClient = require('mongodb').MongoClient,
Server = require('mongodb').Server,
CollectionDriver = require('./collectionDriver').CollectionDriver;

//setting up our express app
var app = express();
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

var mongoHost = 'localHost'; //A
var mongoPort = 27017; 
var collectionDriver;

var mongoClient = new MongoClient(new Server(mongoHost, mongoPort)); //B
mongoClient.open(function(err, mongoClient) { //C
  if (!mongoClient) {
      console.error("Error! Exiting... Must start MongoDB first");
      process.exit(1); //D
  }
  var db = mongoClient.db("MyDatabase");  //E
  collectionDriver = new CollectionDriver(db); //F
});

app.use(express.bodyParser());

//set a middleware, tell it to join the local directy of the this script with public
app.use(express.static(path.join(__dirname, 'public')));

//setup our route for base endpoint
// app.get('/', function (req, res) {
//   res.send('<html><body><h1>Hello World</h1></body></html>');
// });

// //adds a new route that takes 3 slashes
// app.get('/:a?/:b?/:c?', function (req,res) {
// 	res.send(req.params.a + ' ' + req.params.b + ' ' + req.params.c);
// });

app.get('/:collection', function(req, res) { //A
   var params = req.params; //B
   collectionDriver.findAll(req.params.collection, function(error, objs) { //C
    	  if (error) { res.send(400, error); } //D
	      else { 
	          if (req.accepts('html')) { //E
    	          res.render('data',{objects: objs, collection: req.params.collection}); //F
              } else {
	          res.set('Content-Type','application/json'); //G
                  res.send(200, objs); //H
              }
         }
   	});
});
 
app.get('/:collection/:entity', function(req, res) { //I
   var params = req.params;
   var entity = params.entity;
   var collection = params.collection;
   if (entity) {
       collectionDriver.get(collection, entity, function(error, objs) { //J
          if (error) { res.send(400, error); }
          else { res.send(200, objs); } //K
       });
   } else {
      res.send(400, {error: 'bad url', url: req.url});
   }
});

app.post('/:collection', function(req, res) { //A
    var object = req.body;
    var collection = req.params.collection;
    collectionDriver.save(collection, object, function(err,docs) {
          if (err) { res.send(400, err); } 
          else { res.send(201, docs); } //B
     });
});



app.use(function (req,res) { //1
    res.render('404', {url:req.url}); //2
});


//setup our node server in one line
// http.createServer(app).listen(app.get('port'), function(){
//   console.log('Express server listening on port ' + app.get('port'));
// });

//setup our node server, spread it over 2 lines
var server = http.createServer(app)

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});