class FPlayer extends FBox{
  
  FPlayer(){
    super(gridSize, gridSize);
    setPosition(300, 0);
    setFillColor(red);
  }
  
  void act(){
    int speed=200;
    float vy=getVelocityY();
    float vx=getVelocityX();
     if(akey){
      setVelocity(-speed, vy);
    }
    if(dkey){
      setVelocity(speed, vy);
    }
    if(skey){
      setVelocity(vx, speed);
    }
    if(wkey){
      setVelocity(vx, -speed);
    }
  }
  
  void show(){
  }
}
