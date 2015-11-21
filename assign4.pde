final int GAME_START=1, GAME_RUN=2,GAME_OVER=3;
final int ATTACK1=1,ATTACK2=2,ATTACK3=3;
final int numFlame=5;
int currentFlame;
int GAME_STATE;
int ATTACK_TYPE;

PImage bg1,bg2,enemy,fighter,hp,treasure,start1,start2,end1,end2;
PImage []flame=new PImage [5];
float hpx,tx,ty,bg1x,bg2x,bg3x;
float fighterX;
float fighterY;
float fighterSpeed = 5;
float enemyX []=new float[18];
float enemyY []=new float[18];
int nbrEnemy= 8;
float enemySpace=80;
float enemyStartY=random(420);
float flameX;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean [] hitFighter =new boolean[18];

void setup () {
   
  size(640, 480) ;
  
  for(int i=0;i<5;i++){
  flame[i] = loadImage("img/flame"+(i+1)+".png");
  }
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  
  currentFlame=0;
  GAME_STATE = GAME_START;
  ATTACK_TYPE = ATTACK1;
  frameRate(60);
  hpx = 45;
  tx = floor(random(600));
  ty = floor(random(0,440));
  
  bg1x = 0;
  bg2x = 0;
  bg3x = 0;
  fighterX = width -50;
  fighterY = height/2;
  
  for(int i=0;i<5;i++){
  enemyX[i]=i*enemySpace;
  }
  for(int i=5;i<10;i++){
  enemyX[i]=(i-5)*enemySpace;  
  flameX=enemyX[i];
  }
  for(int i=10;i<18;i++){
    if (i<15 ){
    enemyX[i]=(i-10)*enemySpace;
    }else{
    enemyX[i]=(i-14)*enemySpace;
    } 
  }
  
  for(int i=0;i<18;i++){
    hitFighter[i]=false;
  }
  

}

