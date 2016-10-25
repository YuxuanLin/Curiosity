var express = require("express");
var app = express();
var http = require('http');
app.listen(8000);

var Gopigo   = require('node-gopigo').Gopigo
var Commands = Gopigo.commands
var Robot = Gopigo.robot

var ultrasonicPin = 15
//var irreceiverPin = 8

// Control timeout
var cachedAction = ""
var timer = -1

setInterval(function() {
  timer = timer - 1;
  if (timer == 0) {
    handleAnswer("x");
    console.log("from timer");
  }
}, 1);

// Continuous move
app.get('/moveContinuous', function(req, res){
  res.send('done');
  timer = 200;
  robot.motion.setLeftSpeed(req.query.leftSpeed);
  robot.motion.setRightSpeed(req.query.rightSpeed);
  handleAnswer(req.query.action);
});

app.get('/stop', function(req, res){
  timer = 1;
  console.log("from /stop");
  res.send('done');
});

// Control gopigo car move with steps. 
// n1=1 n2=0 n3=15 act = d --> turn left for 90 degree
// n1=0 n2=1 n3=15 act = a --> turn right for 90 degree
app.get('/moveWithSteps', function(req, res){
  robot.encoders.targeting( req.query.leftMotor, req.query.rightMotor, req.query.stepCount);
  handleAnswer(req.query.action);
  res.send('done');
});

robot = new Robot({
  minVoltage: 5.5,
  criticalVoltage: 1.2,
  debug: true,
  ultrasonicSensorPin: ultrasonicPin,
  //IRReceiverSensorPin: irreceiverPin
})
robot.on('init', function onInit(res) {
  if (res) {
    console.log('GoPiGo Ready!')

    // askForCommand()
  } else {
    console.log('Something went wrong during the init.')
  }
})
robot.on('error', function onError(err) {
  console.log('Something went wrong')
  console.log(err)
})
robot.on('free', function onFree() {
  console.log('GoPiGo is free to go')
})
robot.on('halt', function onHalt() {
  console.log('GoPiGo is halted')
})
robot.on('close', function onClose() {
  console.log('GoPiGo is going to sleep')
})
robot.on('reset', function onReset() {
  console.log('GoPiGo is resetting')
})
robot.on('normalVoltage', function onNormalVoltage(voltage) {
  console.log('Voltage is ok ['+voltage+']')
})
robot.on('lowVoltage', function onLowVoltage(voltage) {
  console.log('(!!) Voltage is low ['+voltage+']')
})
robot.on('criticalVoltage', function onCriticalVoltage(voltage) {
  console.log('(!!!) Voltage is critical ['+voltage+']')
})
robot.init()

function handleAnswer(answer) {
  if (timer < 0) {
    return
  }

  var message = ''
  switch (answer) {
    case 'help':
      console.log('')
      console.log('reset => performs a reset of LEDs and servo motor')
      console.log('left led on => turn left led on')
      console.log('left led off => turn left led off')
      console.log('right led on => turn right led on')
      console.log('right led off => turn right led off')
      console.log('move forward => moves the GoPiGo forward')
      console.log('move backward => moves the GoPiGo backward')
      console.log('turn left => turns the GoPiGo to the left')
      console.log('turn right => turns the GoPiGo to the right')
      console.log('stop => stops the GoPiGo')
      console.log('increase speed => increases the motors speed')
      console.log('decrease speed => decreases the motors speed')
      console.log('voltage => returns the voltage value')
      console.log('servo test => performs a servo test')
      console.log('ultrasonic distance => returns the distance from an object')
      console.log('move forward with PID => moves the GoPiGo forward with PID')
      console.log('move backward with PID => moves the GoPiGo backward with PID')
      console.log('rotate left => rotates the GoPiGo to the left')
      console.log('rotate right => rotates the GoPiGo to the right')
      console.log('set encoder targeting => sets the encoder targeting')
      console.log('firmware version => returns the firmware version')
      console.log('board revision => returns the board revision')
      console.log('ir receive => returns the data from the IR receiver')
      console.log('exit => exits from this test')
      console.log('')
    break
    case 'reset':
      robot.reset()
    break
    case 'left led on':
      var res = robot.ledLeft.on()
      console.log('Left led on::'+res)
    break
    case 'left led off':
      var res = robot.ledLeft.off()
      console.log('Left led off::'+res)
    break
    case 'right led on':
      var res = robot.ledRight.on()
      console.log('Right led on::'+res)
    break
    case 'right led off':
      var res = robot.ledRight.off()
      console.log('Right led off::'+res)
    break
    case 'move forward':
    case 'w':
      var res = robot.motion.forward(false)
      console.log('Moving forward::' + res)
    break
    case 'turn left':
    case 'a':
      var res = robot.motion.left()
      console.log('Turning left::' + res)
    break
    case 'turn right':
    case 'd':
      var res = robot.motion.right()
      console.log('Turning right::' + res)
    break
    case 'move backward':
    case 's':
      var res = robot.motion.backward(false)
      console.log('Moving backward::' + res)
    break
    case 'stop':
    case 'x':
      var res = robot.motion.stop()
      console.log('Stop::' + res)
    break
    case 'increase speed':
    case 't':
      var res = robot.motion.increaseSpeed()
      console.log('Increasing speed::' + res)
    break
    case 'decrease speed':
    case 'g':
      var res = robot.motion.decreaseSpeed()
      console.log('Decreasing speed::' + res)
    break
    case 'voltage':
    case 'v':
      var res = robot.board.getVoltage()
      console.log('Voltage::' + res + ' V')
    break
    case 'servo test':
    case 'b':
      robot.servo.move(0)
      console.log('Servo in position 0')

      robot.board.wait(1000)
      robot.servo.move(180)
      console.log('Servo in position 180')

      robot.board.wait(1000)
      robot.servo.move(90)
      console.log('Servo in position 90')
    break
    case 'exit':
    case 'z':
      robot.close()
      process.exit()
    break
    case 'ultrasonic distance':
    case 'u':
      var res = robot.ultraSonicSensor.getDistance()
      console.log('Ultrasonic Distance::' + res + ' cm')
    break
    case 'ir receive':
      var res = robot.IRReceiverSensor.read()
      console.log('IR Receiver data::')
      console.log(res)
    break
    case 'l':
      // TODO
    break
    case 'move forward with pid':
    case 'i':
      var res = robot.motion.forward(true)
      console.log('Moving forward::' + res)
    break
    case 'move backward with pid':
    case 'k':
      var res = robot.motion.backward(true)
      console.log('Moving backward::' + res)
    break
    case 'rotate left':
    case 'n':
   robot.encoders.targeting(1, 1, 15)
      var res = robot.motion.leftWithRotation()
      console.log('Rotating left::' + res)
    break
    case 'rotate right':
    case 'm':
      var res = robot.motion.rightWithRotation()
      console.log('Rotating right::' + res)
    break
    case 'set encoder targeting':
    case 'y':
      var res = robot.encoders.targeting(1, 1, 18)
      console.log('Setting encoder targeting:1:1:18::' + res)
    break
    case 'firmware version':
    case 'f':
      var res = robot.board.version()
      console.log('Firmware version::' + res)
    break
    case 'board revision':
      var res = robot.board.revision()
      console.log('Board revision::' + res)
    break
  }

  // robot.board.wait(1000)
  // askForCommand()
};

var options = {
  host: 'www.google.com',
  port: 443,
  path: '/index.html'
};

setInterval(function() {
  http.get(options, function(res) {
    console.log(Math.random());
  }).on('error', function(e) {
    console.log("Got error: " + e.message);
  });
}, 1000);