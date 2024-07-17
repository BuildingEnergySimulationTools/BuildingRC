within BuildingRC.Controls;

model Heating_Cooling_SP
  parameter Modelica.Units.SI.Power Max_power "Maximum Heating/Cooling power (compressor if HP)";
    parameter .Modelica.Blocks.Types.SimpleController controllerType=
         .Modelica.Blocks.Types.SimpleController.PID "Type of controller";
  parameter Real Kp=1 "Proportional constant";
  parameter Real Ki=0.5 "Integral constant";
  parameter Real Kd=0.1 "Derivative constant";
  
  
  Modelica.Blocks.Interfaces.RealInput Sensor_in(unit="C") annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Control_out(unit="W") annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Heating annotation(
    Placement(visible = true, transformation(origin = {50, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {50, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput Temp_SP(unit="C") annotation(
    Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanInput Cooling annotation(
    Placement(visible = true, transformation(origin = {-50, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-50, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Continuous.LimPID pid(Td = Kd, Ti = Ki, controllerType = controllerType, k = Kp, yMax = Max_power, yMin = -Max_power) annotation(
    Placement(visible = true, transformation(origin = {-14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold Is_heating annotation(
    Placement(visible = true, transformation(origin = {28, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch Power_out annotation(
    Placement(visible = true, transformation(origin = {66, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression off annotation(
    Placement(visible = true, transformation(origin = {20, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And Heat_required annotation(
    Placement(visible = true, transformation(origin = {64, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Not Is_cooling annotation(
    Placement(visible = true, transformation(origin = {0, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And Cooling_required annotation(
    Placement(visible = true, transformation(origin = {64, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {106, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Sensor_in, pid.u_m) annotation(
    Line(points = {{-120, 0}, {-88, 0}, {-88, -28}, {-14, -28}, {-14, -12}}, color = {0, 0, 127}));
  connect(Temp_SP, pid.u_s) annotation(
    Line(points = {{0, 120}, {-4, 120}, {-4, 38}, {-60, 38}, {-60, 0}, {-26, 0}}, color = {0, 0, 127}));
  connect(pid.y, Is_heating.u) annotation(
    Line(points = {{-2, 0}, {7, 0}, {7, -42}, {16, -42}}, color = {0, 0, 127}));
  connect(pid.y, Power_out.u1) annotation(
    Line(points = {{-2, 0}, {26, 0}, {26, -8}, {54, -8}}, color = {0, 0, 127}));
  connect(Power_out.y, Control_out) annotation(
    Line(points = {{78, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(off.y, Power_out.u3) annotation(
    Line(points = {{32, 26}, {42, 26}, {42, 8}, {54, 8}}, color = {0, 0, 127}));
  connect(Is_heating.y, Heat_required.u1) annotation(
    Line(points = {{40, -42}, {52, -42}}, color = {255, 0, 255}));
  connect(Heating, Heat_required.u2) annotation(
    Line(points = {{50, -120}, {48, -120}, {48, -50}, {52, -50}}, color = {255, 0, 255}));
  connect(Is_heating.y, Is_cooling.u) annotation(
    Line(points = {{40, -42}, {42, -42}, {42, -62}, {-28, -62}, {-28, -80}, {-12, -80}}, color = {255, 0, 255}));
  connect(Is_cooling.y, Cooling_required.u1) annotation(
    Line(points = {{11, -80}, {52, -80}}, color = {255, 0, 255}));
  connect(Cooling, Cooling_required.u2) annotation(
    Line(points = {{-50, -120}, {-50, -96}, {26, -96}, {26, -88}, {52, -88}}, color = {255, 0, 255}));
  connect(Cooling_required.y, or1.u2) annotation(
    Line(points = {{76, -80}, {88, -80}, {88, -66}, {94, -66}}, color = {255, 0, 255}));
  connect(Heat_required.y, or1.u1) annotation(
    Line(points = {{76, -42}, {84, -42}, {84, -58}, {94, -58}}, color = {255, 0, 255}));
  connect(or1.y, Power_out.u2) annotation(
    Line(points = {{118, -58}, {136, -58}, {136, -20}, {42, -20}, {42, 0}, {54, 0}}, color = {255, 0, 255}));

annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Diagram(coordinateSystem(extent = {{-140, 140}, {140, -140}})),
  Icon(graphics = {Rectangle(fillColor = {220, 220, 220}, fillPattern = FillPattern.Solid, extent = {{-60, 100}, {60, -100}}), Rectangle(origin = {0, 45}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-48, 45}, {48, -45}}), Line(origin = {-80, 50}, points = {{-20, 0}, {20, 0}}, color = {0, 0, 127}, thickness = 0.7), Line(origin = {-2, 76.81}, points = {{0, 13.1934}, {0, -12.8066}, {4, -6.80662}, {-4, -6.80662}, {0, -12.8066}}, thickness = 0.5), Text(origin = {1, 40}, extent = {{-37, 24}, {37, -24}}, textString = "X°C"), Text(origin = {-36, -69}, lineColor = {0, 0, 255}, extent = {{-14, 25}, {14, -25}}, textString = "C"), Text(origin = {36, -69}, lineColor = {255, 0, 0}, extent = {{-14, 25}, {14, -25}}, textString = "H"), Line(origin = {80, 0}, points = {{-20, 0}, {20, 0}}, thickness = 0.75)}));
end Heating_Cooling_SP;
