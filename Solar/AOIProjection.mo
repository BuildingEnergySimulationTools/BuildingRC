within BuildingRC.Solar;

block AOIProjection "Angle of Incidence Projection Calculation"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Angle surface_azimuth "Surface Angle East of North";
  parameter Modelica.Units.SI.Angle surface_tilt "Surface Tilt angle, 0 is facing ground";
  
  // Input ports for solar angles
  Modelica.Blocks.Interfaces.RealInput solar_elevation(final quantity = "Angle", final unit = "deg", displayUnit = "deg") "Solar zenith angle" annotation(
    Placement(visible = true, transformation(extent = {{-120, 30}, {-100, 50}}, rotation = 0), iconTransformation(extent = {{-120, 28}, {-100, 48}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput solar_azimuth(final quantity = "Angle", final unit = "deg", displayUnit = "deg") "Solar azimuth angle" annotation(
    Placement(visible = true, transformation(extent = {{-120, 50}, {-100, 70}}, rotation = 0), iconTransformation(extent = {{-120, 70}, {-100, 90}}, rotation = 0)));
  // Output port for the dot product (projection)
  Modelica.Blocks.Interfaces.RealOutput projection "Dot product of panel normal and solar angle" annotation(
    Placement(visible = true, transformation(extent = {{100, -10}, {120, 10}}, rotation = 0), iconTransformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
protected
  Real cos_surface_tilt, cos_solar_zenith, sin_surface_tilt, sin_solar_zenith, cos_azimuth_diff, dot_product, solar_zenith;
equation

// Convert degrees to radians for Modelica's trigonometric functions
  solar_zenith = Modelica.Constants.pi / 2 - solar_elevation * Modelica.Constants.pi / 180;
  cos_surface_tilt = Modelica.Math.cos(surface_tilt);
  sin_surface_tilt = Modelica.Math.sin(surface_tilt);
  cos_solar_zenith = Modelica.Math.cos(solar_zenith);
  sin_solar_zenith = Modelica.Math.sin(solar_zenith);
  cos_azimuth_diff = Modelica.Math.cos((solar_azimuth * Modelica.Constants.pi / 180 - surface_azimuth));
// Calculate the dot product (projection)
  dot_product = cos_surface_tilt * cos_solar_zenith + sin_surface_tilt * sin_solar_zenith * cos_azimuth_diff;
  
// Clip the projection to the range [-1, 1]
  projection = max(-1, min(1, dot_product));
end AOIProjection;
