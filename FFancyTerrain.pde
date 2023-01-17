class FFancyTerrain extends FGameObject{
  float x, y;
  PImage[] imgs;
  float frame;
  int life;
  
  FFancyTerrain(float x, float y, PImage[] imgs, int n){
    super();
    setPosition(x, y);
    setName("lava");
    setStatic(true); 
    this.x=x; 
    this.y=y;
    this.imgs=imgs;
    frame=n;
  }
  
  void act(){
     attachImage(imgs[(int)frame%6]);
     frame+=0.2;
  }
}
