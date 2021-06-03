#include <SparkFunMPU9250-DMP.h>
#include <SPI.h>
#include <WiFiNINA.h>
#include <MQTT.h>


#include "arduino_secrets.h"
char ssid[] = SECRET_SSID;        // your network SSID (name)
char pass[] = SECRET_PASS;    // your network password (use for WPA, or use as key for WEP)


MPU9250_DMP imu;
WiFiClient net;
MQTTClient client;

const char posAll[]  = "/positionAll";


void connect() {
  Serial.print("checking wifi...");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);
  }

  Serial.print("\nconnecting...");
  while (!client.connect("arduino", "spatialinteraction", "ux0v5DvYTIrVNcF5")) {
    Serial.print(".");
    delay(1000);
  }

  Serial.println("\nconnected!");
  client.subscribe(posAll);

  
}

void messageReceived(String &topic, String &payload) {
  Serial.println("incoming: " + topic + " - " + payload);
}

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, pass);
  client.begin("spatialinteraction.cloud.shiftr.io", net);
  client.onMessage(messageReceived);
  connect();

  if (imu.begin() != INV_SUCCESS)
  {
    while (1)
    {
      Serial.println("Unable to communicate with MPU-9250");
      Serial.println("Check connections, and try again.");
      Serial.println();
      delay(5000);
    }
  }
  imu.setSensors(INV_XYZ_ACCEL);
  imu.setAccelFSR(2); // Set accel to +/-2g
  imu.setLPF(5); // Set LPF corner frequency to 5Hz
  imu.setSampleRate(10); // Set sample rate to 10Hz
  imu.setCompassSampleRate(10); // Set mag rate to 10Hz

}


void loop() {

  client.loop();
  delay(10);
  
  if (!client.connected()) {
    Serial.println("in loop");
    connect();
  }

  if ( imu.dataReady() )
  {
    imu.update(UPDATE_ACCEL);
    printIMUData();

  }

}


void printIMUData(void)
{
  float accelX = imu.calcAccel(imu.ax);
  float accelY = imu.calcAccel(imu.ay);
  client.publish(posAll, (String(accelX)) + " , " + (String(accelY)));

  delay(100);
}
