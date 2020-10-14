import controlP5.*;
import http.requests.*;
import javax.swing.*;


ControlP5 cp5;
Chart grafica;
String dia = "";
String mes = "";

PImage graficapro;

void setup() {
  //CONFIGURACIONES
  size(1000, 600);
  smooth();
  cp5 = new ControlP5(this);
  PFont font = createFont("Arial",20);
  PFont font2 = createFont("Arial",14);

  //AREA PARA EL TITULO
  cp5.addTextlabel("label")
                    .setText("Práctica 2 - 201603016")
                    .setPosition(340,20)
                    .setColor(color(255,255,255))
                    .setFont(font)
                    ;
                    
   cp5.addTextlabel("label1")
                    .setText("Dia")
                    .setPosition(20,150)
                    .setColor(color(255,255,255))
                    .setFont(font2)
                    ;
   cp5.addTextlabel("label2")
                    .setText("Mes")
                    .setPosition(75,150)
                    .setColor(color(255,255,255))
                    .setFont(font2)
                    ;
 
 //AREA PARA LOS TXT DE LAS GRAFICAS 
  cp5.addTextfield("Day") //DIA
     .setPosition(20,100)
     .setSize(50,39)
     .setFont(font)
     .setFocus(true)
     .setColorCaptionLabel(color(0))
     .setColor(color(255,255,255))
     ;
     
  cp5.addTextfield("Month") // MES
     .setPosition(75,100)
     .setSize(50,39)
     .setFont(font)
     .setFocus(false)
     .setColorCaptionLabel(color(0))
     .setColor(color(255,255,255))
     ;
     

  //AREA PARA LA CREACION DE LOS BOTONES   
     
  cp5.addButton("R1")
     .setPosition(20,180)
     .setSize(100,39)
     ;
     
  cp5.addButton("R2")
     .setPosition(20,220)
     .setSize(100,39)
     ;
     
  cp5.addButton("R3")
     .setPosition(20,260)
     .setSize(100,39)
     ;
     
  cp5.addButton("R4")
     .setPosition(20,300)
     .setSize(100,39)
     ;
     
  cp5.addButton("R5")
     .setPosition(20,340)
     .setSize(100,39)
     ;
     
}


void draw() {
  background(0);
  if(graficapro != null){
  image(graficapro, 280, 100);
  }
}


//FUNCIONES DE BOTONES
public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}

public void R1() {
  /*Grafica de puntos lineal
    Peso Y
    Hora X
    por dia seleccionado por usuario*/
  String url = "http://ec2-54-157-141-118.compute-1.amazonaws.com:3000/rep1/";
  dia = cp5.get(Textfield.class,"Day").getText();
  mes = cp5.get(Textfield.class,"Month").getText();
  GetRequest get = new GetRequest(url+mes+"/"+dia);
  get.send();
  
  JSONArray json = parseJSONArray(get.getContent());
  int size = json.size();
  
  DefaultCategoryDataset dataset = new DefaultCategoryDataset();
  
  for(int i = 0; i< size; i++){
    JSONObject aux = json.getJSONObject(i);
    dataset.addValue(aux.getInt("peso"), "f(x)", String.valueOf(aux.getInt("horas")));
  }
  
  JFreeChart chart = ChartFactory.createLineChart(
        "Grafica Reporte 1", // Chart title
        "Hora", // X-Axis Label
        "peso", // Y-Axis Label
        dataset
        );
        
  graficapro = new PImage(chart.createBufferedImage(600,350));
  
  print(json);
}

