import controlP5.*;
import http.requests.*;

ControlP5 cp5;
Chart grafica;
String parametro = "";

void setup() {
  //CONFIGURACIONES
  size(1000, 600);
  smooth();
  cp5 = new ControlP5(this);
  PFont font = createFont("Georgia",20);

  //AREA PARA EL TITULO
  cp5.addTextlabel("label")
                    .setText("Práctica 2 - 201603016")
                    .setPosition(340,20)
                    .setColor(color(255,255,255))
                    .setFont(createFont("Georgia",30))
                    ;
 
 //AREA PARA LOS TXT DE LAS GRAFICAS 
  cp5.addTextfield("input1") //DIA
     .setPosition(20,100)
     .setSize(200,39)
     .setFont(font)
     .setFocus(true)
     .setColorCaptionLabel(color(0))
     .setColor(color(255,255,255))
     ;
     
  cp5.addTextfield("input2") // MES
     .setPosition(20,140)
     .setSize(200,39)
     .setFont(font)
     .setFocus(false)
     .setColorCaptionLabel(color(0))
     .setColor(color(255,255,255))
     ;
   cp5.addTextfield("input3") //ANO
     .setPosition(20,180)
     .setSize(200,39)
     .setFont(font)
     .setFocus(false)
     .setColorCaptionLabel(color(0))
     .setColor(color(255,255,255))
     ;
     

  //AREA PARA LA CREACION DE LOS BOTONES 
  cp5.addButton("R1")
     .setPosition(240,100)
     .setSize(100,39)
     ;
  
  cp5.addButton("R2")
     .setPosition(240,140)
     .setSize(100,39)
     ;
     
  cp5.addButton("R3")
     .setPosition(240,180)
     .setSize(100,39)
     ;
     
  cp5.addButton("R4")
     .setPosition(240,220)
     .setSize(100,39)
     ;
     
  cp5.addButton("R5")
     .setPosition(240,260)
     .setSize(100,39)
     ;

     
     
  grafica = cp5.addChart("Reporte")
            .setPosition(400,100)
            .setSize(560, 380)
            .setRange(-20, 20)
           //.setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
            .setStrokeWeight(1.5)
            .setColorCaptionLabel(color(200))
            ; 
            
}


void draw() {
  background(0);
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
  grafica.removeDataSet("ejex");
  grafica.addDataSet("ejex");
  grafica.setView(Chart.LINE);
  //grafica.setData("ejex",x);
  parametro = cp5.get(Textfield.class,"input1").getText();
  GetRequest get = new GetRequest(url+parametro);
  get.send();
  JSONArray json = parseJSONArray(get.getContent());
  print(json);
}

public void R2() {
  /*Grafica de barras verticales
    Paquetes Y
    dia del mes X
    por el mes seleccionado por usuario*/
  grafica.removeDataSet("ejex");
  grafica.removeDataSet("ejey");
  grafica.addDataSet("ejex");
  grafica.addDataSet("ejey");
  grafica.setView(Chart.BAR_CENTERED);
  float[]x = {10,9,8,7};
  float[]y = {20,92,12,17};
  grafica.setData("ejex",x);
  grafica.setData("ejex",y);
}
public void R3() {
  /*Grafica de dos barras verticales paralelas
    Obstaculos Y
    Hora salida X
    barra izquiera ida
    barra derecha vuelta
    por dia selecionado por usuario*/
}
public void R4() {
  /*Grafica lineas
    X hora salida
    Y tiempo en segundos
    por dia selecionado por usuario*/
}
public void R5() {
  /*Grafica de dos barras verticales paralelas
    tiempo promedio dia Y
    dia X
    barra izquierda ida
    barra derecha vuelta
    por mes seleccionado por usuario*/
    //PETICIONES AL SERVIDOR
  String url = "http://ec2-54-157-141-118.compute-1.amazonaws.com:3000/rep1";
  GetRequest get = new GetRequest(url+"/8/2");
  get.send();
  //System.out.println("Reponse Content: " + get.getContent());
  JSONArray json = parseJSONArray(get.getContent());
  println(json.getString(2,"vuelta"));
  
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
