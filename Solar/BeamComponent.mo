within BuildingRC.Solar;

model BeamComponent

  

  parameter Modelica.Units.SI.Angle til(displayUnit="deg") "Surface tilt";
  parameter Modelica.Units.SI.Angle azi(displayUnit="deg") "Surface azimuth";


  Modelica.Blocks.Interfaces.RealInput solar_azimuth(displayUnit="deg") "Solar azimuth angle" annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput solar_zenith(displayUnit="deg") "Solar zenith angle" annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput dni(unit="W/m2") "Direct Normal Irradiation" annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));


  BuildingRC.Solar.AOIProjection aOIProjection annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    Icon(graphics = {Rectangle(fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Polygon(origin = {20, -38}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, points = {{-80, -62}, {80, 62}, {80, -62}, {-80, -62}}), Ellipse(origin = {-59, 62}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-23, 24}, {23, -24}}), Line(origin = {-22, 27.3182}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7), Line(origin = {-42.6818, 16.5}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7), Line(origin = {-11.1818, 47.0455}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7)}));
end BeamComponent;
