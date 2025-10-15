//Kolby Green | September 17th 2025 | SpaceGame
import processing.sound.*;
Spaceship s1;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Powerups> powups = new ArrayList<Powerups>();
Timer rockTimer, puTimer;
int score, rocksPassed, level;
boolean play;
PImage st1,go1;
SoundFile Blast, Upgrade;

void setup() {
  size(500, 800);
  background(20);
  s1 = new Spaceship();
  rockTimer = new Timer(1000 - (level*100));
  rockTimer.start();
  puTimer = new Timer(9000);
  puTimer.start();
  score = 0;
  rocksPassed = 0;
  level = 0;
  play = false;
  st1 = loadImage("SpaceGameStart.png");
  go1 = loadImage("SpaceGameOver.png");
  Blast = new SoundFile(this,"laser.wav");
  Upgrade = new SoundFile(this,"ding.wav");
}

void draw() {
  background(20);
  //Distribute stars
  stars.add(new Star());
  for (int i = 0; i < stars.size(); i++) {
    Star star = stars.get(i);
    star.display();
    star.move();
    if (star.reachedBottom()) {
      stars.remove(star);
      i--;
    }
    println("Stars: " + stars.size());
  }
  if (play == false) {
    startScreen();
  } else {
    //Rock Timer
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
    }
    //Powerup Timer
    if (puTimer.isFinished()) {
      powups.add(new Powerups());
      puTimer.start();
    }
    //Display and movement for all rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
      rock.move();
      if (s1.intersect(rock)) {
        rocks.remove(rock);
        i--;
        score-=rock.diam;
        s1.health-=10;
      }
      if (rock.reachedBottom()) {
        rocks.remove(rock);
        i--;
        rocksPassed++;
      }
      println("Rocks: " + rocks.size());
    }
    //Display and movement for all powerups
    for (int i = 0; i < powups.size(); i++) {
      Powerups powup = powups.get(i);
      powup.display();
      powup.move();
      if (powup.intersect(s1)) {
        Upgrade.play();
        if (powup.type == 'l') {
          s1.turretCount++;
          level++;
          score+=(1000*level);
          if (s1.turretCount>5) {
            s1.turretCount = 5;
          }
        } else if (powup.type == 'h') {
          s1.health+=20;
        } else if (powup.type == 'a') {
          s1.laserCount+=20;
        }
        powups.remove(powup);
        i--;
      }
      if (powup.reachedBottom()) {
        powups.remove(powup);
        i--;
      }
      println("Powerups: " + powups.size());
    }
    //Display and movement for all lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j<rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (laser.intersect(r)) {
          score+=150-r.diam;
          lasers.remove(laser);
          r.diam-=20;
          if (r.diam<50) {
            rocks.remove(r);
          }
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
      println("Lasers: " + lasers.size());
    }
    noCursor();
    s1.display();
    s1.move(mouseX, mouseY);
    infoPanel();
    //Game over criteria
    if(s1.health<1) {
      gameOver();
    }
    if(rocksPassed == 5) {
      gameOver();
    }
  }
}

void mousePressed() {
  if (s1.fire()) {
    Blast.play();
    if (s1.turretCount == 1) {
      lasers.add(new Laser(s1.x, s1.y));
    } else if (s1.turretCount == 2) {
      lasers.add(new Laser(s1.x - 5, s1.y));
      lasers.add(new Laser(s1.x + 5, s1.y));
    } else if (s1.turretCount == 3) {
      lasers.add(new Laser(s1.x, s1.y - 10));
      lasers.add(new Laser(s1.x - 10, s1.y));
      lasers.add(new Laser(s1.x + 10, s1.y));
    } else if (s1.turretCount == 4) {
      lasers.add(new Laser(s1.x - 5, s1.y - 10));
      lasers.add(new Laser(s1.x + 5, s1.y - 10));
      lasers.add(new Laser(s1.x - 15, s1.y));
      lasers.add(new Laser(s1.x + 15, s1.y));
    } else if (s1.turretCount == 5) {
      lasers.add(new Laser(s1.x, s1.y - 20));
      lasers.add(new Laser(s1.x - 10, s1.y - 10));
      lasers.add(new Laser(s1.x + 10, s1.y - 10));
      lasers.add(new Laser(s1.x - 20, s1.y));
      lasers.add(new Laser(s1.x + 20, s1.y));
    }
    s1.laserCount--;
  }
}

void infoPanel() {
  //fill(127,127);
  //noStroke();
  //rectMode(CENTER);
  //rect(width/2,height-25,width,50);
  fill(255);
  textSize(30);
  text("Score: " + score, 20, height-15);
  text("Rocks Passed: " + rocksPassed, width-220, height-15);
  text("Health: " + s1.health, width-200, height-55);
  text("Ammo: " + s1.laserCount, 20, height-55);
}
void startScreen() {
  imageMode(CENTER);
  image(st1, 250, 400);
  if(mousePressed) {
    play = true;
  }
}
void gameOver() {
  imageMode(CENTER);
  image(go1, 250, 400);
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("Score: " + score, 250, 500);
  noLoop();
}
