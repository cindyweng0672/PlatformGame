import fisica.*;
FWorld world;

color white=#FFFFFF;
color black=#000000;
color red=#FF0000;

PImage map;
int gridSize=32;
float zoom=1.5;

boolean akey, dkey, wkey, skey, upkey, downkey, rightkey, leftkey, spacekey;

FPlayer player;

void setup(){
  size(600, 600);
  map=loadImage("map.png");
  loadMap(map);
  loadPlayer();
}

void draw(){
  background(white);
  drawWorld();
  player.act();
  player.show();
}

void drawWorld(){
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}

void loadMap(PImage map){
  Fisica.init(this);
  world=new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  for(int i=0; i<map.width; i++){
    for(int j=0; j<map.height; j++){
      color c=map.get(i, j);
      if(c==black){
        FBox b=new FBox(gridSize, gridSize);
        b.setFillColor(black);
        b.setPosition(gridSize*i, gridSize*j);
        b.setStatic(true);
        world.add(b);
      }
    }
  }
}

void loadPlayer(){
  player=new FPlayer();
  world.add(player);
}
