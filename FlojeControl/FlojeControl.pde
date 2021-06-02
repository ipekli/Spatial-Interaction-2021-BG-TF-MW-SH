import netP5.*;
import oscP5.*;

NetAddress target;

void setup() {
  size(500, 500, FX2D);

  target = new NetAddress("floje-white-cabbage-2da88a.local", 8000);
  frameRate(10);
}

void draw() {
  background(55);

  float x = constrain(map(mouseX, 0, width, 0, 180), 0, 180);
  float y = constrain(map(mouseY, 0, height, 0, 180), 0, 180);

  OscMessage msg = new OscMessage("/floje/servo/xy");
  msg.add(x);
  msg.add(y);

  OscP5.flush(msg, target);
}

void mousePressed() {
}
