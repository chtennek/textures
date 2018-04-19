void horizontalGradient(int x, int y, int w, int h, color c1, color c2) {
  
}

void rotateOnto(PGraphics img, PGraphics src, float rotation) {
  img.beginDraw();
  img.pushMatrix();
  img.translate(img.width / 2, img.height / 2);
  img.rotate(radians(rotation));
  img.scale(1.5);
  img.image(src, -img.width / 2, -img.height / 2, img.width, img.height);
  img.popMatrix();
  img.endDraw();
}

void tile(PGraphics img, int xCount, int yCount) {
  img.beginDraw();
  int w = img.width / xCount;
  int h = img.height / yCount;

  img.copy(0, 0, img.width, img.height, 0, 0, w, h);
  for (int i = 0; i < xCount; i++) {
    for (int j = 0; j < yCount; j++) {
      img.copy(0, 0, w, h, i * w, j * h, w, h);
    }
  }
  img.endDraw();
}

void linearGradient(PGraphics img, int x, int y, int w, int h, color c0, color cw, color ch, color c1) {
  img.beginDraw();
  for (int i = 0; i < w; i++) {
    float ti = map(i, 0, w, 0, 1);
    color c0i = lerpColor(c0, cw, ti);
    color c1i = lerpColor(ch, c1, ti);
    for (int j = 0; j < h; j++) {
      float tj = map(j, 0, h, 0, 1);
      color c = lerpColor(c0i, c1i, tj);

      img.stroke(c);
      img.point(x + i, y + j);
    }
  }
  img.endDraw();
}

void radialGradient(PGraphics img, float x, float y, float radius, color c0, color cr) {
  img.beginDraw();
  img.noStroke();
  for (float r = radius; r >= 0; r--) {
    float t = map(r, 0, radius, 0, 1);
    color c = lerpColor(c0, cr, t);
    
    img.fill(c);
    img.ellipse(x, y, 2 * r, 2 * r);
  }
  img.endDraw();
}

void sweepGradient(PGraphics img, float x, float y, float radius, float angle, int cycles, color c1, color c2) {
  img.beginDraw();
  float increment = 10 / radius;
  float range = angle / cycles;
  for (float a = 0; a < angle; a += increment) {
    float t = map(a % range, 0, range, 0, 1);
    color c = lerpColor(c1, c2, t); 
    img.stroke(c);

    float x2 = x + radius * cos(radians(a));
    float y2 = y + radius * sin(radians(a));
    img.line(x, y, x2, y2);
  }
  img.endDraw();
}
