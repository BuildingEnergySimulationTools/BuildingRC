within BuildingRC.Envelope.Examples;

model Windows
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:7, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/BuildingRC/Solar/Examples/sun.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Envelope.Window window[4](
    each Albedo = 0.25, 
    each SHGC = 0.41, 
    each Uwindow = 1.6,
    azimuth = {0, 1.570796326794897, 3.141592653589793, 4.71238898038469}, 
    each surface = 8, 
    each tilt = 1.570796326794897
     )  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Boundaries.y[1], window[1].sun_elevation) annotation(
    Line(points = {{-68, 0}, {-50, 0}, {-50, 8}, {-12, 8}}, color = {0, 0, 127}));
  connect(Boundaries.y[2], window[1].sun_azimuth) annotation(
    Line(points = {{-68, 0}, {-44, 0}, {-44, 4}, {-12, 4}}, color = {0, 0, 127}));
  connect(Boundaries.y[3], window[1].BHI) annotation(
    Line(points = {{-68, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(Boundaries.y[4], window[1].DHI) annotation(
    Line(points = {{-68, 0}, {-44, 0}, {-44, -4}, {-12, -4}}, color = {0, 0, 127}));
  connect(Boundaries.y[5], window[1].BNI) annotation(
    Line(points = {{-68, 0}, {-50, 0}, {-50, -8}, {-12, -8}}, color = {0, 0, 127}));

  connect(Boundaries.y[1], window[2].sun_elevation);
  connect(Boundaries.y[2], window[2].sun_azimuth) ;
  connect(Boundaries.y[3], window[2].BHI);
  connect(Boundaries.y[4], window[2].DHI);
  connect(Boundaries.y[5], window[2].BNI);
  
    connect(Boundaries.y[1], window[3].sun_elevation);
  connect(Boundaries.y[2], window[3].sun_azimuth) ;
  connect(Boundaries.y[3], window[3].BHI);
  connect(Boundaries.y[4], window[3].DHI);
  connect(Boundaries.y[5], window[3].BNI);
  
    connect(Boundaries.y[1], window[4].sun_elevation);
  connect(Boundaries.y[2], window[4].sun_azimuth) ;
  connect(Boundaries.y[3], window[4].BHI);
  connect(Boundaries.y[4], window[4].DHI);
  connect(Boundaries.y[5], window[4].BNI);  
  
  annotation(
    experiment(StartTime = 16588800, StopTime = 16671600, Tolerance = 1e-6, Interval = 3600),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Windows;
