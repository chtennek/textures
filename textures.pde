PImage img;
PGraphics buffer, output;
int bufferSize = 256;
int outputSize = 1024;
char drawMode = 'e';

// Colors
int c00, c01, c10, c11;

// Parameters
float rotation;
float angle = 360f;
int param = 1;
int tileX = 1;
int tileY = 1;

color[] cycle = {
  color(0), 
  color(255), 
  //color(127), 
};

void setup()
{
  size(256, 256);
  noSmooth();

  // Background image
  buffer = createGraphics(bufferSize, bufferSize);
  output = createGraphics(outputSize, outputSize);
  img = loadImage("LOUDER_Cover.png");
  keyPressed();

  //colorMode(RGB, 8);
}

void draw() {
}

void keyPressed() {

  // Control pattern
  switch (key) {

    // Cycle
  case '1':
    c00 = (c00 + 1) % cycle.length;
    break;
  case '2':
    c01 = (c01 + 1) % cycle.length;
    break;
  case '3':
    c10 = (c10 + 1) % cycle.length;
    break;
  case '4':
    c11 = (c11 + 1) % cycle.length;
    break;

    // Ranges
  case '-':
    param--;
    param = max(1, param - 1);
    break;
  case '=':
    param++;
    break;

  case ']':
    rotation += 45;
    break;
  case '[':
    rotation -= 45;
    break;

  case CODED:
    switch (keyCode) {
    case UP:
      tileX++;
      break;
    case DOWN:
      tileX = max(1, tileX - 1);
      break;
    case RIGHT:
      tileY++;
      break;
    case LEFT:
      tileY = max(1, tileY - 1);
      break;
    }
    break;

    // Presets
  case '0':
    c00 = 0;
    c01 = 0;
    c10 = 0;
    c11 = 0;
    rotation = 0;
    param = 1;
    tileX = 1;
    tileY = 1;
    break;
    
  case '9':
    tileX = 16;
    tileY = 9;
    break;

  case 's':
    String filename = "gradient-" + millis() + ".png"; 
    drawPatternTo(output);
    output.save(filename);
    println(filename);
    return;

  default:
    drawMode = key;
  }

  // Draw pattern
  buffer.beginDraw();
  buffer.image(img, 0, 0, buffer.width, buffer.height);
  buffer.endDraw();
  drawPatternTo(buffer);
  image(buffer, 0, 0, width, height);
  
  println(drawMode, rotation, param, hex(cycle[c00]), hex(cycle[c01]), hex(cycle[c10]), hex(cycle[c11]));
}
