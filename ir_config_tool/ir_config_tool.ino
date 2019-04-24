/*
 * IR Config Tool
 * 
 * Usage:
 * Use this with the processing sketch, "serial_read_to_file" to generate an 
 * csv with labeled IR hex values in the format
 * label, hex
 * 
 * Upload this sketch to an Arduino with an IR receiver on pin 13.
 * 
 * This will print to Serial, the hex values of IR received.
 */

#include <IRremote.h>

int recvPin = 13; // IR Receiver
//String label = "";
IRrecv irrecv(recvPin);
decode_results results;

void setup() {
  Serial.begin(9600);
  irrecv.enableIRIn();
}

void loop() {
  // Detecting IR
  if (irrecv.decode(&results)) {
    // Serial Output
    Serial.println(results.value, HEX);

    irrecv.resume();
  }

//  // Setting label.
//  if (Serial.available() > 0) {
//    label = Serial.readString();
//    label.trim();
//  }
}
