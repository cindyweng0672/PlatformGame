void play() {
  drawWorld();
  actWorld();
}

void drawWorld() {
  pushMatrix();
  fill(black);
  textSize(30);

  text("player1: ", 100, 100);

  for (int i=0; i<player.live; i++) {
    image(heart, 150+i*20, 80);
  }

  text("player2: ", 100, 200);

  for (int i=0; i<player2.live; i++) {
    image(heart, 150+i*20, 180);
  }

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

  for (int i=0; i<goombas.size(); i++) {
    FGameObject t=goombas.get(i);
    t.act();
  }

  for (int i=0; i<thwomps.size(); i++) {
    FThwomp th=thwomps.get(i);
    th.act();
  }

  for (int i=0; i<hammerbros.size(); i++) {
    FHammerBro hb=hammerbros.get(i);
    hb.act();
  }
  
  if(player.live<=0){
    player1win=true;
  }
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
          goombas.add(goombaTemp);
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
        FThwomp th=new FThwomp(i*gridSize, j*gridSize, thwomp);
        thwomps.add(th);
        world.add(th);
      } else if (c==beigeBlue) {
        //not working (not creating new objects);
        hammerWallCount++;
        createBlocks(i, j, true, 3, brick, false, "wall", 0);
        if (hammerWallCount%2==1) {
          FHammerBro hb=new FHammerBro(i*gridSize+gridSize*2, j*gridSize, hammerbro, hammer);
          hammerbros.add(hb);
          world.add(hb);
        }
      } else if (c==yellow) {
        createBlocks(i, j, true, 0, trampoline, false, "trampoline", 3);
      } else if (c==grey) {
        createBlocks(i, j, white, true, "thwopdetect");
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

void createBlocks(int i, int j, color c, boolean sensor, String name) {
  FBox b=new FBox(gridSize, gridSize);
  b.setPosition(gridSize*i, gridSize*j);
  b.setFillColor(c);
  b.setSensor(sensor);
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
