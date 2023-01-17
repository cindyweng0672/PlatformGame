import fisica.*; //<>//
FWorld world;

ArrayList<FGameObject> terrains;
ArrayList<FLava> lavaList;

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

boolean[] keys=new boolean[10];

PImage iceblock, brick, lefttree, righttree, centertree, intersectionimg, trunkimg;
PImage water1, water2, water3, water4;
PImage spike;
PImage bridge;
PImage trampoline;

PImage[] lavas=new PImage[6];

PImage[] currentarr;
PImage[] run=new PImage[6]; 
PImage[] idle=new PImage[2]; 
PImage[] jump=new PImage[1];

FPlayer player, player2;

void setup() {
  size(600, 600);
  terrains=new ArrayList<FGameObject>();
  lavaList=new ArrayList<FLava>();
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
  zoom=1+10/(xdistance+ydistance);
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
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
      } else if (c==cyan) {
        createBlocks(i, j, true, 0, iceblock, false, "ice", 0);
      } else if (c==purp) {
        createBlocks(i, j, true, 10, spike, false, "spike", 0);
      } else if (c==red) {
        FBridge br=new FBridge(i*gridSize, j*gridSize);
        terrains.add(br);
        world.add(br);
      } else if (c==pink) {
        FLava la=new FLava(i*gridSize, j*gridSize, lavas, count);
        count++;
        terrains.add(la);
        world.add(la);
      } else if(c==yellow){
        createBlocks(i, j, true, 0, trampoline, false, "trampoline", 3);
      }else if (c==trunk) {
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
  } else if (map.get(i-1, j)!=green&&map.get(i+1, j)==green) {
    createBlocks(i, j, true, 3, lefttree, false, "tree", 0);
    return;
  } else if (map.get(i-1, j)==green&&map.get(i+1, j)!=green) {
    createBlocks(i, j, true, 3, righttree, false, "tree", 0);
    return;
  }
}
