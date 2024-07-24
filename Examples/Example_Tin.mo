within BuildingRC.Examples;

model Example_Tin
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Efficiency fs = 0.4;
  parameter Real solar_wall_fraction = 0.5;
  parameter Real pac_wall_fraction = 0.5;
  Modelica.Units.SI.Power Solar_gain;
  Modelica.Units.SI.Power heated_floor_ahu;
  constant Modelica.Units.SI.Density Rho_air = 1.204 "kg/m3";
  constant Modelica.Units.SI.Time hour = 3600 "s";
  BuildingRC.Envelope.R6C2 r6c2( Inf = 10E-5, S_hc = 984, S_walls = 848, S_windows = 328, T_init (displayUnit = "degC") = 292.78, U_wall = 0.9, U_win = 2, V_int = 3608) annotation(
    Placement(visible = true, transformation(origin = {56, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable Boundaries(columns = 2:11, fileName = "C:/Users/bdurandestebe/Documents/56_NEOIA/modelica/boundaries_cta.txt", tableName = "table1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.HVAC.Heat_pump heat_pump annotation(
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.HVAC.AHU_Cross_flow AHU_Cross_flow(HX_eff = 0.7)  annotation(
    Placement(visible = true, transformation(origin = {0, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Airflow.ACH_Occupation aCH_Occupation(Building_volume = 3608, Infiltration_occupation = 0.3)  annotation(
    Placement(visible = true, transformation(origin = {52, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
// Conversion
  AHU_Cross_flow.Ctrl_m_blown_air = Boundaries.y[7] * Rho_air / hour;
  AHU_Cross_flow.Ctrl_m_extracted = Boundaries.y[7] * Rho_air / hour;
// Solar gain
  Solar_gain = 263 * fs * Boundaries.y[2] + 65 * fs * Boundaries.y[3];
// Remaining PAC heating power
  heated_floor_ahu = heat_pump.Power_to_building - AHU_Cross_flow.Heat_to_stream;
// Structure gain
  r6c2.P_wall = Solar_gain * solar_wall_fraction + heated_floor_ahu * pac_wall_fraction;
  r6c2.P_in = Solar_gain * (1 - solar_wall_fraction) + heated_floor_ahu * (1 - pac_wall_fraction) + AHU_Cross_flow.Heat_to_building + Boundaries.y[4] + aCH_Occupation.Power_to_building;
  connect(r6c2.Tin, AHU_Cross_flow.T_extracted) annotation(
    Line(points = {{68, 0}, {80, 0}, {80, 44}, {12, 44}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], r6c2.Text) annotation(
    Line(points = {{-68, 0}, {0, 0}, {0, 8}, {46, 8}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], heat_pump.T_ext) annotation(
    Line(points = {{-68, 0}, {-48, 0}, {-48, -24}, {-10, -24}}, color = {0, 0, 127}));
  connect(Boundaries.y[6], heat_pump.P_elec_in) annotation(
    Line(points = {{-68, 0}, {-62, 0}, {-62, -62}, {0, -62}, {0, -40}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], AHU_Cross_flow.T_air_ext) annotation(
    Line(points = {{-68, 0}, {-46, 0}, {-46, 30}, {-10, 30}}, color = {0, 0, 127}));
  connect(Boundaries.y[8], AHU_Cross_flow.Tset_hot_blown) annotation(
    Line(points = {{-68, 0}, {-60, 0}, {-60, 62}, {4, 62}, {4, 48}}, color = {0, 0, 127}));
  connect(r6c2.Tin, aCH_Occupation.Tin) annotation(
    Line(points = {{68, 0}, {88, 0}, {88, 50}, {28, 50}, {28, 72}, {42, 72}}, color = {0, 0, 127}));
  connect(Boundaries.y[1], aCH_Occupation.Text) annotation(
    Line(points = {{-68, 0}, {-58, 0}, {-58, 80}, {42, 80}}, color = {0, 0, 127}));
  connect(Boundaries.y[10], aCH_Occupation.Occupancy) annotation(
    Line(points = {{-68, 0}, {-60, 0}, {-60, 96}, {52, 96}, {52, 84}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 2.66976e+07, StopTime = 2.7216e+07, Tolerance = 1e-06, Interval = 1036.8),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Example_Tin;