public void R2() {
  /*Grafica de barras verticales
    Paquetes Y
    dia del mes X
    por el mes seleccionado por usuario*/
  mes = "";
  String url = "http://ec2-54-157-141-118.compute-1.amazonaws.com:3000/rep2/";
  mes = cp5.get(Textfield.class,"Month").getText();
  GetRequest get = new GetRequest(url+mes);
  get.send();
  
  JSONArray json = parseJSONArray(get.getContent());
  int size = json.size();
  
  DefaultCategoryDataset dataset = new DefaultCategoryDataset();
  
  for(int i = 0; i< size; i++){
    JSONObject aux = json.getJSONObject(i);
    dataset.addValue(aux.getInt("paquetes"), "f(x)", String.valueOf(aux.getInt("dia")));
  }
  
  JFreeChart chart = ChartFactory.createBarChart(
        "Grafica Reporte 2", // Chart title
        "Dia del mes", // X-Axis Label
        "No. Paquetes", // Y-Axis Label
        dataset
        );
        
  graficapro = new PImage(chart.createBufferedImage(600,350));
  
  print(json);
  
}
public void R3() {
  /*Grafica de dos barras verticales paralelas
    Obstaculos Y
    Hora salida X
    barra izquiera ida
    barra derecha vuelta
    por dia selecionado por usuario*/
  String url = "http://ec2-54-157-141-118.compute-1.amazonaws.com:3000/rep3/";
  dia = cp5.get(Textfield.class,"Day").getText();
  mes = cp5.get(Textfield.class,"Month").getText();
  GetRequest get = new GetRequest(url+mes+"/"+dia);
  get.send();
  
  JSONArray json = parseJSONArray(get.getContent());
  int size = json.size();
  String graph1 = "Ida";
  String graph2 = "Vuelta";
  
  DefaultCategoryDataset dataset = new DefaultCategoryDataset();
  
  for(int i = 0; i< size; i++){
    JSONObject aux = json.getJSONObject(i);
    dataset.addValue(aux.getInt("ida"), graph1, String.valueOf(aux.getInt("vuelta")));
    dataset.addValue(aux.getInt("vuelta"), graph2, String.valueOf(aux.getInt("ida")));
  }
  
  JFreeChart chart = ChartFactory.createBarChart(
        "Grafica Reporte 3", // Chart title
        "Hora", // X-Axis Label
        "Obstaculos", // Y-Axis Label
        dataset
        );
        
  graficapro = new PImage(chart.createBufferedImage(600,350));
  
  print(json);
  
  
}
public void R4() {
  /*Grafica lineas
    X hora salida
    Y tiempo en segundos
    por dia selecionado por usuario*/
  String url = "http://ec2-54-157-141-118.compute-1.amazonaws.com:3000/rep4/";
  dia = cp5.get(Textfield.class,"Day").getText();
  mes = cp5.get(Textfield.class,"Month").getText();
  GetRequest get = new GetRequest(url+mes+"/"+dia);
  get.send();
  
  JSONArray json = parseJSONArray(get.getContent());
  int size = json.size();
  
  DefaultCategoryDataset dataset = new DefaultCategoryDataset();
  
  for(int i = 0; i< size; i++){
    JSONObject aux = json.getJSONObject(i);
    dataset.addValue(aux.getInt("ida"), "ida", String.valueOf(aux.getInt("hora")));
    dataset.addValue(aux.getInt("vuelta"), "vuelta", String.valueOf(aux.getInt("hora")));
  }
  
  JFreeChart chart = ChartFactory.createLineChart(
        "Grafica Reporte 4", // Chart title
        "Hora salida", // X-Axis Label
        "Tiempo", // Y-Axis Label
        dataset
        );
        
  graficapro = new PImage(chart.createBufferedImage(600,350));
  
  print(json);
}
public void R5() {
  /*Grafica de dos barras verticales paralelas
    tiempo promedio dia Y
    dia X
    barra izquierda ida
    barra derecha vuelta
    por mes seleccionado por usuario*/
    //PETICIONES AL SERVIDOR
  String url = "http://ec2-54-157-141-118.compute-1.amazonaws.com:3000/rep5/";
  mes = cp5.get(Textfield.class,"Month").getText();
  GetRequest get = new GetRequest(url+mes);
  get.send();
  
  JSONArray json = parseJSONArray(get.getContent());
  int size = json.size();
  
  DefaultCategoryDataset dataset = new DefaultCategoryDataset();
  
  for(int i = 0; i< size; i++){
    JSONObject aux = json.getJSONObject(i);
    dataset.addValue(aux.getInt("ida"), "Ida", String.valueOf(aux.getInt("dia")));
    dataset.addValue(aux.getInt("vuelta"), "Vuelta", String.valueOf(aux.getInt("dia")));
  }
  
  JFreeChart chart = ChartFactory.createBarChart(
        "Grafica Reporte 5", // Chart title
        "Dia", // X-Axis Label
        "Tiempo promedio", // Y-Axis Label
        dataset
        );
        
  graficapro = new PImage(chart.createBufferedImage(600,350));
  
  print(json);
  
}



