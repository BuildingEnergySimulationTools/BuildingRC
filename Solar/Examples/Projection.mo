within BuildingRC.Solar.Examples;

model Projection
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:7, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/BuildingRC/Solar/Examples/sun.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Solar.BeamComponent beamComponent(surface_azimuth(displayUnit = "rad") = 154 * 3.14 / 180, surface_tilt = 35 *3.14 / 180)  annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Boundaries.y[5], beamComponent.dni) annotation(
    Line(points = {{-68, 0}, {-44, 0}, {-44, -6}, {-10, -6}}, color = {0, 0, 127}));
  connect(Boundaries.y[2], beamComponent.solar_azimuth) annotation(
    Line(points = {{-68, 0}, {-46, 0}, {-46, 6}, {-10, 6}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], beamComponent.solar_elevation) annotation(
    Line(points = {{-68, 0}, {-10, 0}}, color = {0, 0, 127}));

annotation(
    experiment(StartTime = 16588800, StopTime = 16671600, Tolerance = 1e-6, Interval = 165.6),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Projection;
