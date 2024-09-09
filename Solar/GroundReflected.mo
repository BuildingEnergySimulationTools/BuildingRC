within BuildingRC.Solar;

model GroundReflected
  parameter Modelica.Units.SI.Angle surface_tilt "Surfce tilt angle, 0 is facing ground";
  parameter Modelica.Units.SI.Area surface=1 "Surface Area";
  parameter Modelica.Units.SI.Efficiency albedo=0.25 "Ground reflexion";
  
  Modelica.Blocks.Interfaces.RealInput DHI(unit="W/m2")annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BHI(unit="W/m2")annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));    
  Modelica.Blocks.Interfaces.RealOutput GR (unit="W")annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
equation
GR = (BHI + DHI) * albedo * (1 - Modelica.Math.cos(surface_tilt)) * 0.5;

annotation(
    Icon(graphics = {Rectangle(origin = {0, 30}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 70}, {100, -70}}), Rectangle(origin = {0, -70}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 30}, {100, -30}}), Line(origin = {-23.835, -20}, points = {{13, -12}, {-13, 12}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {5.93204, -20}, points = {{13, -12}, {37, 12}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {4, -17}, points = {{0, -13}, {0, 13}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {-60.1263, 13.0291}, points = {{13, -12}, {-13, 12}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {3.59223, 20.1068}, points = {{0, -13}, {0, 13}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {39.3689, 12.6214}, points = {{13, -12}, {37, 12}}, color = {255, 255, 0}, thickness = 0.5)}));
end GroundReflected;
