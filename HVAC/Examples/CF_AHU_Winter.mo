within BuildingRC.HVAC.Examples;

model CF_AHU_Winter
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:8, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/BuildingRC/HVAC/Examples/boundaries_ahu.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  constant Modelica.Units.SI.Density Rho_air = 1.204 "kg/m3";
  constant Modelica.Units.SI.Time hour = 3600 "s";
  BuildingRC.HVAC.AHU_Cross_flow aHU_Multi(HX_eff = 0.7) annotation(
    Placement(visible = true, transformation(origin = {-4, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  aHU_Multi.Ctrl_m_blown_air = Boundaries.y[7] * Rho_air / hour;
  aHU_Multi.Ctrl_m_extracted = Boundaries.y[7] * Rho_air / hour;
  connect(Boundaries.y[1], aHU_Multi.T_air_ext) annotation(
    Line(points = {{-58, 0}, {-40, 0}, {-40, -18}, {-14, -18}}, color = {0, 0, 127}));
  connect(Boundaries.y[2], aHU_Multi.Tset_hot_blown) annotation(
    Line(points = {{-58, 0}, {-30, 0}, {-30, 8}, {0, 8}, {0, 0}}, color = {0, 0, 127}));
  connect(Boundaries.y[3], aHU_Multi.T_extracted) annotation(
    Line(points = {{-58, 0}, {-22, 0}, {-22, 4}, {18, 4}, {18, -6}, {8, -6}, {8, -4}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 2.66976e+07, StopTime = 2.73006e+07, Tolerance = 1e-06, Interval = 1206),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end CF_AHU_Winter;
