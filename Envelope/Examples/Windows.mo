within BuildingRC.Envelope.Examples;

model Windows
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:7, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/BuildingRC/Solar/Examples/sun.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Envelope.Window window[4](each Albedo = 0.25, each SHGC = 0.41, each Uwindow = 1.6, azimuth = {0, 1.570796326794897, 3.141592653589793, 4.71238898038469}, each surface = 8, each tilt = 1.570796326794897) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  for i in 1:4 loop
    connect(Boundaries.y[1], window[i].sun_elevation);
    connect(Boundaries.y[2], window[i].sun_azimuth);
    connect(Boundaries.y[3], window[i].BHI);
    connect(Boundaries.y[4], window[i].DHI);
    connect(Boundaries.y[5], window[i].BNI);
  end for;
  annotation(
    experiment(StartTime = 1.65888e+07, StopTime = 1.66716e+07, Tolerance = 1e-06, Interval = 3600),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Windows;
