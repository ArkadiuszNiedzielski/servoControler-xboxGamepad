import processing.serial.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import cc.arduino.*;
import org.firmata.*;

ControlDevice cont;
ControlIO control;

Arduino arduino;

float thumb;
float dioda;
float aLED;

void setup() {
 size(360, 200);
 
 control=ControlIO.getInstance(this);
 cont=control.getMatchedDevice("xboxservo");
 
   if (cont==null){
     println("not today chump");
     System.exit(-1);
   }
   
   //println(Arduino.list());
   arduino=new Arduino(this, Arduino.list()[1], 57600);
   arduino.pinMode(10, Arduino.OUTPUT);
   arduino.pinMode(9, Arduino.SERVO);
   arduino.pinMode(6, Arduino.OUTPUT);
}

public void LEDOnClick()
{
   dioda = cont.getButton("LED").getValue();
   if (dioda==8)
     arduino.digitalWrite(10, Arduino.HIGH);
     else
     arduino.digitalWrite(10, Arduino.LOW);
   
}

public void analogLED()
{
      aLED = map(cont.getSlider("analogLED").getValue(), 0, -1, 0, 255);
    if (aLED > 1) 
    {
    arduino.analogWrite(6, (int)aLED); 
    }
    else {
      arduino.analogWrite(6, 0);
  }
    
}


public void moveServo()
{
   thumb = map(cont.getSlider("Servo").getValue(), -1, 1, 0, 180);
   arduino.servoWrite(9, (int)thumb);
   delay(100);
}


void draw()
{
   LEDOnClick();
   moveServo();   
   analogLED();
  // println(aLED);
}
