within BuildingRC.HVAC;

model HX_constant_efficiency

import Modelica.Units.SI;

parameter Modelica.Units.SI.Efficiency Efficiency = 0.8 "Heat exchanger constant efficiency";
parameter Modelica.Units.SI.SpecificHeatCapacity Cold_fluid_cap = 1005 "Default is air 20°C";
parameter Modelica.Units.SI.SpecificHeatCapacity Hot_fluid_cap = 1005 "Default is air 20°C";
  Modelica.Blocks.Interfaces.RealInput T_cold_in(unit="degC") annotation(
    Placement(visible = true, transformation(origin = {-120, -72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput T_hot_out(unit="degC") annotation(
    Placement(visible = true, transformation(origin = {-110, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-110, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput T_cold_out(unit="degC") annotation(
    Placement(visible = true, transformation(origin = {110, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_hot_in(unit="degC") annotation(
    Placement(visible = true, transformation(origin = {122, 70}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {110, 72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput m_cold_in(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {-120, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput m_cold_out(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput m_hot_in(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {120, 30}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput m_hot_out(unit="kg/s") annotation(
    Placement(visible = true, transformation(origin = {-110, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));


  SI.EntropyFlowRate cold_side_cap;
  SI.EntropyFlowRate hot_side_cap;
  SI.EntropyFlowRate transfer_cap;
  SI.Power q_hx_max;

equation
  cold_side_cap = m_cold_in * Cold_fluid_cap;
  hot_side_cap = m_hot_in * Hot_fluid_cap;
  
  transfer_cap = min(cold_side_cap, hot_side_cap);
  
  q_hx_max = transfer_cap * (T_hot_in - T_cold_in) * Efficiency;
  
  T_cold_out = T_cold_in + (q_hx_max / cold_side_cap);
  T_hot_out = T_hot_in - (q_hx_max / hot_side_cap);
  
  connect(m_cold_in, m_cold_out) annotation(
    Line(points = {{-120, -32}, {0, -32}, {0, -50}, {110, -50}}, color = {0, 0, 127}));
  connect(m_hot_in, m_hot_out) annotation(
    Line(points = {{120, 30}, {0, 30}, {0, 50}, {-110, 50}}, color = {0, 0, 127}));
annotation(
    Icon(graphics = {Rectangle(fillColor = {255, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 40}, {100, -40}}), Line(origin = {-1.33, -32.45}, points = {{-99, -27.8817}, {-79, -27.8817}, {-79, 26.1183}, {-53, 6.11831}, {-27, 28.1183}, {1, 4.11831}, {27, 26.1183}, {51, 2.11831}, {71, 26.1183}, {91, -5.88169}, {91, -27.8817}, {101, -27.8817}}, color = {0, 85, 255}, thickness = 2.5), Line(origin = {0.64, 31.76}, rotation = 180, points = {{-99, -27.8817}, {-79, -27.8817}, {-79, 26.1183}, {-53, 6.11831}, {-27, 28.1183}, {1, 4.11831}, {27, 26.1183}, {51, 2.11831}, {71, 26.1183}, {91, -5.88169}, {91, -27.8817}, {101, -27.8817}}, color = {255, 0, 255}, thickness = 2.5), Line(origin = {-6, -66}, points = {{-26, 0}, {26, 0}}, thickness = 1.5), Line(origin = {17.58, -66}, points = {{-5.58397, 8}, {6.41603, 0}, {-5.58397, -8}}, thickness = 1.5), Line(origin = {-25.0097, 69.3042}, rotation = 180, points = {{-5.58397, 8}, {6.41603, 0}, {-5.58397, -8}}, thickness = 1.5), Line(origin = {-0.75819, 69.3042}, rotation = 180, points = {{-26, 0}, {26, 0}}, thickness = 1.5)}));
end HX_constant_efficiency;
