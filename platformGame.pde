import fisica.*; //<>// //<>//
FWorld world;

final int INTRO=0;
final int PLAY=1;
final int GAMEOVER=2;
int mode=GAMEOVER;

ArrayList<FGameObject> terrains;
ArrayList<FFancyTerrain> lavaList;
ArrayList<FGameObject> goombas;
ArrayList<FThwomp> thwomps;
ArrayList<FHammerBro> hammerbros;

ArrayList<Gif> gif=new ArrayList<Gif>();
ArrayList<Button> myButton=new ArrayList<Button>();

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

PImage iceblock, brick, lefttree, righttree, centertree, intersectionimg, trunkimg;
PImage water1, water2, water3, water4;
PImage spike;
PImage bridge;
PImage trampoline;

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

boolean mouseReleased=false;
boolean wasPressed=false;
boolean player1win=false;

FPlayer player, player2;

void setup() {
  size(600, 600);
  terrains=new ArrayList<FGameObject>();
  lavaList=new ArrayList<FFancyTerrain>();
  goombas=new ArrayList<FGameObject>();
  thwomps=new ArrayList<FThwomp>();
  hammerbros=new ArrayList<FHammerBro>();

  gif.add(new Gif("mario_gif", "frame_", "_delay-0.1s.gif", 36, 0, 0, width, height, 4));
  myButton.add(new Button("Start", width/2, height/2+100, 100, 50, yellow, green));
  myButton.add(new Button("Replay", width/2, height/2+100, 100, 50, yellow, green));

  loadImages();
  loadMap(map);
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
  run[1]=loadImage("data/character/runright1.png");
  run[2]=loadImage("data/character/runright2.png");
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
  
  heart=loadImage("data/heart.png");
  heart.resize(30, 30);
}
