PImage img;
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
  color(127), 
};

void setup()
{
  size(512, 512);
  noSmooth();

  // Background image
  img = loadImage("LOUDER_Cover.png");
  image(img, 0, 0);

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
    rotation += 90;
    break;
  case '[':
    rotation -= 90;
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
    saveFrame("gradient-###.png");
    println(frameCount);
    return;

  default:
    drawMode = key;
  }

  // Draw pattern
  image(img, 0, 0);
  switch (drawMode) {
  case 'r':
    radialGradient(.5f * width, .5f * height, .75f * width, cycle[c00], cycle[c01]);
    break;

  case 'w':
    sweepGradient(.5f * width, .5f * height, .75f * width, angle, param, cycle[c00], cycle[c01]);
    break;

  case 'e':
    linearGradient(0, 0, width, height, cycle[c00], cycle[c01], cycle[c10], cycle[c11]);
    break;

  case 'd':
    int y = height / 2 / param;
    linearGradient(0, 0, width, y, cycle[c10], cycle[c11], cycle[c00], cycle[c01]);
    linearGradient(0, y, width, height - 2 * y, cycle[c00], cycle[c01], cycle[c00], cycle[c01]);
    linearGradient(0, height - y, width, y, cycle[c00], cycle[c01], cycle[c10], cycle[c11]);
    break;
  }

  if (tileX != 1 || tileY != 1) {
    tile(tileX, tileY);
  }

  if (rotation != 0) {
    PImage p = get(0, 0, width, height);
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(radians(rotation));
    image(p, -width / 2, -height / 2);
    popMatrix();
  }

  println(rotation, param, hex(cycle[c00]), hex(cycle[c01]), hex(cycle[c10]), hex(cycle[c11]));
}
