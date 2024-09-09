within BuildingRC.Solar;

model FullSurfaceProjection
  parameter Modelica.Units.SI.Area surface_area=1 "Receiver surface";
  parameter Modelica.Units.SI.Angle surface_azimuth "Surface Azimuth, angle east of North";
  parameter Modelica.Units.SI.Angle surface_tilt "Surface tilt angle, 0 is facing ground";
  parameter Modelica.Units.SI.Efficiency albedo=0.25 "Fraction of ground reflected radiation";

  Modelica.Blocks.Interfaces.RealInput Sun_Elevation(unit="deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 34}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Azimuth(unit="deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 68}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, 36}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BHI(unit="W/m2") annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput DHI(unit="W/m2") annotation(
    Placement(visible = true, transformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, -34}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput BNI(unit="W/m2") annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, -68}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  BuildingRC.Solar.BeamComponent beamComponent(surface_azimuth = surface_azimuth, surface_tilt = surface_tilt)  annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Solar.SkyDiffuse skyDiffuse(surface_tilt = surface_tilt)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingRC.Solar.GroundReflected groundReflected(surface_tilt = surface_tilt)  annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3 annotation(
    Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput SolarPower(unit="W") annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  SolarPower = surface_area * add3.y;
  connect(Sun_Azimuth, beamComponent.solar_azimuth) annotation(
    Line(points = {{-120, 68}, {-70, 68}, {-70, 46}, {-12, 46}}, color = {0, 0, 127}));
  connect(Sun_Elevation, beamComponent.solar_elevation) annotation(
    Line(points = {{-120, 34}, {-70, 34}, {-70, 40}, {-12, 40}}, color = {0, 0, 127}));
  connect(BNI, beamComponent.bni) annotation(
    Line(points = {{-120, -60}, {-60, -60}, {-60, 34}, {-12, 34}}, color = {0, 0, 127}));
  connect(DHI, skyDiffuse.DHI) annotation(
    Line(points = {{-120, -30}, {-74, -30}, {-74, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(BHI, groundReflected.BHI) annotation(
    Line(points = {{-120, 0}, {-44, 0}, {-44, -36}, {-12, -36}}, color = {0, 0, 127}));
  connect(DHI, groundReflected.DHI) annotation(
    Line(points = {{-120, -30}, {-54, -30}, {-54, -44}, {-12, -44}}, color = {0, 0, 127}));
  connect(beamComponent.Hdir, add3.u1) annotation(
    Line(points = {{12, 40}, {28, 40}, {28, 8}, {56, 8}}, color = {0, 0, 127}));
  connect(skyDiffuse.DC, add3.u2) annotation(
    Line(points = {{12, 0}, {56, 0}}, color = {0, 0, 127}));
  connect(groundReflected.GR, add3.u3) annotation(
    Line(points = {{12, -40}, {20, -40}, {20, -8}, {56, -8}}, color = {0, 0, 127}));
annotation(
    Icon(graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Sphere, extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {0, -80}, fillColor = {153, 153, 153}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, -20}}), Polygon(origin = {45, -12}, lineColor = {170, 85, 0}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, points = {{-55, -48}, {55, 48}, {55, -48}, {-55, -48}}), Polygon(origin = {54, -9}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-36, -27}, {32, 33}, {36, 29}, {-32, -31}, {-36, -27}}), Ellipse(origin = {-53, 31}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-13, 13}, {13, -13}}), Line(origin = {11.488, 26.1293}, points = {{-12, 9}, {30, -5}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {11.488, 26.1293}, points = {{-12, 9}, {30, -5}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {3.65151, 17.1318}, points = {{-12, 9}, {30, -5}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {-5.0557, 7.8441}, points = {{-12, 9}, {30, -5}}, color = {255, 255, 0}, thickness = 0.5), Line(origin = {-62, -45}, points = {{-14, 9}, {12, -13}}, color = {255, 255, 0}, pattern = LinePattern.Dash, thickness = 0.5), Line(origin = {-35, -47}, points = {{-13, -11}, {13, 11}}, color = {255, 255, 0}, pattern = LinePattern.Dash, thickness = 0.5)}),
    Documentation(info = "<html><head></head><body><!--StartFragment--><p>The <code>FullSurfaceProjection</code> model computes the solar power received by a surface considering the direct beam radiation, diffuse sky radiation, and ground-reflected radiation. It includes a detailed projection of these solar components onto a tilted and azimuth-oriented surface.</p><h2>Parameters</h2><ul><li><strong>surface_area</strong>: Specifies the area of the receiving surface (default = 1 m²).</li><li><strong>surface_azimuth</strong>: Defines the azimuth angle of the surface, where 0° is North.</li><li><strong>surface_tilt</strong>: Specifies the tilt angle of the surface, where 0° is facing the ground.</li><li><strong>albedo</strong>: Represents the fraction of ground-reflected radiation (default = 0.25).</li></ul><h2>Inputs</h2><ul><li><strong>Sun_Elevation</strong> (<code>deg</code>): The elevation angle of the sun, defining its height above the horizon.</li><li><strong>Sun_Azimuth</strong> (<code>deg</code>): The azimuth angle of the sun, defining its position relative to the North.</li><li><strong>BHI</strong> (<code>W/m²</code>): Beam Horizontal Irradiance, representing the direct solar radiation on a horizontal plane.</li><li><strong>DHI</strong> (<code>W/m²</code>): Diffuse Horizontal Irradiance, representing the scattered solar radiation on a horizontal plane.</li><li><strong>BNI</strong> (<code>W/m²</code>): Beam Normal Irradiance, representing the direct solar radiation normal to the sun's rays.</li></ul><h2>Outputs</h2><ul><li><strong>SolarPower</strong> (<code>W</code>): The total solar power received by the surface, calculated as the sum of direct, diffuse, and ground-reflected components multiplied by the surface area.</li></ul><h2>Equations</h2><p>The model sums up the three components of solar radiation:</p><ul><li>Direct Beam Component: Calculated by the <code>beamComponent</code>.</li><li>Diffuse Sky Component: Calculated by the <code>skyDiffuse</code>.</li><li>Ground Reflected Component: Calculated by the <code>groundReflected</code>.</li></ul><p>The total solar power is computed as:&nbsp;</p><p><br><span class=\"katex\"><span class=\"katex-mathml\"><math xmlns=\"http://www.w3.org/1998/Math/MathML\"><semantics><mrow><mtext>SolarPower</mtext><mo>=</mo><mtext>surface_area</mtext><mo>×</mo><mo stretchy=\"false\">(</mo><mtext>Direct&nbsp;Beam</mtext><mo>+</mo><mtext>Diffuse&nbsp;Sky</mtext><mo>+</mo><mtext>Ground&nbsp;Reflected</mtext><mo stretchy=\"false\">)</mo></mrow><annotation encoding=\"application/x-tex\">\text{SolarPower} = \text{surface\_area} \times (\text{Direct Beam} + \text{Diffuse Sky} + \text{Ground Reflected})</annotation></semantics></math></span><br></span></p><!--EndFragment--></body></html>"));
end FullSurfaceProjection;
