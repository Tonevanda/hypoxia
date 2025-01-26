import gifAnimation.*; // Importa a biblioteca GifAnimation

PImage img; 
GifMaker gifExport; // Variável para exportar GIF
int framesToRecord = 60; // Quantidade de frames a serem gravados no GIF

float noiseOffset = 0.002; 
float noiseScale = 30; 
int stepSize = 3; // Reduzido para maior detalhamento
int bgColor = color(0); // Fundo preto

float minLineLength = 2; // Reduzido para maior detalhamento
float maxLineLength = 12; // Ajustado para mais precisão
float positionOffset = 0.25; // Reduzido para menos deslocamento
float zoomFactor = 1; // Fator de zoom aumentado

void setup() {
  size(1080, 1080); 
  img = loadImage("images.jpg"); 

  // Mantém a proporção da imagem enquanto a redimensiona para caber no canvas
  float imgAspect = float(img.width) / float(img.height);
  float canvasAspect = float(width) / float(height);
  
  // Ajuste para preencher o canvas sem distorcer
  if (imgAspect > canvasAspect) {
    img.resize(int(width * zoomFactor), int(width / imgAspect * zoomFactor)); // Redimensiona para largura máxima
  } else {
    img.resize(int(height * imgAspect * zoomFactor), int(height * zoomFactor)); // Redimensiona para altura máxima
  }

  frameRate(15); 
   
  // Configura o exportador de GIF
  gifExport = new GifMaker(this, "page1.gif"); // Nome do arquivo GIF
  gifExport.setRepeat(0); // 0 para repetir o GIF indefinidamente
  gifExport.setQuality(10); // Qualidade do GIF
  gifExport.setDelay(100); // Delay de 100ms entre frames
}

void draw() {
  background(bgColor);

  // Calcula a posição para centralizar a imagem
  int xOffset = (width - img.width) / 2;
  int yOffset = (height - img.height) / 2;

  for (int x = 0; x < img.width; x += stepSize) { 
    for (int y = 0; y < img.height; y += stepSize) {
      color c = img.get(x, y); 
      float bright = brightness(c); 
      float alpha = map(bright, 0, 255, 50, 255); // Transparência ajustada com brilho

      // Três níveis de variação de brilho com cores invertidas
      color shadowColor;
      if (bright < 64) {
        shadowColor = color(20, 40, 100, alpha); // Azul escuro
      } else if (bright < 128) {
        shadowColor = color(50, 100, 200, alpha); // Azul médio
      } else if (bright < 192) {
        shadowColor = color(150, 200, 255, alpha); // Azul claro
      } else {
        continue; // Pula áreas muito claras
      }

      stroke(shadowColor);

      float lineLength = map(bright, 0, 255, minLineLength, maxLineLength); 
      float offsetX = noise(x * noiseOffset, y * noiseOffset, millis() * 0.00005) * noiseScale - noiseScale / 2; 
      float offsetY = noise(y * noiseOffset, x * noiseOffset, millis() * 0.00005) * noiseScale - noiseScale / 2; 
      
      float randomOffsetX = random(-positionOffset, positionOffset);
      float randomOffsetY = random(-positionOffset, positionOffset);

      // Desenha cruzes com movimento suave
      // Linha vertical
      line(x + offsetX + randomOffsetX + xOffset, y + offsetY + randomOffsetY + yOffset, 
           x + offsetX + randomOffsetX + xOffset, y + offsetY + randomOffsetY + lineLength + yOffset);
      // Linha horizontal
      line(x + offsetX + randomOffsetX - lineLength / 2 + xOffset, 
           y + offsetY + randomOffsetY + lineLength / 2 + yOffset, 
           x + offsetX + randomOffsetX + lineLength / 2 + xOffset, 
           y + offsetY + randomOffsetY + lineLength / 2 + yOffset);
    }
  }

  // Adiciona o frame ao GIF
  gifExport.addFrame();

  // Finaliza o GIF após gravar o número de frames desejado
  if (frameCount >= framesToRecord) {
    gifExport.finish(); // Finaliza e salva o GIF
    noLoop(); // Para o loop do Processing
  }
}
