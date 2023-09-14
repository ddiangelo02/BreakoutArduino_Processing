import processing.serial.*;
Serial port;

float px, py, vx, vy;
int col = 7;
int lin = 7;
int total = col*lin;
void setup() {
  size (770, 600);
  port = new Serial(this, Serial.list()[2], 9600);
  reset();
}

void draw() {
  while (port.available() > 0) {
    String mensagem = port.readStringUntil(10);
    if (mensagem != null) {
      print(mensagem);
      int pos = int(mensagem.trim());
      background(0);
      rect(pos, height-20, 80, 20);
      if (px > pos-80 && px < pos+80 && py > height-30 && py < height-20) {
        vx *= -1;
        px += vx;
        vy *= -1;
      }
    }
  }
  bola();
  hit();
}
void bola() {
  ellipse(px, py, 15, 15);
  px += vx;
  py += vy;
}

void reset() {
  px = width/2;
  py = height/2;
  vx = random(3, 5);
  vy = random(3, 5);
}

void hit() {
  if (px < 0 || px > width) {
    vx *= -1;
    px += vx;
  }
  if ( py > height || py < 0 ) {
    vy *= -1;
  }
}
