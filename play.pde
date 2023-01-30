void play() {
  drawWorld(world);
  actWorld();
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
    FGameObject hb=hammerbros.get(i);
    hb.act();
  }

  if (player.live<1||player2.live<1) {
    mode=GAMEOVER;
  }

  if (player.onSwirl&&player2.onSwirl) {
    mode=COINWORLD;
    player.onSwirl=false;
    player2.onSwirl=false;
  }
}
