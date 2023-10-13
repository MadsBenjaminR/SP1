// Her definerer jeg variabler
// Jeg har valgt at bruge float til de variabler der har med bevægelighed at gøre, så spillet kører mere flydende
float characterS;
float character;
float wallX;
float wallY;
float wallSpeed;
float wallHeight;
float scoreC;
int counter;
int state=1;

// setup med variable værdier
void setup() {
  size(500, 500);
  background(255);
  character = 50;
  characterS = 0;
  wallX = width-30;
  wallY = 50;
  wallSpeed = 5.5;
  wallHeight = 250;
  counter = 0;
}

// Her laver jeg min reset knap - tilbage til state 1, så spillet kan starte forfra samt reset highscore
void keyPressed() {
  if (key == 'n') {
  state = 1;
  wallX = width;
  counter = 0;
  }
}

//Her laver jeg en metode til visning af highscore
void highScore(){
    textSize(50);
    text("Score: "+counter, 10, 50);
    counter= counter +1;
}

// Selve tegne funktionen
void draw() {

// Så highscoren i state 2 flakker
scoreC = random(255);
  
  // Her definerer jeg hvad der skal ske i state 1 / når spillet kører
  if (state == 1) {
    
    //Her laver jeg en background som overskriver, så fuglen og vægen bliver tegnet på ny hver gennemgang af koden
    background(150);
    
    //initialiserer hiscore metoden
    highScore();
    
    
    // Her tegner jeg fuglen
    fill(255, 0, 0);
    circle(width/6, character, 50);
    
    // Her sætter jeg hvor hurtigt fuglen skal accelerere op og ned
    // Jeg kan ikke forklare hvorfor, men når jeg har tuborgklammerne i dette if else statement, så vil fuglen ikke accelerer op..
    if (mousePressed)
      characterS = characterS-0.15;
    else 
      characterS = characterS+0.15;
      character = character+characterS;
  
    
    
    // Her sørger jeg for at fuglen ikke kan komme "out of bounds"
    if (character < 0){
      character = 0;
    }else if (character > height){
      character = height;
    }
    
    // Her sætter jeg hastighedsgrænsen for fuglen
    if (characterS < -5){
      characterS = -5;
    }else if (characterS > 5){
      characterS = 5;
    }

    // Her laver jeg vægen
    fill(100, 255, 100);
    rect(wallX, wallY, 30, wallHeight);
    
    
    // Her sætter jeg hvor hurtigt vægen kommer mod fuglen
    wallX = wallX - wallSpeed;
    
    // Når vægen rammer enden af banen bliver den sendt tilbage et tilfældigt sted på y-axen og holder hele vægen indenfor banen
    if (wallX < 0) {
      wallX = width;
      wallY = random(0, height-wallHeight+50);
    }
    
    // Collision og gameover skærm
    if (circleRect(50, character, 15, wallX, wallY, 30, 250))
      state = 2;
  } else if (state == 2) {
    background(0);
    fill(255, 0, 0);
    textSize(50);
    text("GAME OVER NOOB!!", 40, 50);
    text("press: 'N' for New Game", 0 , 400);
    fill(scoreC);
    text("Highscore: " + counter, 50, 220);
      
  }
}

// Det her er en Collision detection til processing jeg fandt online efter at have siddet længe med det selv, den bliver brugt i linje 95

// Collision parameter
boolean circleRect(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {

  // temporary variables to set sides for testing
  float testX = cx;
  float testY = cy;

  // test side closeness
  if (cx < rx)         testX = rx;      // vensre side
  else if (cx > rx+rw) testX = rx+rw;   // højre side
  if (cy < ry)         testY = ry;      // top 
  else if (cy > ry+rh) testY = ry+rh;   // bund

  // get distance from closest side
  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the radius, collision!
  if (distance <= radius) {
    return true;
  }
  return false;
}
