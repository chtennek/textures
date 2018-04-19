void horizontalGradient(int x, int y, int w, int h, color c1, color c2) {
  
}

void tile(int xCount, int yCount) {
  int w = width / xCount;
  int h = height / yCount;

  copy(0, 0, width, height, 0, 0, w, h);
  for (int i = 0; i < xCount; i++) {
    for (int j = 0; j < yCount; j++) {
      copy(0, 0, w, h, i * w, j * h, w, h);
    }
  }
}

void linearGradient(int x, int y, int w, int h, color c0, color cw, color ch, color c1) {
  for (int i = 0; i < w; i++) {
    float ti = map(i, 0, w, 0, 1);
    color c0i = lerpColor(c0, cw, ti);
    color c1i = lerpColor(ch, c1, ti);
    for (int j = 0; j < h; j++) {
      float tj = map(j, 0, h, 0, 1);
      color c = lerpColor(c0i, c1i, tj);

      stroke(c);
      point(x + i, y + j);
    }
  }
}

void radialGradient(float x, float y, float radius, color c0, color cr) {
  noStroke();
  float h = random(0, 360);
  for (float r = radius; r >= 0; r--) {
    float t = map(r, 0, radius, 0, 1);
    color c = lerpColor(c0, cr, t); 
    fill(c);
    ellipse(x, y, 2 * r, 2 * r);
    h = (h + 1) % 360;
  }
}

void sweepGradient(float x, float y, float radius, float angle, int cycles, color c1, color c2) {
  float increment = 10 / radius;
  float range = angle / cycles;
  for (float a = 0; a < angle; a += increment) {
    float t = map(a % range, 0, range, 0, 1);
    color c = lerpColor(c1, c2, t); 
    stroke(c);

    float x2 = x + radius * cos(radians(a));
    float y2 = y + radius * sin(radians(a));
    line(x, y, x2, y2);
  }
}
