void drawPatternTo(PGraphics img) {
  switch (drawMode) {
  case 'r':
    radialGradient(img, .5f * img.width, .5f * img.height, .75f * img.width, cycle[c00], cycle[c01]);
    break;

  case 'w':
    sweepGradient(img, .5f * img.width, .5f * img.height, .75f * img.width, angle, param, cycle[c00], cycle[c01]);
    rotateOnto(img, img, rotation);
    break;

  case 'd':
    int y = img.height / 2 / param;
    linearGradient(img, 0, 0, img.width, y, cycle[c10], cycle[c11], cycle[c00], cycle[c01]);
    linearGradient(img, 0, y, img.width, img.height - 2 * y, cycle[c00], cycle[c01], cycle[c00], cycle[c01]);
    linearGradient(img, 0, img.height - y, img.width, y, cycle[c00], cycle[c01], cycle[c10], cycle[c11]);
    break;
    
  default:
    linearGradient(img, 0, 0, img.width, img.height, cycle[c00], cycle[c01], cycle[c10], cycle[c11]);
    break;
  }
  
  if (tileX != 1 || tileY != 1) {
    tile(img, tileX, tileY);
  }
}
