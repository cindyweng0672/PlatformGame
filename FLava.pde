class FLava extends FGameObject{
  float x, y;
  PImage[] lavas;
  float frame;
  int life;
  
  FLava(float x, float y, PImage[] lavas, int n){
    super();
    setPosition(x, y);
    setName("lava");
    setStatic(true); 
    this.x=x; 
    this.y=y;
    this.lavas=lavas;
    frame=n;
  }
  
  void act(){
     attachImage(lavas[(int)frame%6]);
     frame+=0.2;
  }
}
