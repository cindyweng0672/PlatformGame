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
    } else {
      if (frameCount%l==0) {
        if (direction==R) {
          attachImage(reverseImage(arr[frame]));
        }else {
          attachImage((arr[frame]));
        }
        frame++;
      }
    }
  }
}
