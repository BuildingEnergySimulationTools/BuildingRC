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
    Icon(graphics = {Rectangle(lineColor = {85, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-100, 100}, {100, -100}})}),
    Documentation(info = "<html><head></head><body><!--StartFragment--><p>The <code>SkyDiffuse</code> model calculates the diffuse solar irradiation from the sky on a tilted surface. This model uses the diffuse horizontal irradiation (DHI) and adjusts it based on the surface's tilt angle.</p><h2>Parameters</h2><ul><li><strong><code>surface_tilt</code></strong> (Angle in degrees):<br>The tilt angle of the surface, where 0° represents a surface facing the ground and 90° represents a vertical surface.</li></ul><h2>Inputs</h2><ul><li><strong><code>DHI</code></strong> (RealInput in W/m²):<br>Diffuse Horizontal Irradiation (DHI), which is the solar energy per unit area received from the sky hemisphere, excluding direct sunlight.</li></ul><h2>Output</h2><ul><li><strong><code>DC</code></strong> (RealOutput in W/m²):<br>Diffuse solar irradiation on the surface after considering its tilt.</li></ul><h2>Equations</h2><p>The output <code>DC</code> (diffuse irradiation on the surface) is calculated using the equation:</p><span class=\"katex-display\"><span class=\"katex\"><span class=\"katex-mathml\"><math xmlns=\"http://www.w3.org/1998/Math/MathML\" display=\"block\"><semantics><mrow><mi>D</mi><mi>C</mi><mo>=</mo><mi>D</mi><mi>H</mi><mi>I</mi><mo>×</mo><mrow><mo fence=\"true\">(</mo><mfrac><mrow><mn>1</mn><mo>+</mo><mi>cos</mi><mo>⁡</mo><mo stretchy=\"false\">(</mo><mtext>surface_tilt</mtext><mo stretchy=\"false\">)</mo></mrow><mn>2</mn></mfrac><mo fence=\"true\">)</mo></mrow></mrow><annotation encoding=\"application/x-tex\">DC = DHI 	imes \left( rac{1 + \cos(	ext{surface\_tilt})}{2} 
ight)</annotation></semantics></math></span></span></span><p>This formula accounts for the distribution of diffuse radiation over a tilted surface. The last term&nbsp;represents the portion of the sky dome visible to the tilted surface.</p><!--EndFragment--></body></html>"));
end SkyDiffuse;
