import fisica.*; //<>//
FWorld world;

color white=#FFFFFF;
color black=#000000;
color red=#FF0000;
color blue=#0000FF;

color cyan=#00ffff;
color centerGreen=#00ff00;
color leftGreen=#a6e61d;
color rightGreen=#00df97;
color intersection=#402500;
color trunk=#ab6100;

PImage map;
int gridSize=32;
float zoom=1.5;

int akey=0;
int dkey=1;
int wkey=2;
int skey=3;
int spacekey=4;

int leftkey=5;
int rightkey=6;
int upkey=7;
int downkey=8;
int enterkey=9;

boolean[] keys=new boolean[10];

PImage iceblock, brick, lefttree, righttree, centertree, intersectionimg, trunkimg;

FPlayer player, player2;

void setup() {
  size(600, 600);
  loadImages();
  loadMap(map);
  loadPlayer();
}

void draw() {
  background(white);
  drawWorld();
  player.act();
  player.show();
  player2.act();
  player2.show();
}

void drawWorld() {
  pushMatrix();
  float xdistance=Math.abs(player.getX()-player2.getX());
  float ydistance=Math.abs(player.getY()-player2.getY());
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}

void loadImages() {
  map=loadImage("data/map.png");
  brick=loadImage("data/brick.png");
  iceblock=loadImage("data/blueBlock.png");
  trunkimg=loadImage("data/tree_trunk.png");
  centertree=loadImage("data/treetop_center.png");
  lefttree=loadImage("data/treetop_w.png");
  righttree=loadImage("data/treetop_e.png");
  intersectionimg=loadImage("data/tree_intersect.png");
}

void loadPlayer() {
  player=new FPlayer(red, 0);
  player2=new FPlayer(blue, 1);
  world.add(player);
  world.add(player2);
}

void loadMap(PImage map) {
  Fisica.init(this);
  world=new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  for (int i=0; i<map.width; i++) {
    for (int j=0; j<map.height; j++) {
      color c=map.get(i, j);
      if (c==black) {
        createBlocks(i, j, true, 3, brick, false);
      }
      if (c==cyan) {
        createBlocks(i, j, true, 0, iceblock, false);
      }
      if (c==trunk) {
        createBlocks(i, j, true, 0, trunkimg, true);
      }
      if(c==centerGreen){
        createBlocks(i, j, true, 0, centertree, false);
      }
      if(c==leftGreen){
        createBlocks(i, j, true, 0, lefttree, false);
      }
      if(c==rightGreen){
        createBlocks(i, j, true, 0, righttree, false);
      }
      if(c==intersection){
        createBlocks(i, j, true, 0, intersectionimg, true);
      }
    }
  }
}

void createBlocks(int i, int j, boolean isStatic, int friction, PImage img, boolean needSensor) {
  FBox b=new FBox(gridSize, gridSize);
  b.setPosition(gridSize*i, gridSize*j);
  b.setStatic(isStatic);
  b.setFriction(friction);
  b.attachImage(img);
  b.setSensor(needSensor);
  world.add(b);
}

void checkTrees(int i, int j){
  if(map.get(i, j-1)==trunk){
    createBlocks(i, j, true, 0, intersectionimg, true);
    return;
  }else if(map.get(i-1, j)==green
}
