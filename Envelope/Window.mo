within BuildingRC.Envelope;

model Window
parameter Modelica.Units.SI.Area surface "Glazing and frame surface";
parameter Modelica.Units.SI.Angle azimuth "Azimuth angle. East of North";
parameter Modelica.Units.SI.Angle tilt "Tilt angle. 0 is facing ground";
parameter Modelica.Units.SI.CoefficientOfHeatTransfer Uwindow "Glazing and frame coefficient of heat transfer";
parameter Modelica.Units.SI.Efficiency SHGC "Solar Heat Gain Coefficient";
parameter Modelica.Units.SI.Efficiency Albedo "Coefficient for ground reflected radiation";
  BuildingRC.Solar.FullSurfaceProjection fullSurfaceProjection(albedo = Albedo,surface_area = surface,surface_azimuth = azimuth, surface_tilt = tilt)  annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput sun_elevation(unit="deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput sun_azimuth(unit="deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 38}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BHI(unit="W/m2") annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput DHI(unit="W/m2") annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BNI(unit="W/m2") annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Solar_gain(unit="W") annotation(
    Placement(visible = true, transformation(origin = {118, 30}, extent = {{-18, -18}, {18, 18}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput R_window(unit="K/W") annotation(
    Placement(visible = true, transformation(origin = {119, -29}, extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin = {110, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  Solar_gain = SHGC * fullSurfaceProjection.SolarPower;
  R_window = 1 / (surface * Uwindow);
  connect(sun_elevation, fullSurfaceProjection.Sun_Elevation) annotation(
    Line(points = {{-120, 80}, {-34, 80}, {-34, 8}, {-10, 8}}, color = {0, 0, 127}));
  connect(sun_azimuth, fullSurfaceProjection.Sun_Azimuth) annotation(
    Line(points = {{-120, 40}, {-54, 40}, {-54, 4}, {-10, 4}}, color = {0, 0, 127}));
  connect(BHI, fullSurfaceProjection.BHI) annotation(
    Line(points = {{-120, 0}, {-10, 0}}, color = {0, 0, 127}));
  connect(DHI, fullSurfaceProjection.DHI) annotation(
    Line(points = {{-120, -40}, {-70, -40}, {-70, -4}, {-10, -4}}, color = {0, 0, 127}));
  connect(BNI, fullSurfaceProjection.BNI) annotation(
    Line(points = {{-120, -80}, {-48, -80}, {-48, -6}, {-10, -6}}, color = {0, 0, 127}));

annotation(
    Icon(graphics = {Rectangle(fillColor = {194, 194, 194}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {-1, 1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-65, 65}, {65, -65}}), Rectangle(origin = {-1, 0}, lineColor = {255, 255, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Sphere, extent = {{-57, 58}, {57, -58}}), Rectangle(origin = {-1, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-3, 58}, {3, -58}}), Rectangle(origin = {29, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-27, -3}, {27, 3}}), Rectangle(origin = {-31, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-27, -3}, {27, 3}})}));
end Window;
