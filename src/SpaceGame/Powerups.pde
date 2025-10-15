class Powerups {
  int x, y, diam, speed;
  PImage p1;
  char type;

  Powerups() {
    x = int(random(width));
    y = -100;
    diam = 75;
    speed = int(random(1, 7));
    if (random(10)>6.6) {
      p1 = loadImage("ammo.png");
      type = 'a'; //Ammo
    } else if (random(10)>5) {
      p1 = loadImage("health.png");
      type = 'h'; //Health
    } else {
      p1 = loadImage("level.png");
      type = 'l'; //increases level and turret count
    }
  }

  void display() {
    //fill(255,0,0);
    //ellipse(x,y,diam,diam);
    //fill(255);
    //textAlign(CENTER);
    //text(type,x,y);
    imageMode(CENTER);
    p1.resize(diam, diam);
    image(p1, x, y);
  }

  void move() {
    y = y + speed;
  }

  boolean reachedBottom() {
    if (y>height+100) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(Spaceship s) {
    float d = dist(x, y, s.x, s.y);
    if (d<s.w/2) {
      return true;
    } else {
      return false;
    }
  }
}
