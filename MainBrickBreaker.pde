import processing.serial.*;
Serial port;

float px, py, vx, vy;
int col = 7;
int lin = 7;
int total = col*lin;
Tijolo[] box = new Tijolo[total];

void setup() {
  size (770, 600);
  port = new Serial(this, Serial.list()[2], 9600);
  ArrayTijolo();
  reset();
}

void draw() {
  while (port.available() > 0) {
    String mensagem = port.readStringUntil(10);
    if (mensagem != null) {
      print(mensagem);
      int pos = int(mensagem.trim());
      background(0);
      fill(255);
      rect(pos, height-20, 80, 20);
      if (px >= pos-80 && px <= pos+80 && py >= height-30 && py <= height-20) {
        vx *= -1;
        px += vx;
        vy *= -1;
      }
    }
  }
  criaTijolo();
  bola();
  hit();
}
void bola() {
  fill(255);
  ellipse(px, py, 15, 15);
  px += vx;
  py += vy;
}

void reset() {
  px = 20;
  py = height-20;
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
  for (int i = 0; i<total; i++) {

    if (py <=box[i].y + box[i].alt/2 && py >= box[i].y && px > box[i].x - box[i].lar/2 && px <= box[i].x + box[i].lar/2 && box[i].hit == false) {
      vy *= -1;
      box[i].gotHit();
    }
    if (py >= box[i].y - box[i].lar/2 && py <= box[i].y + box[i].alt/2 &&  px > box[i].x - box[i].lar/2 && px <= box[i].x + box[i].lar/2 && box[i].hit == false) {
      vy *= -1;
      box[i].gotHit();
    }
    if (px >= box[i].x - box[i].lar/2 && px <= box[i].x + box[i].lar/2 && py >= box[i].y && py <= box[i].y + box[i].alt && box[i].hit == false) {
      vx *= -1;
      box[i].gotHit();
    }
    if (px <= box[i].x - box[i].lar/2 && px >= box[i].x + box[i].lar/2 && py >= box[i].y && py <= box[i].y + box[i].alt && box[i].hit == false) {
      vx *= -1;
      box[i].gotHit();
    }
  }
}
void ArrayTijolo() {
  for (int i = 0; i < lin; i++) {
    for (int j = 0; j < col; j++) {
      box[i*lin + j] = new Tijolo((i+1)*width/(lin +1), (j+1) * 50, 80, 30);
    }
  }
}
void criaTijolo() {
  for (int i = 0; i<total; i++) {
    box[i].display();
  }
}
