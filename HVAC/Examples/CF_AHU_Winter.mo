within BuildingRC.HVAC.Examples;

model CF_AHU_Winter
extends Modelica.Icons.Example;
  BuildingRC.HVAC.AHU_Cross_flow aHU_Cross_flow(HX_eff = 0.4)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:9, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/modelica/boundaries_cta.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Boundaries.y[1], aHU_Cross_flow.T_air_ext) annotation(
    Line(points = {{-58, 0}, {-48, 0}, {-48, -6}, {-10, -6}}, color = {0, 0, 127}));
  connect(Boundaries.y[6], aHU_Cross_flow.Ctrl_m_blown_air) annotation(
    Line(points = {{-58, 0}, {-46, 0}, {-46, 28}, {-6, 28}, {-6, 12}}, color = {0, 0, 127}));
  connect(Boundaries.y[6], aHU_Cross_flow.Ctrl_m_extracted) annotation(
    Line(points = {{-58, 0}, {-46, 0}, {-46, 28}, {-2, 28}, {-2, 12}}, color = {0, 0, 127}));
  connect(Boundaries.y[7], aHU_Cross_flow.Tset_hot_blown) annotation(
    Line(points = {{-58, 0}, {-46, 0}, {-46, 28}, {4, 28}, {4, 12}}, color = {0, 0, 127}));
  connect(Boundaries.y[8], aHU_Cross_flow.T_extracted) annotation(
    Line(points = {{-58, 0}, {-46, 0}, {-46, 40}, {34, 40}, {34, 8}, {12, 8}}, color = {0, 0, 127}));
annotation(
    experiment(StartTime = 26697600, StopTime = 27216000, Tolerance = 1e-6, Interval = 1036.8),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end CF_AHU_Winter;
