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
    Icon(graphics = {Rectangle(fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Polygon(origin = {20, -38}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, points = {{-80, -62}, {80, 62}, {80, -62}, {-80, -62}}), Ellipse(origin = {-59, 62}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-23, 24}, {23, -24}}), Line(origin = {-22, 27.3182}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7), Line(origin = {-42.6818, 16.5}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7), Line(origin = {-11.1818, 47.0455}, points = {{-16, 15}, {36, -35}}, color = {255, 255, 0}, thickness = 0.7)}),
    Documentation(info = "<html><head></head><body><!--StartFragment--><p>The <code>BeamComponent</code> model calculates the direct beam irradiation on a tilted and azimuth-oriented surface based on solar position inputs. It computes the projected beam normal irradiation (BNI) onto the surface using a predefined surface tilt and azimuth.</p><h2>Parameters</h2><ul><li><p><strong><code>surface_azimuth</code></strong> (Angle in degrees):<br>Surface azimuth angle measured east of North (0° is North, 90° is East).</p></li><li><p><strong><code>surface_tilt</code></strong> (Angle in degrees):<br>Surface tilt angle. A value of 0° means the surface is facing the ground, while 90° indicates the surface is vertical.</p></li></ul><h2>Inputs</h2><ul><li><p><strong><code>solar_azimuth</code></strong> (RealInput in degrees):<br>The solar azimuth angle, which represents the sun's position east of North.</p></li><li><p><strong><code>solar_elevation</code></strong> (RealInput in degrees):<br>The solar elevation angle, which indicates the sun's height above the horizon.</p></li><li><p><strong><code>bni</code></strong> (RealInput in W/m²):<br>Beam Normal Irradiation (BNI), which is the amount of solar energy per unit area received by a surface perpendicular to the solar beam.</p></li></ul><h2>Output</h2><ul><li><strong><code>Hdir</code></strong> (RealOutput in W/m²):<br>Direct beam irradiation projected on the surface.</li></ul><h2>Components</h2><ul><li><strong><code>AOIProjection</code></strong>:<br>A component that projects the solar angles onto the surface based on its azimuth and tilt. This component computes the projection factor that is used to adjust the Beam Normal Irradiation (BNI) to the orientation of the surface.</li></ul><h2>Equations</h2><p>The output <code>Hdir</code> (direct beam irradiation on the surface) is calculated using the equation:</p><span class=\"katex-display\"><span class=\"katex\"><span class=\"katex-mathml\"><math xmlns=\"http://www.w3.org/1998/Math/MathML\" display=\"block\"><semantics><mrow><mi>H</mi><mi>d</mi><mi>i</mi><mi>r</mi><mo>=</mo><mi>max</mi><mo>⁡</mo><mo stretchy=\"false\">(</mo><mn>0</mn><mo separator=\"true\">,</mo><mi>b</mi><mi>n</mi><mi>i</mi><mo>×</mo><mtext>AOIProjection.projection</mtext><mo stretchy=\"false\">)</mo></mrow><annotation encoding=\"application/x-tex\">Hdir = \max(0, bni 	imes 	ext{AOIProjection.projection})</annotation></semantics></math></span></span></span><p>This ensures that the output is non-negative, representing valid irradiation values.</p><h2>Connections</h2><p>The following connections are made between the model components:</p><ul><li><p><strong><code>solar_azimuth → AOIProjection.solar_azimuth</code></strong><br>The solar azimuth angle input is connected to the <code>AOIProjection</code> component's solar azimuth input.</p></li><li><p><strong><code>solar_elevation → AOIProjection.solar_elevation</code></strong><br>The solar elevation angle input is connected to the <code>AOIProjection</code> component's solar elevation input.</p></li></ul><!--EndFragment--></body></html>"));
end BeamComponent;
