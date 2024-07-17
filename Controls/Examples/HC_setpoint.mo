within BuildingRC.Controls.Examples;

model HC_setpoint
extends Modelica.Icons.Example;
  BuildingRC.Envelope.R6C2 r6c2(Building_cq = 500, C_fur = 1500, S_hc = 75, S_walls = 900, S_windows = 100, T_init = 288.15, U_wall = 0.9, U_win = 2, V_int = 750)  annotation(
    Placement(visible = true, transformation(origin = {20, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine Text(amplitude = 10, f = 1 / (3600 * 24), offset = 17)  annotation(
    Placement(visible = true, transformation(origin = {-78, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Q annotation(
    Placement(visible = true, transformation(origin = {-66, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Controls.Heating_Cooling_SP heating_Cooling_SP( Ki = 1,Kp = 1000, Max_power = 30000)  annotation(
    Placement(visible = true, transformation(origin = {2, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = true)  annotation(
    Placement(visible = true, transformation(origin = {-62, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = true)  annotation(
    Placement(visible = true, transformation(origin = {26, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 19)  annotation(
    Placement(visible = true, transformation(origin = {2, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Text.y, r6c2.Text) annotation(
    Line(points = {{-66, 38}, {-34, 38}, {-34, 16}, {10, 16}}, color = {0, 0, 127}));
  connect(Q.y, r6c2.P_wall) annotation(
    Line(points = {{-54, -32}, {-18, -32}, {-18, 0}, {10, 0}}, color = {0, 0, 127}));
  connect(booleanExpression.y, heating_Cooling_SP.Cooling) annotation(
    Line(points = {{-50, -92}, {-2, -92}, {-2, -72}}, color = {255, 0, 255}));
  connect(booleanExpression1.y, heating_Cooling_SP.Heating) annotation(
    Line(points = {{38, -92}, {56, -92}, {56, -78}, {6, -78}, {6, -70}}, color = {255, 0, 255}));
  connect(heating_Cooling_SP.Control_out, r6c2.P_in) annotation(
    Line(points = {{12, -60}, {28, -60}, {28, -12}, {-36, -12}, {-36, 8}, {10, 8}}, color = {0, 0, 127}));
  connect(r6c2.Tin, heating_Cooling_SP.Sensor_in) annotation(
    Line(points = {{32, 8}, {54, 8}, {54, -42}, {-44, -42}, {-44, -54}, {-10, -54}}, color = {0, 0, 127}));
  connect(realExpression.y, heating_Cooling_SP.Temp_SP) annotation(
    Line(points = {{14, -30}, {22, -30}, {22, -48}, {2, -48}}, color = {0, 0, 127}));

annotation(
    experiment(StartTime = 0, StopTime = 300000, Tolerance = 1e-6, Interval = 600),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end HC_setpoint;
