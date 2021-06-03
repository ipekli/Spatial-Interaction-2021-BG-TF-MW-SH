import mqtt.*;
import netP5.*;
import oscP5.*;

NetAddress target;
MQTTClient client;

float xPos;
float yPos;

void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://spatialinteraction:kruJOr7eLSgypZO3@spatialinteraction.cloud.shiftr.io", "processing");
  size(500, 500, FX2D);
  target = new NetAddress("floje-pink-cucumber-2bd37d.local", 8000);
  frameRate(10);
}

void draw() {
  background(55);
 // float x = constrain(map(mouseX, 0, width, 0, 180), 0, 180);
  float x = constrain(map(xPos, -1.0, 1.0, 0, 180), 0, 180);
  float y = constrain(map(yPos, -1.0, 1.0, 0, 180), 0, 180);
 // float y = constrain(map(mouseY, 0, height, 0, 180), 0, 180);
  OscMessage msg = new OscMessage("/floje/servo/xy");
  msg.add(x);
  msg.add(y);
  OscP5.flush(msg, target);
  println(xPos,yPos);
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
