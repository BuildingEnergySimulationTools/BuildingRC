within BuildingRC.Solar;

model SkyDiffuse

  parameter Modelica.Units.SI.Angle surface_tilt "Surfce tilt angle, 0 is facing ground";
  
  Modelica.Blocks.Interfaces.RealInput DHI(unit="W/m2")annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput DC (unit="W/m2")annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
equation
DC = DHI * (1 + Modelica.Math.cos(surface_tilt)) * 0.5;

annotation(
    Icon(graphics = {Rectangle(lineColor = {85, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-100, 100}, {100, -100}})}));
end SkyDiffuse;
