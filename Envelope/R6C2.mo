within BuildingRC.Envelope;
model R6C2
  parameter Modelica.Units.SI.Volume V_int "Building internal volume";
  parameter Modelica.Units.SI.Area S_hc "Heated or Cooled building surface";
  parameter Modelica.Units.SI.Area S_walls "Exterior wall surface (without windows)";
  parameter Modelica.Units.SI.Area S_windows "Exterior windows surface";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_wall "Walls+Roof+Floor coefficient of heat transfer";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_win "Windows coefficient of heat transfer";
  parameter Real Inf = 0.15 "Infiltration Air Change Rate [Vol/h]";
  parameter Real Building_cq = 270 "Building daily heat capacity [kJ/m².K]";
  parameter Real C_fur = 20 "Building furniture coefficient of heat capacity [kJ/m².K]";
  parameter Modelica.Units.SI.Temperature T_init=293.15 "Building initial temperature";
  parameter Modelica.Units.SI.ThermalInsulance R_i = 0.13 "Internal surface resistance coefficient";
  parameter Modelica.Units.SI.ThermalInsulance R_e = 0.04 "External surface resistance coefficient";
  
  constant Modelica.Units.SI.SpecificHeatCapacity C_air = 1005 "[J/K.kg]";
  constant Modelica.Units.SI.Density Rho_air =  1.204 "kg/m3";
  constant Modelica.Units.SI.Time hour = 3600 "s";
  parameter Modelica.Units.SI.MassFlowRate m_inf = Inf * V_int * Rho_air / hour;       //Infiltration flowrate
 
  
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rw(R = 1 / (U_wall * S_walls)) annotation(
    Placement(visible = true, transformation(origin = {-18, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Cin(C = Rho_air * C_air * V_int + C_fur * S_hc * 1000, T(displayUnit = "degC", start = T_init)) annotation(
    Placement(visible = true, transformation(origin = {76, -80}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tin_sens annotation(
    Placement(visible = true, transformation(origin = {98, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin Text_K annotation(
    Placement(visible = true, transformation(origin = {-144, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rs(R = R_i / S_walls) annotation(
    Placement(visible = true, transformation(origin = {18, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Cw(C = Building_cq * S_hc * 1000, T(displayUnit = "degC", start = T_init)) annotation(
    Placement(visible = true, transformation(origin = {0, -78}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin annotation(
    Placement(visible = true, transformation(origin = {136, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Text_convert annotation(
    Placement(visible = true, transformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Ri(R = R_i / S_walls) annotation(
    Placement(visible = true, transformation(origin = {54, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rwin(R = 1 / (S_windows * U_win)) annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Re(R = R_e / S_walls) annotation(
    Placement(visible = true, transformation(origin = {-54, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Gain_in annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Gain_wall annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

  Modelica.Blocks.Interfaces.RealInput P_wall(unit="W") annotation(
    Placement(visible = true, transformation(origin = {60, 40}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput P_in(unit="W") annotation(
    Placement(visible = true, transformation(origin = {100, 40}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Text(unit="C") annotation(
    Placement(visible = true, transformation(origin = {-188, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Tin(unit="C") annotation(
    Placement(visible = true, transformation(origin = {174, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rinf(R = 1 / (C_air * m_inf)) annotation(
    Placement(visible = true, transformation(origin = {0, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Text_K.Kelvin, Text_convert.T) annotation(
    Line(points = {{-133, -50}, {-123, -50}}, color = {0, 0, 127}));
  connect(Rw.port_b, Rs.port_a) annotation(
    Line(points = {{-8, -50}, {8, -50}}, color = {191, 0, 0}));
  connect(Re.port_b, Rw.port_a) annotation(
    Line(points = {{-44, -50}, {-28, -50}}, color = {191, 0, 0}));
  connect(Rw.port_b, Cw.port) annotation(
    Line(points = {{-8, -50}, {0, -50}, {0, -68}}, color = {191, 0, 0}));
  connect(Ri.port_b, Cin.port) annotation(
    Line(points = {{64, -50}, {76, -50}, {76, -70}}, color = {191, 0, 0}));
  connect(Cin.port, Tin_sens.port) annotation(
    Line(points = {{76, -70}, {76, -50}, {88, -50}}, color = {191, 0, 0}));
  connect(Tin_sens.T, fromKelvin.Kelvin) annotation(
    Line(points = {{110, -50}, {124, -50}}, color = {0, 0, 127}));
  connect(Text_convert.port, Re.port_a) annotation(
    Line(points = {{-100, -50}, {-64, -50}}, color = {191, 0, 0}));
  connect(Text_convert.port, Rwin.port_a) annotation(
    Line(points = {{-100, -50}, {-80, -50}, {-80, -20}, {-10, -20}}, color = {191, 0, 0}));
  connect(Rwin.port_b, Cin.port) annotation(
    Line(points = {{10, -20}, {76, -20}, {76, -70}}, color = {191, 0, 0}));
  connect(Text, Text_K.Celsius) annotation(
    Line(points = {{-188, -50}, {-156, -50}}, color = {0, 0, 127}));
  connect(fromKelvin.Celsius, Tin) annotation(
    Line(points = {{148, -50}, {174, -50}}, color = {0, 0, 127}));
  connect(Gain_in.port, Cin.port) annotation(
    Line(points = {{100, -10}, {100, -28}, {76, -28}, {76, -70}}, color = {191, 0, 0}));
  connect(Gain_wall.Q_flow, P_wall) annotation(
    Line(points = {{60, 10}, {60, 40}}, color = {0, 0, 127}));
  connect(Gain_wall.port, Cw.port) annotation(
    Line(points = {{60, -10}, {60, -38}, {0, -38}, {0, -68}}, color = {191, 0, 0}));
  connect(Gain_in.Q_flow, P_in) annotation(
    Line(points = {{100, 10}, {100, 40}}, color = {0, 0, 127}));
  connect(Rs.port_b, Ri.port_a) annotation(
    Line(points = {{28, -50}, {44, -50}}, color = {191, 0, 0}));
  connect(Tin_sens.port, Rinf.port_b) annotation(
    Line(points = {{88, -50}, {76, -50}, {76, -14}, {34, -14}, {34, 4}, {10, 4}}, color = {191, 0, 0}));
  connect(Rinf.port_a, Text_convert.port) annotation(
    Line(points = {{-10, 4}, {-80, 4}, {-80, -50}, {-100, -50}}, color = {191, 0, 0}));
protected
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-160, 20}, {160, -100}})),
    version = "",
  Icon(graphics = {Rectangle(fillColor = {148, 223, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {0, -39}, fillColor = {194, 194, 194}, fillPattern = FillPattern.Solid, extent = {{-80, -61}, {80, 61}}), Polygon(origin = {0, 51}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, points = {{-80, -29}, {0, 29}, {80, -29}, {80, -29}, {-80, -29}}), Line(origin = {-56, -10}, points = {{-44, 0}, {44, 0}}, color = {170, 0, 0}, thickness = 0.8), Line(origin = {-16, -6}, points = {{4, -4}, {-4, 4}}, color = {170, 0, 0}, thickness = 0.8), Line(origin = {-16.3911, -14.9944}, rotation = -90, points = {{4, -4}, {-4, 4}}, color = {170, 0, 0}, thickness = 0.8), Line(origin = {-12, -87}, points = {{-87.9969, -3}, {-63.9969, -3}, {-63.9969, -9}, {88.0031, -9}, {88.0031, 9}, {-57.9969, 9}, {-57.9969, -3}, {74.0031, -3}, {74.0031, 3}, {-45.9969, 3}}, color = {170, 0, 0}, thickness = 0.5), Rectangle(origin = {46, -42}, fillColor = {18, 217, 235}, fillPattern = FillPattern.Solid, extent = {{-16, 22}, {16, -22}}), Ellipse(origin = {20, 0}, fillColor = {109, 109, 109}, fillPattern = FillPattern.Sphere, extent = {{-6, 6}, {6, -6}}), Line(origin = {63, 0}, points = {{-37, 0}, {37, 0}}, thickness = 0.5)}));
end R6C2;
