import mqtt.*;
import netP5.*;
import oscP5.*;

NetAddress target, target2;
MQTTClient client;

float xPos;
float yPos;

void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://spatialinteraction:kruJOr7eLSgypZO3@spatialinteraction.cloud.shiftr.io", "processing");
  size(500, 500, FX2D);
  target = new NetAddress("floje-black-onion-2bc196.local", 8000);
  target2 = new NetAddress("floje-red-broccoli-2da812.local", 8000);
  frameRate(10);
}

void draw() {
  background(55);
  float x = constrain(map(xPos, -1.0, 1.0, 0, 180), 0, 180);
  float y = constrain(map(yPos, 1.0, -1.0, 0, 180), 0, 180);
  OscMessage msg = new OscMessage("/floje/servo/xy");
  msg.add(x);
  msg.add(y);
  OscP5.flush(msg, target);
  delay(1000);
  OscP5.flush(msg, target2);
}

void clientConnected() {
  println("client connected");
  client.subscribe("/positionAll");
}


void messageReceived(String topic, byte[] payload) {
  String payloadS = new String(payload);
  String[] values = split(payloadS, '!');  
  xPos = float (values[0]);
  yPos = float (values[1]);
  
}
void connectionLost() {
  println("connection lost");
}
