import processing.serial.*;
Serial myPort;

void setup()
{
  size(500, 500);
  myPort = new Serial(this, "/dev/cu.usbmodem144101", 115200);
}

void draw()
{
  if (myPort.available() == 0)
  {
    return;
  }
  String str = myPort.readStringUntil('£');
  if (str == null)
  { 
    return;
  }
float[] nums = float(split(str, '!'));
float x = nums[0];
float y = nums[1];
float z = nums[2];


println("x", x, " y", y, " z", z);
}
