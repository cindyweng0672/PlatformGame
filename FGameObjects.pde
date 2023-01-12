class FGameObject extends FBox {
  FGameObject() {
    super(gridSize, gridSize);
  }
  
  void act(){
    
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
  
  /*void checkReturn(color c) {
    if (map.get((int)x+1, (int)y)==c||map.get((int)x-1, (int)y)==c) {
      x=getX();
      y=getY();
    }
  }*/
}
