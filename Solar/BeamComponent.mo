within BuildingRC.Solar;

model BeamComponent

  parameter Modelica.Units.SI.Angle surface_azimuth "Surface Angle East of North";
  parameter Modelica.Units.SI.Angle surface_tilt "Surface Tilt angle, 0 is facing ground";


  Modelica.Blocks.Interfaces.RealInput solar_azimuth(unit="deg") "Solar azimuth angle" annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput solar_elevation(unit="deg") "Solar elevation angle" annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput bni(unit="W/m2") "Beam Normal Irradiation" annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Hdir(unit="W/m2") "" annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  BuildingRC.Solar.AOIProjection aOIProjection(
    final surface_azimuth=surface_azimuth,
    final surface_tilt=surface_tilt)  annotation(
    Placement(visible = true, transformation(origin = {8, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

  Hdir = max(0, bni * aOIProjection.projection);
  connect(solar_azimuth, aOIProjection.solar_azimuth) annotation(
    Line(points = {{-120, 60}, {-60, 60}, {-60, 30}, {-2, 30}}, color = {0, 0, 127}));
  connect(solar_elevation, aOIProjection.solar_elevation) annotation(
    Line(points = {{-120, 0}, {-60, 0}, {-60, 26}, {-2, 26}}, color = {0, 0, 127}));

  
annotation(
    Icon(graphics = {Rectangle(fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Polygon(origin = {20, -38}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, points = {{-80, -62}, {80, 62}, {80, -62}, {-80, -62}}), Ellipse(origin = {-59, 62}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-23, 24}, {23, -24}}), Line(origin = {-22, 27.3182}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7), Line(origin = {-42.6818, 16.5}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7), Line(origin = {-11.1818, 47.0455}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7)}));
end BeamComponent;
