import fisica.*; //<>//
FWorld world;

ArrayList<FGameObject> terrains;
ArrayList<FFancyTerrain> lavaList;
ArrayList<FGameObject> enemies;

color white=#FFFFFF;
color black=#000000;
color blue=#0000FF;
color green=#00ff00;
color intersection=#402500;
color trunk=#ab6100;
color cyan=#00fbff;
color red=#ff0000;
color waterblue=#00b7ef;
color purp=#6f3198;
color pink=#ffa3b1;
color yellow=#fff200;
color brown=#9c5a3c;
color lightPurp=#b5a5d5;

PImage map;
int gridSize=32;
float zoom=1.5;

int count=0;

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

int wallCount=0;

boolean[] keys=new boolean[10];

PImage iceblock, brick, lefttree, righttree, centertree, intersectionimg, trunkimg;
PImage water1, water2, water3, water4;
PImage spike;
PImage bridge;
PImage trampoline;

PImage[] thwomp=new PImage[2];

PImage[] lavas=new PImage[6];

PImage[] action;
PImage[] run=new PImage[3];
PImage[] idle=new PImage[2];
PImage[] jump=new PImage[1];
PImage[] goomba =new PImage[2];

FPlayer player, player2;

void setup() {
  size(600, 600);
  terrains=new ArrayList<FGameObject>();
  lavaList=new ArrayList<FFancyTerrain>();
  enemies=new ArrayList<FGameObject>();
  loadImages();
  loadMap(map);
  loadPlayer();
}

void draw() {
  background(white);
  drawWorld();
  actWorld();
}

void drawWorld() {
  pushMatrix();
  fill(black);
  textSize(30);
  text("red: "+player.live, 100, 100);
  text("blue: "+player2.live, 100, 200);
  float xdistance=Math.abs(player.getX()-player2.getX());
  float ydistance=Math.abs(player.getY()-player2.getY());
  zoom=15/(xdistance+ydistance)*10+0.3;
  translate(-abs((min(player.getX(), player2.getX()))+xdistance/2)*zoom+width/2, -abs(min(player.getY(), player2.getY())+ydistance/2)*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}

void actWorld() {
  player.act();
  player.show();
  player2.act();
  player2.show();
  for (int i=0; i<terrains.size(); i++) {
    FGameObject t=terrains.get(i);
    t.act();
  }
  for (int i=0; i<enemies.size(); i++) {
    FGameObject t=enemies.get(i);
    t.act();
  }
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
  water1=loadImage("data/water1.png");
  water2=loadImage("data/water2.png");
  water3=loadImage("data/water3.png");
  water4=loadImage("data/water4.png");
  spike=loadImage("data/spike.png");
  bridge=loadImage("data/bridge_center.png");
  for (int i=0; i<6; i++) {
    lavas[i]=loadImage("data/lava/lava"+i+".png");
  }
  trampoline=loadImage("data/trampline.png");

  jump[0]=loadImage("data/character/jump0.png");
  idle[0]=loadImage("data/character/idle0.png");
  idle[1]=loadImage("data/character/idle1.png");
  run[0]=loadImage("data/character/runleft0.png");
  run[0]=loadImage("data/character/runleft0.png");
  run[1]=loadImage("data/character/runleft1.png");
  run[2]=loadImage("data/character/runleft2.png");
  goomba[0]=loadImage("data/goomba/goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1]=loadImage("data/goomba/goomba1.png");
  goomba[1].resize(gridSize, gridSize);
  action=idle;
  thwomp[0]=loadImage("data/thwomp/thwomp0.png");
  thwomp[1]=loadImage("data/thwomp/thwomp1.png");
}

void loadPlayer() {
  player=new FPlayer(red, 0, 5);
  player2=new FPlayer(blue, 1, 5);
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
        createBlocks(i, j, true, 3, brick, false, "brick", 0);
      } else if (c==brown) {
        wallCount++;
        createBlocks(i, j, true, 3, brick, false, "wall", 0);
        if (wallCount%2==1) {
          FGoomba goombaTemp=new FGoomba(i*gridSize+gridSize*2, j*gridSize);
          enemies.add(goombaTemp);
          world.add(goombaTemp);
        }
      } else if (c==cyan) {
        createBlocks(i, j, true, 0, iceblock, false, "ice", 0);
      } else if (c==purp) {
        createBlocks(i, j, true, 10, spike, false, "spike", 0);
      } else if (c==red) {
        FBridge br=new FBridge(i*gridSize, j*gridSize);
        terrains.add(br);
        world.add(br);
      } else if (c==pink) {
        FFancyTerrain la=new FFancyTerrain(i*gridSize, j*gridSize, lavas, count);
        count++;
        terrains.add(la);
        world.add(la);
      } else if (c==lightPurp) {
         int thwompi=(int) j-5;
         /*while (map.get(i, thwompi)!=black) {
           i--;
         }*/
        FThwomp th=new FThwomp(i*gridSize, j*gridSize, thwompi, thwomp);
        //enemies.add(th);
        //world.add(th);
      } else if (c==yellow) {
        createBlocks(i, j, true, 0, trampoline, false, "trampoline", 3);
      } else if (c==trunk) {
        createBlocks(i, j, true, 0, trunkimg, true, "trunk", 0);
      } else if (c==intersection) {
        createBlocks(i, j, true, 0, intersectionimg, true, "intersection", 0);
      } else if (c==green) {
        checkTrees(i, j);
      }
    }
  }
}

void createBlocks(int i, int j, boolean isStatic, int friction, PImage img, boolean needSensor, String name, int r) {
  FBox b=new FBox(gridSize, gridSize);
  b.setPosition(gridSize*i, gridSize*j);
  b.setStatic(isStatic);
  b.setFriction(friction);
  b.attachImage(img);
  b.setSensor(needSensor);
  b.setRestitution(r);
  b.setName(name);
  world.add(b);
}

void checkTrees(int i, int j) {
  if (map.get(i-1, j)==intersection||map.get(i+1, j)==intersection) {
    createBlocks(i, j, true, 3, centertree, false, "tree", 0);
    return;
  } else if (map.get(i-1, j)==intersection||map.get(i+1, j)==intersection) {
    createBlocks(i, j, true, 3, centertree, false, "tree", 0);
    return;
  } else if (map.get(i-1, j)==green&&map.get(i+1, j)==green) {
    createBlocks(i, j, true, 3, centertree, false, "tree", 0);
    return;
  } else if (map.get(i-1, j)!=green&&map.get(i+1, j)==green) {
    createBlocks(i, j, true, 3, lefttree, false, "tree", 0);
    return;
  } else if (map.get(i-1, j)==green&&map.get(i+1, j)!=green) {
    createBlocks(i, j, true, 3, righttree, false, "tree", 0);
    return;
  }
}