void draw() {
  
  switch(GAME_STATE){
  
    case GAME_START:
      image(start2,0,0);
      if(mouseX>208 && mouseX<458 && mouseY>374 && mouseY<416){
      image(start1,0,0);
        if(mousePressed && mouseButton == LEFT){
        GAME_STATE = GAME_RUN;
        }
      }
      break;
     
    case GAME_RUN:
    
      //***background***
      image(bg1,bg1x,0); 
      bg1x+=2;
      bg1x%=1280;
      image(bg2,bg2x-640,0);
      bg2x+=2;
      bg2x%=1280;
      image(bg1,bg3x-1280,0);
      bg3x+=2;
      bg3x%=1280;
      
      //fighter
      
      image(fighter,fighterX,fighterY);
      
      if (upPressed) {
        fighterY -= fighterSpeed;
      }
      if (downPressed) {
        fighterY += fighterSpeed;
      }
      if (leftPressed) {
        fighterX -= fighterSpeed;
      }
      if (rightPressed) {
        fighterX += fighterSpeed;
      }

      //fighter boundary
      if (fighterX > width -50){
        fighterX = width -50;
      }
      if (fighterX < 0){
        fighterX = 0;
      }
      if (fighterY > height -50){
        fighterY = height -50;
      }
      if (fighterY < 0){
        fighterY = 0;
      }
      
          
      //hp

      rectMode(CORNERS);  
      rect(5,5,hpx,27); //content
      fill(255,0,0);
      image(hp,0,0); //frame
      
  
      //treasure
      image(treasure,tx,ty);
      if(fighterX <= tx +40 && fighterX >= tx -40
      && fighterY <= ty +40 && fighterY >= ty -40){
      hpx = hpx +20;
      tx = floor(random(600));
      ty = floor(random(0,440));
      } 
      if(hpx > 205){
      hpx = 205;
      }

      
      //enemy
      
      switch(ATTACK_TYPE){
       
        case ATTACK1:
        
         
        for(int i =0;i<5;i++){
        if(hitFighter[i]==false)  {
        
        enemyX[i]+=3;
        enemyY[i]=enemyStartY;
        image(enemy,enemyX[i]-380,enemyY[i]);
        }
     //hit fighter
        if(fighterX <= enemyX[i] +50-380 && fighterX >= enemyX[i] -50-380
         && fighterY <= enemyY[i] +50 && fighterY >= enemyY[i] -50){
        
         hpx-=40;
         hitFighter[i]=true;
         enemyX[i]=enemyX[i]-3000;
         flameX= enemyX[i]+3000;
         }
         
         if(hitFighter[i]){
          if(frameCount % (60/10)==0){
           currentFlame++;
           if(currentFlame>4){currentFlame=0;hitFighter[i]=false;}

         image(flame[currentFlame],flameX-380,enemyY[i]);
         }
         }
        
         
        
        if(enemyX[i]>1400){
        ATTACK_TYPE=ATTACK2;
        enemyStartY=random(300);
        }
        
        }
       
        break;
        
        case ATTACK2:
        for(int i =5;i<10;i++){
         if(hitFighter[i]==false)  {
         image(enemy,enemyX[i]-380,enemyY[i]);
         enemyX[i]+=3;
         enemyY[i]=enemyStartY+30*(i-5);
        }
           
        //hit fighter   
        if(fighterX <= enemyX[i] +50-380 && fighterX >= enemyX[i] -50-380
        && fighterY <= enemyY[i] +50 && fighterY >= enemyY[i] -50){
        
        hpx-=40;
        hitFighter[i]=true;
        enemyX[i]=enemyX[i]-3000;
        flameX= enemyX[i]+3000;
        }
        if(hitFighter[i]){
         if(frameCount % (60/10)==0){
          currentFlame++;
          if(currentFlame>4){currentFlame=0;hitFighter[i]=false;}
         }
         image(flame[currentFlame],flameX-380,enemyY[i]);
        }
      
        
        
        if(enemyX[i]>1400){
        ATTACK_TYPE=ATTACK3;
        
        enemyStartY=random(140,340);
        }
        }
        break;
        
        case ATTACK3:
        
        for(int i =10;i<18;i++){
          
        if(fighterX <= enemyX[i] +50-380 && fighterX >= enemyX[i] -50-380
        && fighterY <= enemyY[i] +50 && fighterY >= enemyY[i] -50){
        
        hpx-=40;
        hitFighter[i]=true;
        enemyX[i]=enemyX[i]-3000;
        flameX= enemyX[i]+3000;
        }
         
         if(hitFighter[i]){
         if(frameCount % (60/10)==0){
          currentFlame++;
          if(currentFlame>4){currentFlame=0;hitFighter[i]=false;}
         }
         image(flame[currentFlame],flameX-380,enemyY[i]);
        }
          

         if(i<15){
          if(i<13){
           enemyY[i]=enemyStartY-40*(i-10);
           }else{
           enemyY[i]=enemyY[12]+40*(i+1-13);
           }
         }
         if(i>=15){
           if(i<17){
           enemyY[i]=enemyStartY+40*(i-14);
           }else{
           enemyY[i]=enemyY[16]-40;
           }
         }
          image(enemy,enemyX[i]-380,enemyY[i]);
          enemyX[i]+=3;
          
          
          
          if(enemyX[i]>1400){
              ATTACK_TYPE=ATTACK1;
              for(int j=0;j<5;j++){
              enemyX[j]=j*enemySpace;
              enemyY[j]=random(420);
              }
              for(int j=5;j<10;j++){
              enemyX[j]=(j-5)*enemySpace;  
              }
              for(int j=10;j<18;j++){
                if (j<15 ){
                enemyX[j]=(j-10)*enemySpace;
                }else{
                enemyX[j]=(j-14)*enemySpace;
                } 
              }

              enemyStartY=floor(random(0,420));
          }//if
        
        }//for

        }//swich ATTACK
        if(hpx<10){GAME_STATE=GAME_OVER;}
        
        
        
  
         
        break;
          
           
 
        
  case GAME_OVER:
    
      image(end2,0,0);
      
      if(mouseX>208 && mouseX<434 && mouseY>310 && mouseY<346){
      image(end1,0,0);
      
        if(mousePressed && mouseButton == LEFT){
        //reset data

          hpx = 45;
          tx = floor(random(600));
          ty = floor(random(0,440));
          
          bg1x = 0;
          bg2x = 0;
          bg3x = 0;
          fighterX = width -50;
          fighterY = height/2;
          
          for(int i=0;i<5;i++){
          enemyX[i]=i*enemySpace;
          enemyY[i]=random(420);
          hitFighter[i]=false;
          }
          for(int i=5;i<10;i++){
          enemyX[i]=(i-5)*enemySpace;  
          hitFighter[i]=false;
          }
          for(int i=10;i<18;i++){
            if (i<15 ){
            enemyX[i]=(i-10)*enemySpace;
            }else{
            enemyX[i]=(i-14)*enemySpace;
            } 
            hitFighter[i]=false;
          }
          
          for(int i=0;i<5;i++){
          enemyY[i]=enemyStartY;
          }
        GAME_STATE = GAME_RUN;
        ATTACK_TYPE = ATTACK1;
        }// if(mousePressed && mouseButton == LEFT)
        }//if(mouseX>208 && mouseX<434 && mouseY>310 && mouseY<346)
        break;
        
     
  
 }//switch GAMESTATE
}//void
void keyPressed(){
  if (key == CODED) { // detect special keys 
      switch (keyCode) {
        case UP:
          upPressed = true;
          break;
        case DOWN:
          downPressed = true;
          break;
        case LEFT:
          leftPressed = true;
          break;
        case RIGHT:
          rightPressed = true;
          break;
    
      }
  }
}
void keyReleased(){
  if (key == CODED) {
      switch (keyCode) {
        case UP:
          upPressed = false;
          break;
        case DOWN:
          downPressed = false;
          break;
        case LEFT:
          leftPressed = false;
          break;
        case RIGHT:
          rightPressed = false;
          break;
      }
    }
}
