class Tijolo {
  int lar;
  int alt;
  int x;
  int y;
  float r, g, b;
  boolean hit;

  Tijolo (int vx, int vy, int vlar, int valt) {
    lar = vlar;
    alt = valt;
    x = vx;
    y = vy;
    r = random(100, 255);
    g = random(50, 100);
    b = random(100, 255);
    hit = false;
  }

  void display() {
    noStroke();
    fill(r, g, b);
    rectMode (CENTER);
    rect(x, y, lar, alt);
  }

  void gotHit() {
    hit = true;
    r = 0;
    g = 0;
    b = 0;
    println("bateu");
  }
}
