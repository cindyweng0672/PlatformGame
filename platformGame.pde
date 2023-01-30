import fisica.*;
FWorld world;
FWorld coinWorld;

final int INTRO=0;
final int PLAY=1;
final int GAMEOVER=2;
final int COINWORLD=3;
int mode=INTRO;

ArrayList<FGameObject> terrains;
ArrayList<FFancyTerrain> lavaList;
ArrayList<FGameObject> goombas;
ArrayList<FThwomp> thwomps;
ArrayList<FGameObject> hammerbros;

ArrayList<Gif> gif=new ArrayList<Gif>();
ArrayList<Button> myButton=new ArrayList<Button>();

ArrayList<Coin> coins=new ArrayList<Coin>();

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
color grey=#b4b4b4;
color beigeBlue=#99d9ea;
color darkBlue=#0011ff;
color yGreen=#a6e61d;
color hotPink=#ff00ea;

PImage map;
PImage heart;
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
int hammerWallCount=0;

boolean[] keys=new boolean[10];

PFont pixelFont;

PImage iceblock, brick, lefttree, righttree, centertree, intersectionimg, trunkimg;
PImage water1, water2, water3, water4;
PImage spike;
PImage bridge;
PImage trampoline;
PImage swirl;

PImage[] thwomp=new PImage[2];

PImage[] lavas=new PImage[6];

PImage[] marioGif=new PImage[4];

PImage[] action;
PImage[] run=new PImage[3];
PImage[] idle=new PImage[2];
PImage[] jump=new PImage[1];
PImage[] goomba =new PImage[2];
PImage[] hammerbro=new PImage[2];
PImage hammer;
PImage coinMap;
PImage coinImg;

boolean mouseReleased=false;
boolean wasPressed=false;

FPlayer player, player2;

void setup() {
  size(600, 600);
  Fisica.init(this);
  world=new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 980);

  Fisica.init(this);
  coinWorld=new FWorld(-2000, -2000, 2000, 2000);
  coinWorld.setGravity(0, 980);

  terrains=new ArrayList<FGameObject>();
  lavaList=new ArrayList<FFancyTerrain>();
  goombas=new ArrayList<FGameObject>();
  thwomps=new ArrayList<FThwomp>();
  hammerbros=new ArrayList<FGameObject>();

  pixelFont=createFont("data/8_bit_arcade/8-bit_Arcade_In.ttf", 30);

  gif.add(new Gif("mario_gif", "frame_", "_delay-0.1s.gif", 36, 0, 0, width, height, 4));
  myButton.add(new Button("Start", width/2, height/2+100, 100, 50, yellow, green));
  myButton.add(new Button("Replay", width/2, height/2+100, 100, 50, yellow, green));

  loadImages();
  loadMap(map, world);
  loadMap(coinMap, coinWorld);
  loadPlayer();
}

