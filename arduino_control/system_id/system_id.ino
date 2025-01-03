#include <SimplyAtomic.h>  // For the position read, to avoid missed counts

// Define Encoder pins, pwm pin, and motor driver pins
#define ENCA 0     // interrupt pin encoder A
#define ENCB 1     // interrupt pin encoder B
#define PWM_pin 2  // pin to send pwm value to motor driver
#define IN1 3      // motor driver direction pins
#define IN2 4

volatile int posi = 0;     // specify posi as volatile, integer because counts are discrete
int print_interval = 100;  // define how often values are sent to the serial monitor
int interval_count = 0;
float interval_start = 0;
float ref = 0;
int pos = 0;            // pos is the angular position of the output from the gearbox, in pulses
int e = 0;              // e is the error between ref and pos
int u = 0;              // u is the control signal
int u_amplitude = 150;  // control signal amplitude (must be < 256)
int u_sign = 0;         // used to specify required sign of control signal
long time_start = 0;
float counts_per_rotation = 131.25 * 16;
float ref_amplitude = counts_per_rotation;
int rotations = 0;
float time_per_rotation = 5000;  // time allowed per rotation, in milliseconds
float amplitude = 0;

// timestep in microseconds
long timeStep = 2000;
long lastUpdateTime = micros();
double runningTime = 0;

volatile int encoder_count_motor1 = 0;

void setup() {
  Serial.begin(230400);  // set baud rate for communication between USB & raspberry pi pico
  pinMode(ENCA, INPUT);
  pinMode(ENCB, INPUT);
  attachInterrupt(digitalPinToInterrupt(ENCA), readEncoder1, RISING);

  // pwm and direction pins are outputs that go to the motor
  pinMode(PWM_pin, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  time_start = millis();
}


void loop() {

  do{       } // running an empty loop until the current time- prev time is the desired timestep
  while ((micros() - lastUpdateTime) < timeStep);
  lastUpdateTime = micros();
  if (runningTime >= 50){
    amplitude = amplitude + 0.01;
    if (amplitude > 255){
        amplitude = 0;
    }
  }

  setMotor(1, amplitude, PWM_pin, IN1, IN2);


  // print target and position to see the response every print_interval times around the loop
  interval_count = interval_count + 1;
  if (interval_count >= print_interval) {
    interval_count = 0;
    Serial.print("time:"); Serial.print(runningTime);Serial.print(";");
    Serial.print("input_value:");Serial.print(amplitude);Serial.print(";");
    Serial.print("encoder:"); Serial.print(encoder_count_motor1);Serial.println();
  }

  runningTime += timeStep/1e6;
}

// function to send signal to motor driver (could also be defined at top of code)
// set inputs and their classifications
void setMotor(int dir, float pwmVal, int pwm_pin, int in1, int in2) {
  //set the pwm pin to the appropriate level (0 - 255)
  analogWrite(pwm_pin, pwmVal);
  //set direction
  if (dir == 1) {
    digitalWrite(in1, HIGH);
    digitalWrite(in2, LOW);
  } else if (dir == -1) {
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
  } else {
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
  }
}

void readEncoder1() {
  int b1 = digitalRead(ENCB);
  if (b1 > 0) {
    encoder_count_motor1++;
  } else {
    encoder_count_motor1--;
  }
}