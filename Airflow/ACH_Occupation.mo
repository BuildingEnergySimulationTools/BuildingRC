within BuildingRC.Airflow;

model ACH_Occupation
  parameter Modelica.Units.SI.Volume Building_volume = 100 "Building or zone volume";
  parameter Real Infiltration_occupation = 0.15 "[Vol/h] Air Change Rate during occupation";
  parameter Real Infiltration_empty = 0.05 "[Vol/h] Air Change Rate during inoccupation";

  Real infiltration;
  constant Modelica.Units.SI.Time hour = 3600 "s";
  constant Modelica.Units.SI.SpecificHeatCapacity C_air = 1005 "[J/K.kg]";
  constant Modelica.Units.SI.Density Rho_air =  1.204 "kg/m3";
  
  Modelica.Blocks.Interfaces.RealInput Tin(unit="C") annotation(
    Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Text(unit="C") annotation(
    Placement(visible = true, transformation(origin = {-120, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Power_to_building(unit="W")  annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Occupancy annotation(
    Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-1.77636e-15, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  if Occupancy == 1 then
    infiltration = Infiltration_occupation;
  else
    infiltration = Infiltration_empty;
  end if;
  
  Power_to_building = Building_volume * infiltration / hour  * Rho_air * C_air * (Text - Tin);

annotation(
    Icon(graphics = {Rectangle(origin = {37, -26}, fillColor = {170, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-43, 74}, {43, -74}}), Ellipse(origin = {4, -28}, fillPattern = FillPattern.Solid, extent = {{-6, 6}, {6, -6}}), Ellipse(origin = {-51, 23}, fillColor = {223, 223, 223}, fillPattern = FillPattern.Solid, extent = {{-17, 17}, {17, -17}}), Line(origin = {-51.4096, -25.25}, points = {{0, 31}, {0, -31}}, thickness = 0.5), Line(origin = {-60.3496, -73.25}, points = {{9, 17}, {-9, -17}}, thickness = 0.5), Line(origin = {-34.4296, -65.8}, rotation = 270, points = {{23, -1}, {-9, -17}}, thickness = 0.5), Line(origin = {-51.3796, -14.25}, points = {{-29, 0}, {29, 0}}, thickness = 0.5), Line(origin = {-26, 87}, points = {{26, 13}, {26, -7}, {-26, -7}, {-26, -13}}, thickness = 0.5), Polygon(fillColor = {157, 208, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{80, -100}, {100, -100}, {100, 100}, {-100, 100}, {-100, 48}, {80, 48}, {80, -100}}), Line(origin = {-15.21, 68.79}, points = {{15.2067, 31.2067}, {15.2067, 1.20674}, {-14.7933, -30.7933}}, thickness = 0.5)}));
end ACH_Occupation;
