within BuildingRC.Envelope;
model R8C3G
  
  parameter Modelica.Units.SI.Volume V_int "Building internal volume"
    annotation (Dialog(group="Enveloppe"));
  parameter Modelica.Units.SI.Area S_hc "Heated or Cooled building surface"
    annotation (Dialog(group="Enveloppe"));
  parameter Real Inf = 0.15 "Infiltration Air Change Rate [Vol/h]"
    annotation (Dialog(group="Enveloppe"));
  parameter Real Building_cq = 270 "Building daily heat capacity [kJ/m².K]"
    annotation (Dialog(group="Enveloppe"));
  parameter Real C_fur = 20 "Building furniture coefficient of heat capacity [kJ/m².K]"
    annotation (Dialog(group="Enveloppe"));
  parameter Modelica.Units.SI.Temperature T_init=293.15 "Building initial temperature"
    annotation (Dialog(group="Enveloppe"));

  
  parameter Modelica.Units.SI.Area S_walls "Exterior wall surface (without windows)"
      annotation (Dialog(group="Walls"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_wall "Walls+Roof coefficient of heat transfer" annotation (Dialog(group="Walls"));
  parameter Modelica.Units.SI.ThermalInsulance R_i = 0.33 "Internal surface resistance coefficient"
    annotation (Dialog(group="Walls"));
  parameter Modelica.Units.SI.ThermalInsulance R_e = 0.06 "External surface resistance coefficient"
    annotation (Dialog(group="Walls"));  

  parameter Modelica.Units.SI.Area S_windows "Exterior windows surface"
    annotation (Dialog(group="Windows"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_win "Windows coefficient of heat transfer"
    annotation (Dialog(group="Windows"));

  parameter Modelica.Units.SI.Area S_gf "Ground floor surface"
      annotation (Dialog(group="Floor"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_gf "Floor coefficient of heat transfer" annotation (Dialog(group="Floor"));
  parameter Modelica.Units.SI.ThermalInsulance R_if = 0.33 "Internal surface resistance coefficient"
    annotation (Dialog(group="Floor"));
  parameter Modelica.Units.SI.Temperature T_soil = 288.15 "Internal surface resistance coefficient"
    annotation (Dialog(group="Floor"));
  
  constant Modelica.Units.SI.SpecificHeatCapacity C_air = 1005 "[J/K.kg]";
  constant Modelica.Units.SI.Density Rho_air =  1.204 "kg/m3";
  constant Modelica.Units.SI.Time hour = 3600 "s";
  parameter Modelica.Units.SI.MassFlowRate m_inf = Inf * V_int * Rho_air / hour;
  //Infiltration flowrate
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
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Cw(C =5/6 * Building_cq * S_hc * 1000, T(displayUnit = "degC", start = T_init)) annotation(
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
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rs_floor(R = R_i / S_gf) annotation(
    Placement(visible = true, transformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Cf(C =1/6 * Building_cq * S_hc * 1000, T(displayUnit = "degC", start = T_init)) annotation(
    Placement(visible = true, transformation(origin = {140, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_floor(R = 1 / (U_gf * S_gf)) annotation(
    Placement(visible = true, transformation(origin = {110, -130}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tsoil annotation(
    Placement(visible = true, transformation(origin = {110, -170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
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
  connect(Cin.port, Rs_floor.port_a) annotation(
    Line(points = {{76, -70}, {110, -70}, {110, -80}}, color = {191, 0, 0}));
  connect(Rs_floor.port_b, Cf.port) annotation(
    Line(points = {{110, -100}, {110, -110}, {130, -110}}, color = {191, 0, 0}));
  connect(R_floor.port_b, Rs_floor.port_b) annotation(
    Line(points = {{110, -120}, {110, -100}}, color = {191, 0, 0}));
  connect(R_floor.port_a, Tsoil.port) annotation(
    Line(points = {{110, -140}, {110, -160}}, color = {191, 0, 0}));
protected
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-220, 60}, {180, -180}})),
    version = "",
  Icon(graphics = {Rectangle(fillColor = {148, 223, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {0, -39}, fillColor = {194, 194, 194}, fillPattern = FillPattern.Solid, extent = {{-80, -61}, {80, 61}}), Polygon(origin = {0, 51}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, points = {{-80, -29}, {0, 29}, {80, -29}, {80, -29}, {-80, -29}}), Line(origin = {-56, -10}, points = {{-44, 0}, {44, 0}}, color = {170, 0, 0}, thickness = 0.8), Line(origin = {-16, -6}, points = {{4, -4}, {-4, 4}}, color = {170, 0, 0}, thickness = 0.8), Line(origin = {-16.3911, -14.9944}, rotation = -90, points = {{4, -4}, {-4, 4}}, color = {170, 0, 0}, thickness = 0.8), Line(origin = {-12, -87}, points = {{-87.9969, -3}, {-63.9969, -3}, {-63.9969, -9}, {88.0031, -9}, {88.0031, 9}, {-57.9969, 9}, {-57.9969, -3}, {74.0031, -3}, {74.0031, 3}, {-45.9969, 3}}, color = {170, 0, 0}, thickness = 0.5), Rectangle(origin = {46, -42}, fillColor = {18, 217, 235}, fillPattern = FillPattern.Solid, extent = {{-16, 22}, {16, -22}}), Ellipse(origin = {20, 0}, fillColor = {109, 109, 109}, fillPattern = FillPattern.Sphere, extent = {{-6, 6}, {6, -6}}), Line(origin = {63, 0}, points = {{-37, 0}, {37, 0}}, thickness = 0.5)}));
end R8C3G;
