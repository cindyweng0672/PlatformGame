void coinWorld() {
  background(black);
  drawWorld(coinWorld);
  actCoinWorld();
}

void actCoinWorld() {
  player.act();
  player.show();

  player2.act();
  player2.show();

  for (int i=0; i<coins.size(); i++) {
    coins.get(i).act();
  }

  changeRoom();
}
