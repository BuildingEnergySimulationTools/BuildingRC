within BuildingRC.Solar;
block AOIProjection "Angle of Incidence Projection Calculation"
  extends Modelica.Blocks.Icons.Block;

  // Input ports for surface and solar angles
  Modelica.Blocks.Interfaces.RealInput surface_tilt(
    final quantity="Angle",
    final unit="deg",
    displayUnit="deg") 
    "Panel tilt from horizontal"
    annotation (Placement(visible = true, transformation(extent = {{-120, -50}, {-100, -30}}, rotation = 0), iconTransformation(extent = {{-120, -90}, {-100, -70}}, rotation = 0)));
    
    
  Modelica.Blocks.Interfaces.RealInput surface_azimuth(
    final quantity="Angle",
    final unit="deg",
    displayUnit="deg") 
    "Panel azimuth from north"
        annotation (Placement(visible = true, transformation(extent = {{-120, -30}, {-100, -10}}, rotation = 0), iconTransformation(extent = {{-120, -50}, {-100, -30}}, rotation = 0)));
        
  Modelica.Blocks.Interfaces.RealInput solar_zenith(
    final quantity="Angle",
    final unit="deg",
    displayUnit="deg")
    "Solar zenith angle" annotation (Placement(visible = true, transformation(extent = {{-120, 30}, {-100, 50}}, rotation = 0), iconTransformation(extent = {{-120, 28}, {-100, 48}}, rotation = 0)));
    
    
  Modelica.Blocks.Interfaces.RealInput solar_azimuth(
    final quantity="Angle",
    final unit="deg",
    displayUnit="deg")   
    "Solar azimuth angle" annotation (Placement(visible = true, transformation(extent = {{-120, 50}, {-100, 70}}, rotation = 0), iconTransformation(extent = {{-120, 70}, {-100, 90}}, rotation = 0)));

  // Output port for the dot product (projection)
  Modelica.Blocks.Interfaces.RealOutput projection "Dot product of panel normal and solar angle"
  annotation (Placement(visible = true, transformation(extent = {{100, -10}, {120, 10}}, rotation = 0), iconTransformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
  
protected 
  Real cos_surface_tilt, cos_solar_zenith, sin_surface_tilt, sin_solar_zenith, cos_azimuth_diff;

equation 
  // Convert degrees to radians for Modelica's trigonometric functions
  cos_surface_tilt = Modelica.Math.cos(surface_tilt * Modelica.Constants.pi / 180);
  sin_surface_tilt = Modelica.Math.sin(surface_tilt * Modelica.Constants.pi / 180);
  cos_solar_zenith = Modelica.Math.cos(solar_zenith * Modelica.Constants.pi / 180);
  sin_solar_zenith = Modelica.Math.sin(solar_zenith * Modelica.Constants.pi / 180);
  cos_azimuth_diff = Modelica.Math.cos((solar_azimuth - surface_azimuth) * Modelica.Constants.pi / 180);

  // Calculate the dot product (projection)
  projection = cos_surface_tilt * cos_solar_zenith + sin_surface_tilt * sin_solar_zenith * cos_azimuth_diff;

  // Clip the projection to the range [-1, 1]
  projection = max(-1, min(1, projection));

end AOIProjection;
