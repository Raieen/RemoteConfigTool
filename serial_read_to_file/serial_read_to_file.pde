/*
 * Serial Read To File
 * 
 * Usage:
 * Use this with the Ardunio sketch, "ir_config_tool" to generate an 
 * csv with labeled IR hex values in the format
 * label, hex
 * 
 * Use this sketch to record the IR hex values received from the Arduino
 * to be saved into a csv file.
 * 
 * Need to specify the label for the hex values manually.
 */

import processing.serial.*;
import java.util.Date; 

Serial serial;
String label = "";
PrintWriter file;

void setup() {
  size(500, 150);
  
  printArray(Serial.list());
  serial = new Serial(this, Serial.list()[1], 9600);
  
  String filename = "ir-hex-" + new Date().getTime() + ".csv";
  file = createWriter(filename);
  println("Saving to file " + filename);  
}

void draw() {
  background(255); // Clear background.
  drawText();
  
  while (serial.available() > 0 && !label.isEmpty()) {
    String line = serial.readString().trim();
    line = line.replaceAll("\n", "\t");
    println(label + "," + line);
    file.println(label + "," + line);
    file.flush();
    background(0, 255, 0); // Flash green indication.
  }
}

void drawText() {
  textSize(25);
  textAlign(CENTER);
  fill(255, 0, 0);
  text(label, width / 2, height / 2);
}

// Keeping track of label.
void keyPressed() {
  if(keyCode == BACKSPACE && label.length() > 0) {
    label = label.substring(0, label.length() - 1); // Remove tail character.
  } else if (keyCode != SHIFT && keyCode != ALT && keyCode != CONTROL && keyCode != BACKSPACE) { // Check not a modifier.
    label += key;
  }
}