void draw() {
  click();

  background(white);
  if (mode==PLAY) {
    play();
  } else if (mode==INTRO) {
    intro();
  } else if (mode==GAMEOVER) {
    gameover();
  } else if (mode==COINWORLD) {
    coinWorld();
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
  run[0]=loadImage("data/character/runright0.png");
  run[2]=loadImage("data/character/runright1.png");
  run[1]=loadImage("data/character/runright2.png");
  goomba[0]=loadImage("data/goomba/goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1]=loadImage("data/goomba/goomba1.png");
  goomba[1].resize(gridSize, gridSize);
  action=idle;
  thwomp[0]=loadImage("data/thwomp/thwomp0.png");
  thwomp[1]=loadImage("data/thwomp/thwomp1.png");
  hammerbro[1]=loadImage("data/hammerBro/hammerbro0.png");
  hammerbro[0]=loadImage("data/hammerBro/hammerbro1.png");
  hammer=loadImage("data/hammerBro/hammer.png");
  marioGif[0]=loadImage ("data/mario_gif/frame_0_delay-0.1s.gif");
  marioGif[1]=loadImage ("data/mario_gif/frame_1_delay-0.1s.gif");
  marioGif[2]=loadImage ("data/mario_gif/frame_2_delay-0.1s.gif");
  marioGif[3]=loadImage ("data/mario_gif/frame_3_delay-0.1s.gif");

  coinMap=loadImage("data/coinMap.png");
  coinImg=loadImage("data/coin.png");
  coinImg.resize(gridSize, gridSize);

  heart=loadImage("data/heart.png");
  heart.resize(30, 30);

  swirl=loadImage("data/swirl.png");
  swirl.resize(gridSize*2, gridSize*2);
}

void loadPlayer() {
  player=new FPlayer(red, 0, 5, "player");
  player2=new FPlayer(blue, 1, 5, "player");
  world.add(player);
  world.add(player2);
  coinWorld.add(player);
  coinWorld.add(player2);
}

void loadMap(PImage m, FWorld w) {
  for (int i=0; i<m.width; i++) {
    for (int j=0; j<m.height; j++) {
      color c=m.get(i, j);
      if (c==black) {
        createBlocks(gridSize, i, j, true, 3, brick, false, "brick", 0, w);
      } else if (c==brown) {
        wallCount++;
        createBlocks(gridSize, i, j, true, 3, brick, false, "wall", 0, w);
        if (wallCount%2==1) {
          FGoomba goombaTemp=new FGoomba(i*gridSize+gridSize*2, j*gridSize);
          goombas.add(goombaTemp);
          w.add(goombaTemp);
        }
      } else if (c==cyan) {
        createBlocks(gridSize, i, j, true, 0, iceblock, false, "ice", 0, w);
      } else if (c==purp) {
        createBlocks(gridSize, i, j, true, 10, spike, false, "spike", 0, w);
      } else if (c==red) {
        FBridge br=new FBridge(i*gridSize, j*gridSize);
        terrains.add(br);
        w.add(br);
      } else if (c==pink) {
        FFancyTerrain la=new FFancyTerrain(i*gridSize, j*gridSize, lavas, count);
        count++;
        terrains.add(la);
        w.add(la);
      } else if (c==lightPurp) {
        FThwomp th=new FThwomp(i*gridSize, j*gridSize, thwomp);
        thwomps.add(th);
        w.add(th);
      } else if (c==darkBlue) {
        createBlocks(gridSize*2, i, j, true, 20, swirl, true, "swirl", 0, w);
      } else if (c==waterblue) {
        createBlocks(gridSize*2, i, j, true, 20, swirl, true, "swirl2", 0, w);
      } else if (c==beigeBlue) {
        hammerWallCount++;
        createBlocks(gridSize, i, j, true, 3, brick, false, "wall", 0, w);
        if (hammerWallCount%2==1) {
          FHammerBro hb=new FHammerBro(i*gridSize+gridSize*2, j*gridSize, hammer, w);
          hammerbros.add(hb);
          w.add(hb);
        }
      } else if (c==yellow) {
        createBlocks(gridSize, i, j, true, 0, trampoline, false, "trampoline", 2, w);
      } else if (c==grey) {
        createBlocks(i, j, white, true, "thwopdetect", w);
      } else if (c==trunk) {
        createBlocks(gridSize, i, j, true, 0, trunkimg, true, "trunk", 0, w);
      } else if (c==intersection) {
        createBlocks(gridSize, i, j, true, 0, intersectionimg, true, "intersection", 0, w);
      } else if (c==green) {
        checkTrees(i, j, w);
      } else if (c==hotPink) {
        Coin tempC=new Coin(i, j, coinImg, w);
        coins.add(tempC);
        w.add(tempC);
      }
    }
  }
}

void createBlocks(int size, int i, int j, boolean isStatic, int friction, PImage img, boolean needSensor, String name, int r, FWorld w) {
  FBox b=new FBox(gridSize, gridSize);
  b.setPosition(gridSize*i, gridSize*j);
  b.setStatic(isStatic);
  b.setFriction(friction);
  b.attachImage(img);
  b.setSensor(needSensor);
  b.setRestitution(r);
  b.setName(name);
  w.add(b);
}

void createBlocks(int i, int j, color c, boolean sensor, String name, FWorld w) {
  FBox b=new FBox(gridSize, gridSize);
  b.setPosition(gridSize*i, gridSize*j);
  b.setFillColor(c);
  b.setSensor(sensor);
  b.setName(name);
  w.add(b);
}

//check map/coinMap
void checkTrees(int i, int j, FWorld w) {
  if (map.get(i-1, j)==intersection||map.get(i+1, j)==intersection) {
    createBlocks(gridSize, i, j, true, 3, centertree, false, "tree", 0, w);
    return;
  } else if (map.get(i-1, j)==intersection||map.get(i+1, j)==intersection) {
    createBlocks(gridSize, i, j, true, 3, centertree, false, "tree", 0, w);
    return;
  } else if (map.get(i-1, j)==green&&map.get(i+1, j)==green) {
    createBlocks(gridSize, i, j, true, 3, centertree, false, "tree", 0, w);
    return;
  } else if (map.get(i-1, j)!=green&&map.get(i+1, j)==green) {
    createBlocks(gridSize, i, j, true, 3, lefttree, false, "tree", 0, w);
    return;
  } else if (map.get(i-1, j)==green&&map.get(i+1, j)!=green) {
    createBlocks(gridSize, i, j, true, 3, righttree, false, "tree", 0, w);
    return;
  }
}


void drawWorld(FWorld w) {
  background(black);
  pushMatrix();
  fill(black);
  textSize(30);

  textFont(pixelFont);
  fill(white);
  text("player1: ", 100, 100);

  for (int i=0; i<player.live; i++) {
    image(heart, 220+i*20, 80);
  }

  text("player2: ", 100, 200);

  for (int i=0; i<player2.live; i++) {
    image(heart, 220+i*20, 180);
  }

  float xdistance=Math.abs(player.getX()-player2.getX());
  float ydistance=Math.abs(player.getY()-player2.getY());
  zoom=15/(xdistance+ydistance)*10+0.3;
  translate(-abs((min(player.getX(), player2.getX()))+xdistance/2)*zoom+width/2, -abs(min(player.getY(), player2.getY())+ydistance/2)*zoom+height/2);
  scale(zoom);
  w.step();
  w.draw();
  popMatrix();
}
