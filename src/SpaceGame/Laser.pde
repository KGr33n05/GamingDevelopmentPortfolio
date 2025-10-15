class Laser {
  int x, y, w, h, speed;
  PImage l1;

  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    w = 40;
    h = 40;
    l1 = loadImage("laazer.png");
    speed = 10;
  }

  void display() {
    imageMode(CENTER);
    l1.resize(w, h);
    image(l1, x, y);
  }

  void move() {
    y = y - speed;
  }

  boolean reachedTop() {
    if (y<0-40) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<r.diam/2) {
      return true;
    } else {
      return false;
    }
  }
}
