import processing.javafx.*;

import mqtt.*;
import netP5.*;
import oscP5.*;

NetAddress target, target2, target3, target4, target5, target6, target7, target8;
MQTTClient client;

int posY;
int posX;

void setup() {
  size(500, 500, FX2D);
  target4 = new NetAddress("floje-orange-potato-2da940.local", 8000);
  target7 = new NetAddress("floje-white-tomato-2bc983.local", 8000);
  target2 = new NetAddress("floje-blue-sweetcorn-2bcd01.local", 8000);
  target6 = new NetAddress("floje-black-onion-2bc196.local", 8000);
  target3 = new NetAddress("floje-aqua-cucumber-86cdd.local", 8000);
  target5 = new NetAddress("floje-red-broccoli-2da812.local", 8000);
  target8 = new NetAddress("floje-pink-cucumber-2bd37d.local", 8000);
  target = new NetAddress("floje-white-cabbage-2da88a.local", 8000);
  frameRate(10);
}

void draw() {

  background(55);

  for (int i = 0; i < 180; i++) {
    posX = int(random(0, 180));
    posY = int(random(0, 180));
  }

  float x = constrain(map(posX, 0, 180, 0, 180), 0, 180);
  float y = constrain(map(posY, 180, 0, 0, 180), 0, 180);

  println("posX " + x, "posY " + y);
  delay(100);

  OscMessage msg = new OscMessage("/floje/servo/xy");
  msg.add(x);
  msg.add(y);
  OscP5.flush(msg, target);
  OscP5.flush(msg, target2);
  delay(1000);
  OscP5.flush(msg, target3);
  OscP5.flush(msg, target4);
  delay(1000);
  OscP5.flush(msg, target5);
  OscP5.flush(msg, target6);
  delay(1000);
  OscP5.flush(msg, target7);
  OscP5.flush(msg, target8);
  delay(1000);
}