/*
a list of all methods available for the Chart Controller
use ControlP5.printPublicMethodsFor(Chart.class);
to print the following list into the console.
You can find further details about class Chart in the javadoc.
Format:
ClassName : returnType methodName(parameter type)
controlP5.Chart : Chart addData(ChartData) 
controlP5.Chart : Chart addData(ChartDataSet, float) 
controlP5.Chart : Chart addData(String, ChartData) 
controlP5.Chart : Chart addData(String, float) 
controlP5.Chart : Chart addData(float) 
controlP5.Chart : Chart addDataSet(String) 
controlP5.Chart : Chart addFirst(String, float) 
controlP5.Chart : Chart addFirst(float) 
controlP5.Chart : Chart addLast(String, float) 
controlP5.Chart : Chart addLast(float) 
controlP5.Chart : Chart push(String, float) 
controlP5.Chart : Chart push(float) 
controlP5.Chart : Chart removeData(ChartData) 
controlP5.Chart : Chart removeData(String, ChartData) 
controlP5.Chart : Chart removeData(String, int) 
controlP5.Chart : Chart removeData(int) 
controlP5.Chart : Chart removeDataSet(String) 
controlP5.Chart : Chart removeFirst() 
controlP5.Chart : Chart removeFirst(String) 
controlP5.Chart : Chart removeLast() 
controlP5.Chart : Chart removeLast(String) 
controlP5.Chart : Chart setData(String, int, ChartData) 
controlP5.Chart : Chart setData(int, ChartData) 
controlP5.Chart : Chart setDataSet(ChartDataSet) 
controlP5.Chart : Chart setDataSet(String, ChartDataSet) 
controlP5.Chart : Chart setRange(float, float) 
controlP5.Chart : Chart setResolution(int) 
controlP5.Chart : Chart setStrokeWeight(float) 
controlP5.Chart : Chart setValue(float) 
controlP5.Chart : Chart setView(int) 
controlP5.Chart : Chart unshift(String, float) 
controlP5.Chart : Chart unshift(float) 
controlP5.Chart : ChartData getData(String, int) 
controlP5.Chart : ChartDataSet getDataSet(String) 
controlP5.Chart : LinkedHashMap getDataSet() 
controlP5.Chart : String getInfo() 
controlP5.Chart : String toString() 
controlP5.Chart : float getStrokeWeight() 
controlP5.Chart : float[] getValuesFrom(String) 
controlP5.Chart : int getResolution() 
controlP5.Chart : int size() 
controlP5.Chart : void onEnter() 
controlP5.Chart : void onLeave() 
controlP5.Controller : CColor getColor() 
controlP5.Controller : Chart addCallback(CallbackListener) 
controlP5.Controller : Chart addListener(ControlListener) 
controlP5.Controller : Chart addListenerFor(int, CallbackListener) 
controlP5.Controller : Chart align(int, int, int, int) 
controlP5.Controller : Chart bringToFront() 
controlP5.Controller : Chart bringToFront(ControllerInterface) 
controlP5.Controller : Chart hide() 
controlP5.Controller : Chart linebreak() 
controlP5.Controller : Chart listen(boolean) 
controlP5.Controller : Chart lock() 
controlP5.Controller : Chart onChange(CallbackListener) 
controlP5.Controller : Chart onClick(CallbackListener) 
controlP5.Controller : Chart onDoublePress(CallbackListener) 
controlP5.Controller : Chart onDrag(CallbackListener) 
controlP5.Controller : Chart onDraw(ControllerView) 
controlP5.Controller : Chart onEndDrag(CallbackListener) 
controlP5.Controller : Chart onEnter(CallbackListener) 
controlP5.Controller : Chart onLeave(CallbackListener) 
controlP5.Controller : Chart onMove(CallbackListener) 
controlP5.Controller : Chart onPress(CallbackListener) 
controlP5.Controller : Chart onRelease(CallbackListener) 
controlP5.Controller : Chart onReleaseOutside(CallbackListener) 
controlP5.Controller : Chart onStartDrag(CallbackListener) 
controlP5.Controller : Chart onWheel(CallbackListener) 
controlP5.Controller : Chart plugTo(Object) 
controlP5.Controller : Chart plugTo(Object, String) 
controlP5.Controller : Chart plugTo(Object[]) 
controlP5.Controller : Chart plugTo(Object[], String) 
controlP5.Controller : Chart registerProperty(String) 
controlP5.Controller : Chart registerProperty(String, String) 
controlP5.Controller : Chart registerTooltip(String) 
controlP5.Controller : Chart removeBehavior() 
controlP5.Controller : Chart removeCallback() 
controlP5.Controller : Chart removeCallback(CallbackListener) 
controlP5.Controller : Chart removeListener(ControlListener) 
controlP5.Controller : Chart removeListenerFor(int, CallbackListener) 
controlP5.Controller : Chart removeListenersFor(int) 
controlP5.Controller : Chart removeProperty(String) 
controlP5.Controller : Chart removeProperty(String, String) 
controlP5.Controller : Chart setArrayValue(float[]) 
controlP5.Controller : Chart setArrayValue(int, float) 
controlP5.Controller : Chart setBehavior(ControlBehavior) 
controlP5.Controller : Chart setBroadcast(boolean) 
controlP5.Controller : Chart setCaptionLabel(String) 
controlP5.Controller : Chart setColor(CColor) 
controlP5.Controller : Chart setColorActive(int) 
controlP5.Controller : Chart setColorBackground(int) 
controlP5.Controller : Chart setColorCaptionLabel(int) 
controlP5.Controller : Chart setColorForeground(int) 
controlP5.Controller : Chart setColorLabel(int) 
controlP5.Controller : Chart setColorValue(int) 
controlP5.Controller : Chart setColorValueLabel(int) 
controlP5.Controller : Chart setDecimalPrecision(int) 
controlP5.Controller : Chart setDefaultValue(float) 
controlP5.Controller : Chart setHeight(int) 
controlP5.Controller : Chart setId(int) 
controlP5.Controller : Chart setImage(PImage) 
controlP5.Controller : Chart setImage(PImage, int) 
controlP5.Controller : Chart setImages(PImage, PImage, PImage) 
controlP5.Controller : Chart setImages(PImage, PImage, PImage, PImage) 
controlP5.Controller : Chart setLabel(String) 
controlP5.Controller : Chart setLabelVisible(boolean) 
controlP5.Controller : Chart setLock(boolean) 
controlP5.Controller : Chart setMax(float) 
controlP5.Controller : Chart setMin(float) 
controlP5.Controller : Chart setMouseOver(boolean) 
controlP5.Controller : Chart setMoveable(boolean) 
controlP5.Controller : Chart setPosition(float, float) 
controlP5.Controller : Chart setPosition(float[]) 
controlP5.Controller : Chart setSize(PImage) 
controlP5.Controller : Chart setSize(int, int) 
controlP5.Controller : Chart setStringValue(String) 
controlP5.Controller : Chart setUpdate(boolean) 
controlP5.Controller : Chart setValue(float) 
controlP5.Controller : Chart setValueLabel(String) 
controlP5.Controller : Chart setValueSelf(float) 
controlP5.Controller : Chart setView(ControllerView) 
controlP5.Controller : Chart setVisible(boolean) 
controlP5.Controller : Chart setWidth(int) 
controlP5.Controller : Chart show() 
controlP5.Controller : Chart unlock() 
controlP5.Controller : Chart unplugFrom(Object) 
controlP5.Controller : Chart unplugFrom(Object[]) 
controlP5.Controller : Chart unregisterTooltip() 
controlP5.Controller : Chart update() 
controlP5.Controller : Chart updateSize() 
controlP5.Controller : ControlBehavior getBehavior() 
controlP5.Controller : ControlWindow getControlWindow() 
controlP5.Controller : ControlWindow getWindow() 
controlP5.Controller : ControllerProperty getProperty(String) 
controlP5.Controller : ControllerProperty getProperty(String, String) 
controlP5.Controller : ControllerView getView() 
controlP5.Controller : Label getCaptionLabel() 
controlP5.Controller : Label getValueLabel() 
controlP5.Controller : List getControllerPlugList() 
controlP5.Controller : Pointer getPointer() 
controlP5.Controller : String getAddress() 
controlP5.Controller : String getInfo() 
controlP5.Controller : String getName() 
controlP5.Controller : String getStringValue() 
controlP5.Controller : String toString() 
controlP5.Controller : Tab getTab() 
controlP5.Controller : boolean isActive() 
controlP5.Controller : boolean isBroadcast() 
controlP5.Controller : boolean isInside() 
controlP5.Controller : boolean isLabelVisible() 
controlP5.Controller : boolean isListening() 
controlP5.Controller : boolean isLock() 
controlP5.Controller : boolean isMouseOver() 
controlP5.Controller : boolean isMousePressed() 
controlP5.Controller : boolean isMoveable() 
controlP5.Controller : boolean isUpdate() 
controlP5.Controller : boolean isVisible() 
controlP5.Controller : float getArrayValue(int) 
controlP5.Controller : float getDefaultValue() 
controlP5.Controller : float getMax() 
controlP5.Controller : float getMin() 
controlP5.Controller : float getValue() 
controlP5.Controller : float[] getAbsolutePosition() 
controlP5.Controller : float[] getArrayValue() 
controlP5.Controller : float[] getPosition() 
controlP5.Controller : int getDecimalPrecision() 
controlP5.Controller : int getHeight() 
controlP5.Controller : int getId() 
controlP5.Controller : int getWidth() 
controlP5.Controller : int listenerSize() 
controlP5.Controller : void remove() 
controlP5.Controller : void setView(ControllerView, int) 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 
created: 2015/03/24 12:20:54
*/
