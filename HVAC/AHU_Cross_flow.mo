within BuildingRC.HVAC;


model AHU_Cross_flow

  parameter Modelica.Units.SI.Efficiency HX_eff = 0.8 "Heat exchanger efficiency";
  
  
  constant Modelica.Units.SI.SpecificHeatCapacity C_air = 1005 "[J/K.kg]";
  constant Modelica.Units.SI.Density Rho_air =  1.204 "kg/m3";
  
  
  Modelica.Blocks.Interfaces.RealInput T_air_ext(unit="C") annotation(
    Placement(visible = true, transformation(origin = {-120, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_extracted(unit="C") annotation(
    Placement(visible = true, transformation(origin = {122, 70}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput T_blown(unit="C") annotation(
    Placement(visible = true, transformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput T_exhaust(unit="C") annotation(
    Placement(visible = true, transformation(origin = {-114, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-110, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Ctrl_m_blown_air(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {-70, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput Ctrl_m_extracted(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {-30, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-30, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput m_exhaust(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {-114, 48}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput m_blown(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Tset_hot_blown(unit="C") annotation(
    Placement(visible = true, transformation(origin = {30, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {30, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput Heat_to_stream(unit = "W") annotation(
    Placement(visible = true, transformation(origin = {28, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput Heat_to_building(unit = "W") annotation(
    Placement(visible = true, transformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));


  BuildingRC.HVAC.HX_constant_efficiency hX_constant_efficiency(Cold_fluid_cap = C_air, Efficiency = HX_eff, Hot_fluid_cap = C_air)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

  if hX_constant_efficiency.T_cold_out < Tset_hot_blown then
    Heat_to_stream = m_blown * C_air * (Tset_hot_blown - hX_constant_efficiency.T_cold_out);
    T_blown = Tset_hot_blown;
    else
    Heat_to_stream = 0;
    T_blown = hX_constant_efficiency.T_cold_out;
  end if;
  
  Heat_to_building = m_blown * C_air * (T_blown - T_extracted);
  
  connect(T_extracted, hX_constant_efficiency.T_hot_in) annotation(
    Line(points = {{122, 70}, {64, 70}, {64, 8}, {12, 8}}, color = {0, 0, 127}));
  connect(hX_constant_efficiency.T_hot_out, T_exhaust) annotation(
    Line(points = {{-10, 8}, {-46, 8}, {-46, 70}, {-114, 70}}, color = {0, 0, 127}));
  connect(T_air_ext, hX_constant_efficiency.T_cold_in) annotation(
    Line(points = {{-120, -70}, {-62, -70}, {-62, -6}, {-10, -6}}, color = {0, 0, 127}));
  connect(Ctrl_m_blown_air, hX_constant_efficiency.m_cold_in) annotation(
    Line(points = {{-70, 120}, {-58, 120}, {-58, -4}, {-10, -4}}, color = {0, 0, 127}));
  connect(Ctrl_m_extracted, hX_constant_efficiency.m_hot_in) annotation(
    Line(points = {{-30, 120}, {-30, 20}, {46, 20}, {46, 6}, {12, 6}}, color = {0, 0, 127}));
  connect(hX_constant_efficiency.m_cold_out, m_blown) annotation(
    Line(points = {{12, -4}, {52, -4}, {52, -50}, {110, -50}}, color = {0, 0, 127}));
  connect(hX_constant_efficiency.m_hot_out, m_exhaust) annotation(
    Line(points = {{-10, 6}, {-66, 6}, {-66, 48}, {-114, 48}}, color = {0, 0, 127}));
protected
  annotation(
    Icon(graphics = {Rectangle(fillColor = {222, 222, 222}, fillPattern = FillPattern.Solid, extent = {{-100, 80}, {100, -80}}), Rectangle(fillColor = {222, 222, 222},fillPattern = FillPattern.HorizontalCylinder, extent = {{-20, 80}, {20, -80}}), Ellipse(origin = {-66, -48}, extent = {{-24, 24}, {24, -24}}), Line(origin = {-47.863, -36.1654}, points = {{-19, 12}, {19, 12}, {19, -12}, {5, -12}}), Ellipse(origin = {-66, -48}, fillColor = {167, 167, 167}, fillPattern = FillPattern.Solid, extent = {{-14, 14}, {14, -14}}), Ellipse(origin = {68, 46}, extent = {{-24, 24}, {24, -24}}), Ellipse(origin = {68, 46}, fillColor = {167, 167, 167}, fillPattern = FillPattern.Solid, extent = {{-14, 14}, {14, -14}}), Line(origin = {50, 57}, points = {{20, 13}, {-20, 13}, {-20, -13}, {-6, -13}}), Rectangle(origin = {50, -51}, fillColor = {217, 67, 67}, fillPattern = FillPattern.Solid, extent = {{-10, 29}, {10, -29}}), Rectangle(origin = {70, -51}, fillColor = {3, 125, 255}, fillPattern = FillPattern.Solid, extent = {{-10, 29}, {10, -29}}), Line(origin = {50, -51}, rotation = -90, points = {{0, 7}, {0, -7}}, thickness = 1), Line(origin = {50.3669, -50.6331}, rotation = 180, points = {{0, 7}, {0, -7}}, thickness = 1), Line(origin = {70.9148, -51}, rotation = -90, points = {{0, 7}, {0, -7}}, thickness = 1)}));
end AHU_Cross_flow;
