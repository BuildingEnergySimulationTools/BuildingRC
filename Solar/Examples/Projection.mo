within BuildingRC.Solar.Examples;

model Projection
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:7, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/BuildingRC/Solar/Examples/sun.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Solar.BeamComponent beamComponent(surface = 1,surface_azimuth(displayUnit = "deg") = 2.687807048071267, surface_tilt = 0.6108652381980153)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Solar.SkyDiffuse skyDiffuse(surface_tilt = 0.6108652381980153)  annotation(
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Solar.GroundReflected groundReflected(surface_tilt(displayUnit = "deg") = 0.6108652381980153)  annotation(
    Placement(visible = true, transformation(origin = {0, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3 annotation(
    Placement(visible = true, transformation(origin = {66, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Boundaries.y[5], beamComponent.dni) annotation(
    Line(points = {{-68, 0}, {-46, 0}, {-46, -6}, {-12, -6}}, color = {0, 0, 127}));
  connect(Boundaries.y[2], beamComponent.solar_azimuth) annotation(
    Line(points = {{-68, 0}, {-46, 0}, {-46, 6}, {-12, 6}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], beamComponent.solar_elevation) annotation(
    Line(points = {{-68, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(Boundaries.y[4], skyDiffuse.DHI) annotation(
    Line(points = {{-68, 0}, {-46, 0}, {-46, -30}, {-12, -30}}, color = {0, 0, 127}));
  connect(Boundaries.y[3], groundReflected.BHI) annotation(
    Line(points = {{-68, 0}, {-56, 0}, {-56, -60}, {-12, -60}}, color = {0, 0, 127}));
  connect(Boundaries.y[4], groundReflected.DHI) annotation(
    Line(points = {{-68, 0}, {-56, 0}, {-56, -68}, {-12, -68}}, color = {0, 0, 127}));
  connect(beamComponent.Hdir, add3.u1) annotation(
    Line(points = {{12, 0}, {32, 0}, {32, -26}, {54, -26}}, color = {0, 0, 127}));
  connect(skyDiffuse.DC, add3.u2) annotation(
    Line(points = {{12, -30}, {28, -30}, {28, -34}, {54, -34}}, color = {0, 0, 127}));
  connect(groundReflected.GR, add3.u3) annotation(
    Line(points = {{12, -64}, {26, -64}, {26, -42}, {54, -42}}, color = {0, 0, 127}));

annotation(
    experiment(StartTime = 16588800, StopTime = 16671600, Tolerance = 1e-6, Interval = 165.6),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Projection;
