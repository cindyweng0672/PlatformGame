class FGameObject extends FBox {
  final int R=1;
  final int L=-1;

  FGameObject(int gs) {
    super(gs, gs);
  }

  void act() {
  }

  boolean isTouching(String str) {
    ArrayList<FContact> contacts=getContacts();
    for (int i=0; i<contacts.size(); i++) {
      FContact fc=contacts.get(i);
      if (fc.contains(str)) {
        return true;
      }
    }
    return false;
  }

  void animate(int frame, int l, int direction, PImage[] arr) {
    if (frame>=arr.length) {
      frame=0;
    }

    if (frameCount%l==0) {
      if (direction==L) {
        PImage temp=reverseImage(arr[frame]);
        attachImage(temp);
      } else {
        attachImage((arr[frame]));
      }
      frame++;
    }
  }

  void touchingPlayer(FPlayer p, ArrayList<FGameObject> list) {
    if (isTouching("player")) {
      if (p.getY()<getY()-gridSize/2) {
        list.remove(this);
        world.remove(this);
      } else {
        list.remove(this);
        world.remove(this);
        p.live--;
      }
    }
  }

  void moving(int direction, int speed) {
    if (isTouching("wall")) {
      direction*=-1;
      setPosition(getX()+direction, getY());
    }

    float vy=getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
