class Gif {
  PImage[] gif;
  int n;
  String prefix;
  String suffix;

  int frame;

  int x, y;
  int w, h;
  int speed;

  String folderName;

  Gif(String folderName, String prefix, String suffix, int n, int x, int y, int w, int h, int speed) {
    this.n=n;
    this.prefix=prefix;
    this.suffix=suffix;
    gif=new PImage[n];

    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.speed=speed;

    this.folderName=folderName;

    frame=0;

    for (int i=0; i<n; i+=1) {
      gif[i]=loadImage("data/"+folderName+"/"+prefix+i+suffix);
    }
  }

  void act() {
    image(gif[frame], x, y, w, h);
    if (frameCount%speed==0) {
      frame+=1;
      if (frame>=n-1) {
        frame=0;
      }
    }
  }

  void show() {
  }
}
