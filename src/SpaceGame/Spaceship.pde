class Spaceship {
  // Member variables
  int x, y, w, health, laserCount, turretCount;
  //PImage ship;

  //Constructor
  Spaceship() {
    x = width/2;
    y = height/2;
    w = 100;
    health = 100;
    laserCount = 101;
    turretCount = 1;
    //ship = loadImage("filename.png");
  }

  //Member Methods
  void display() {
    //image(ship,x,y);
    //imageMode(CENTER);
    fill(255);
    ellipse(x, y, 80, 20);
    rectMode(CENTER);
    rect(x, y, 20, 100);
    triangle(x, y-25, x-40, y+10, x+40, y+10);
    stroke(255);
    line(x+30, y-20, x+30, y+20);
    line(x-30, y-20, x-30, y+20);
    fill(173, 216, 230);
    rect(x, y-20, 10, 30);
    triangle(x-17, y+10, x-22, y+35, x-12, y+35);
    fill(255, 160, 20);
    triangle(x-22, y+35, x-12, y+35, x-17, y+45);
    fill(173, 216, 230);
    triangle(x+17, y+10, x+22, y+35, x+12, y+35);
    fill(255, 160, 20);
    triangle(x+22, y+35, x+12, y+35, x+17, y+45);
  }
  void move(int x,int y) {
    this.x = x;
    this.y = y;
  }
  boolean fire() {
    if(laserCount>0) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(Rock r) {
    float d = dist(x,y,r.x,r.y);
    if(d<r.diam) {
      return true;
    } else {
      return false;
    }
  }
}
