class Rock {
  int x, y, diam, speed;
  PImage r1;

  Rock() {
    x = int(random(width));
    y = -100;
    diam = int(random(50, 100));
    speed = int(random(1, 7));
    if (random(10)>6.6) {
      r1 = loadImage("rock1.png");
    } else if (random(10)>5) {
      r1 = loadImage("rock2.png");
    } else {
      r1 = loadImage("rock3.png");
    }
  }

  void display() {
    imageMode(CENTER);
    r1.resize(diam, diam);
    image(r1, x, y);
  }

  void move() {
    y = y + speed + level + level;
  }

  boolean reachedBottom() {
    if (y>height+100) {
      return true;
    } else {
      return false;
    }
  }
}
