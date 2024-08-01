within BuildingRC.Examples;

model Example_Pelec_HP
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Efficiency fs = 0.04;
  parameter Real solar_wall_fraction = 0.7;
  parameter Real pac_wall_fraction = 0.1;
  
  Modelica.Units.SI.Power Solar_gain;
  Modelica.Units.SI.Power heated_floor_ahu;
  constant Modelica.Units.SI.Density Rho_air = 1.204 "kg/m3";
  constant Modelica.Units.SI.Time hour = 3600 "s";
  BuildingRC.Envelope.R6C2 r6c2(Inf = 0.13, R_i = 0.03, S_hc = 984, S_walls = 848, S_windows = 328, T_init (displayUnit = "degC") = 292.77, U_wall = 0.4, U_win = 1.7, V_int = 3608) annotation(
    Placement(visible = true, transformation(origin = {56, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:14, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/modelica/boundaries_cta.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.HVAC.Heat_pump heat_pump(COP_nominal = 2.5)  annotation(
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Controls.Heating_Cooling_SP heating_Cooling_SP(Kp = 80000, Max_power = 10E8, controllerType = Modelica.Blocks.Types.SimpleController.P) annotation(
    Placement(visible = true, transformation(origin = {-40, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression Heating(y = true) annotation(
    Placement(visible = true, transformation(origin = {36, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression Cooling(y = true) annotation(
    Placement(visible = true, transformation(origin = {38, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Airflow.ACH_Occupation aCH_Occupation(Building_volume = 3608, Infiltration_empty = 0.03, Infiltration_occupation = 0.48) annotation(
    Placement(visible = true, transformation(origin = {56, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.HVAC.AHU_Cross_flow AHU_R1(HX_eff = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-14, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.HVAC.AHU_Cross_flow aHU_Multi(HX_eff = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-22, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
// Conversion
  AHU_R1.Ctrl_m_blown_air = Boundaries.y[8] * Rho_air / hour;
  AHU_R1.Ctrl_m_extracted = Boundaries.y[8] * Rho_air / hour;
  aHU_Multi.Ctrl_m_blown_air = Boundaries.y[7] * Rho_air / hour;
  aHU_Multi.Ctrl_m_extracted = Boundaries.y[7] * Rho_air / hour;
// Solar gain
  Solar_gain = 263 * fs * Boundaries.y[2] + 65 * fs * Boundaries.y[3];
// Remaining PAC heating power
  heated_floor_ahu = heat_pump.Power_to_building - AHU_R1.Heat_to_stream - aHU_Multi.Heat_to_stream;
// Structure gain
  r6c2.P_wall = Solar_gain * solar_wall_fraction + heated_floor_ahu * pac_wall_fraction;
  r6c2.P_in = Solar_gain * (1 - solar_wall_fraction) + heated_floor_ahu * (1 - pac_wall_fraction) + AHU_R1.Heat_to_building + AHU_R1.Heat_to_building + Boundaries.y[4] + aCH_Occupation.Power_to_building;
  connect(Boundaries.y[1], heat_pump.T_ext) annotation(
    Line(points = {{-68, 0}, {-60, 0}, {-60, -24}, {-10, -24}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], r6c2.Text) annotation(
    Line(points = {{-68, 0}, {8, 0}, {8, 8}, {46, 8}}, color = {0, 0, 127}));
  connect(r6c2.Tin, heating_Cooling_SP.Sensor_in) annotation(
    Line(points = {{68, 0}, {72, 0}, {72, -92}, {-68, -92}, {-68, -60}, {-52, -60}}, color = {0, 0, 127}));
  connect(heating_Cooling_SP.Control_out, heat_pump.P_elec_in) annotation(
    Line(points = {{-30, -66}, {0, -66}, {0, -40}}, color = {0, 0, 127}));
  connect(Heating.y, heating_Cooling_SP.Heating) annotation(
    Line(points = {{48, -66}, {52, -66}, {52, -76}, {-36, -76}}, color = {255, 0, 255}));
  connect(Cooling.y, heating_Cooling_SP.Cooling) annotation(
    Line(points = {{50, -44}, {60, -44}, {60, -88}, {-44, -88}, {-44, -78}}, color = {255, 0, 255}));
  connect(Boundaries.y[5], heating_Cooling_SP.Temp_SP) annotation(
    Line(points = {{-68, 0}, {-40, 0}, {-40, -54}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], aCH_Occupation.Text) annotation(
    Line(points = {{-68, 0}, {-60, 0}, {-60, 76}, {46, 76}}, color = {0, 0, 127}));
  connect(Boundaries.y[13], aCH_Occupation.Occupancy) annotation(
    Line(points = {{-68, 0}, {-60, 0}, {-60, 90}, {56, 90}, {56, 80}}, color = {0, 0, 127}));
  connect(r6c2.Tin, aCH_Occupation.Tin) annotation(
    Line(points = {{68, 0}, {90, 0}, {90, 50}, {26, 50}, {26, 68}, {46, 68}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], aHU_Multi.T_air_ext) annotation(
    Line(points = {{-68, 0}, {-56, 0}, {-56, 18}, {-32, 18}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], AHU_R1.T_air_ext) annotation(
    Line(points = {{-68, 0}, {-54, 0}, {-54, 48}, {-24, 48}}, color = {0, 0, 127}));
  connect(Boundaries.y[9], AHU_R1.Tset_hot_blown) annotation(
    Line(points = {{-68, 0}, {-54, 0}, {-54, 74}, {-10, 74}, {-10, 66}}, color = {0, 0, 127}));
  connect(Boundaries.y[10], AHU_R1.T_extracted) annotation(
    Line(points = {{-68, 0}, {-50, 0}, {-50, 42}, {8, 42}, {8, 62}, {-2, 62}}, color = {0, 0, 127}));
  connect(Boundaries.y[12], aHU_Multi.T_extracted) annotation(
    Line(points = {{-68, 0}, {0, 0}, {0, 32}, {-10, 32}}, color = {0, 0, 127}));
  connect(Boundaries.y[11], aHU_Multi.Tset_hot_blown) annotation(
    Line(points = {{-68, 0}, {-54, 0}, {-54, 40}, {-18, 40}, {-18, 36}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 2.66976e+07, StopTime = 2.7216e+07, Tolerance = 1e-06, Interval = 100),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "euler"));
end Example_Pelec_HP;
