void coinWorld() { //<>//
  drawWorld(coinWorld);
  actCoinWorld();
  if (player.onSwirl2&&player2.onSwirl2) {
    mode=GAMEOVER;
    player.onSwirl2=false;
    player2.onSwirl2=false;
  }
}

void actCoinWorld() {
  player.act();
  player.show();

  player2.act();
  player2.show();

  for (int i=0; i<coins.size(); i++) {
    coins.get(i).act();
  }
}
