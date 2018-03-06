%% Compression Lab
% @author John Michael McGuire Jr.
% @version 3/5/18

clearvars 
%% Gathering Data from CSV and measured qualities
% lengths in mm, mass in grams, force in Newtons, and Volumes in mm^3
% popler Parallel measurements and data
PopParH = 38.19;
PopParL = 37.8567;
PopParW = 38.0133;
PopParA = PopParL * PopParW;
PopParVol = PopParH * PopParL * PopParW;
PopParM = 30.5965;
% downloads Popler Parallel
PopParTime = xlsread('Lab2DataXLS.csv','a9:a329');
PopParExt = xlsread('Lab2DataXLS.csv', 'b9:b329');
PopParLoad = xlsread('Lab2DataXLS.csv', 'c9:c329');

% popler cross measurements and data
PopCrsH = 37.333;
PopCrsL = 37.4467;
PopCrsW = 38.2867;
PopCrsA = PopCrsL * PopCrsW;
PopCrsVol = PopCrsH * PopCrsL * PopCrsW;
PopCrsM = 32.90375;
% downloads Popler cross
PopCrsTime = xlsread('Lab2DataXLS.csv','e9:e2414');
PopCrsExt = xlsread('Lab2DataXLS.csv', 'f9:f2414');
PopCrsLoad = xlsread('Lab2DataXLS.csv', 'g9:g2414');

% oak Parallel measurements and data 
OakParH = 39.31;
OakParL = 38.5433;
OakParW = 38.4267;
OakParA = OakParL * OakParW;
OakParVol = OakParH * OakParL * OakParW;
OakParM = 39.9932;
% downloads oak Parallel
OakParTime = xlsread('Lab2DataXLS.csv','i9:i331');
OakParExt = xlsread('Lab2DataXLS.csv', 'j9:j331');
OakParLoad = xlsread('Lab2DataXLS.csv', 'k9:k331');

% oak Cross measurements and data
OakCrsH = 38.4233;
OakCrsL = 38.43;
OakCrsW = 38.9533;
OakCrsA = OakCrsL * OakCrsW;
OakCrsVol = OakCrsH * OakCrsL * OakCrsW;
OakCrsM = 40.026;
% downloads oak cross
OakCrsTime = xlsread('Lab2DataXLS.csv','m9:m1678');
OakCrsExt = xlsread('Lab2DataXLS.csv', 'n9:n1678');
OakCrsLoad = xlsread('Lab2DataXLS.csv', 'o9:o1678');

%% calculations and plotting begin
% popler Parallel info
PopParStrs = abs(PopParLoad./PopParA);
PopParStrn = abs(PopParExt./PopParH);
PopParPlot = plot(PopParStrn, PopParStrs);
title('Poplar Parallel');
xlabel('Strain (mm/mm)');
ylabel('Stress MPa');
[PopParUlt, PopParMaxI] = max(PopParStrs);
hold on 
plot(PopParStrn(PopParMaxI), PopParUlt,'k*');
hold on
disp('Poplar Parallel Ulitmate Strength')
disp(PopParUlt)
% finds where the strain is .2% to find yield strength by looking at graph
PopParItrOf2Perc = find(PopParStrn < .002, 1, 'last' );
PopParItrOfEndLin = find(PopParStrn < .008, 1, 'last' );
PopParIntersect = find(PopParStrn < .0055, 1, 'last');
% finds modulus of ellasicity
% modulus of ellasticity is slope of linear section of graph
PopParMod = PopParStrn(1:PopParItrOfEndLin)\PopParStrs(1:PopParItrOfEndLin);
disp('Poplar parallel Mod of ellasticity')
disp(PopParMod)
PopParStrsAt2Perc = PopParMod * PopParStrn(PopParItrOf2Perc);
PopParyieldLine = PopParMod * PopParStrn(PopParItrOf2Perc:PopParIntersect)...
    - PopParStrsAt2Perc;
plot(PopParStrn(PopParItrOf2Perc:PopParIntersect), PopParyieldLine);
hold off
legend('Stress Strain Curve', 'Ultimate Stress', 'Linear Offset Stress Line');
figure
PopParModRes = (PopParMod * (PopParStrn(PopParItrOfEndLin))^2) / 2;
disp('Poplar Parallel Yield Strength')
disp(PopParyieldLine(end))
disp('Poplar parallel Modulus of Resilience')
disp(PopParModRes)

% popler cross info
PopCrsStrs = abs(PopCrsLoad./PopCrsA);
PopCrsStrn = abs(PopCrsExt./PopCrsH); 
PopCrsPlot= plot(PopCrsStrn, PopCrsStrs);
title('Poplar Cross');
xlabel('Strain (mm/mm)');
ylabel('Stress MPa');
[PopCrsUlt, PopCrsMaxI] = max(PopCrsStrs);
hold on
plot(PopCrsStrn(PopCrsMaxI), PopCrsUlt,'k*');
hold on
disp('Poplar Cross ultimate Stress')
disp(PopCrsUlt)
% finds where the strain is .2% to find yield strength by looking at graph
PopCrsItrOf2Perc = find(PopCrsStrn < .002, 1, 'last' );
PopCrsItrOfEndLin = find(PopCrsStrn < .02, 1, 'last' );
PopCrsIntersect = find(PopCrsStrn < .028, 1, 'last');
% finds modulus of ellasicity
% modulus of ellasticity is slope of linear section of graph
PopCrsMod = PopCrsStrn(1:PopCrsItrOfEndLin)\PopCrsStrs(1:PopCrsItrOfEndLin);
disp('Poplar Cross Mod of ellasticity')
disp(PopCrsMod)
PopCrsStrsAt2Perc = PopCrsMod * PopCrsStrn(PopCrsItrOf2Perc);
PopCrsyieldLine = PopCrsMod * PopCrsStrn(PopCrsItrOf2Perc:PopCrsIntersect)...
    - PopCrsStrsAt2Perc;
plot(PopCrsStrn(PopCrsItrOf2Perc:PopCrsIntersect), PopCrsyieldLine);
hold off
PopCrsModRes = (PopCrsMod * (PopCrsStrn(PopCrsItrOfEndLin))^2) / 2;
disp('Poplar Cross Yield Strength')
disp(PopCrsyieldLine(end))
disp('Poplar cross Modulus of Resilience')
disp(PopCrsModRes)
legend('Stress Strain Curve', 'Ultimate Stress', 'Linear Offset Stress Line');
figure



% Oak Parallel info
OakParStrs = abs(OakParLoad./OakParA);
OakParStrn = abs(OakParExt./OakParH);
OakParPlot = plot(OakParStrn, OakParStrs);
title('Oak Parallel');
xlabel('Strain (mm/mm)');
ylabel('Stress MPa');
[OakParUlt, OakParMaxI] = max(OakParStrs);
hold on
plot(OakParStrn(OakParMaxI), OakParUlt,'k*');
hold on
disp('Oak Parallel ultimate Stress')
disp(OakParUlt)
% finds where the strain is .2% to find yield strength by looking at graph
OakParItrOf2Perc = find(OakParStrn < .002, 1, 'last' );
OakParItrOfEndLin = find(OakParStrn < .008, 1, 'last' );
OakParIntersect = find(OakParStrn < .0055, 1, 'last');
% finds modulus of ellasicity
% modulus of ellasticity is slope of linear section of graph
OakParMod = OakParStrn(1:OakParItrOfEndLin)\OakParStrs(1:OakParItrOfEndLin);
disp('Oak parallel Mod of ellasticity')
disp(OakParMod)
OakParStrsAt2Perc = OakParMod * OakParStrn(OakParItrOf2Perc);
OakParyieldLine = OakParMod * OakParStrn(OakParItrOf2Perc:OakParIntersect)...
    - OakParStrsAt2Perc;
plot(OakParStrn(OakParItrOf2Perc:OakParIntersect), OakParyieldLine);
hold off
legend('Stress Strain Curve', 'Ultimate Stress', 'Linear Offset Stress Line');
figure
OakParModRes = (OakParMod * (OakParStrn(OakParItrOfEndLin))^2) / 2;
disp('Oak Parallel Yield Strength')
disp(OakParyieldLine(end))
disp('Oak parallel Modulus of Resilience')
disp(OakParModRes)


% Oak cross info
OakCrsStrs = abs(OakCrsLoad./OakCrsA);
OakCrsStrn = abs(OakCrsExt./OakCrsH);
OakCrsPlot = plot(OakCrsStrn, OakCrsStrs);
title('Oak Cross');
xlabel('Strain (mm/mm)');
ylabel('Stress MPa');
[OakCrsUlt, OakCrsMaxI] = max(OakCrsStrs);
hold on
plot(OakCrsStrn(OakCrsMaxI), OakCrsUlt,'k*');
disp('Oak Cross ultimate Stress')
disp(OakCrsUlt)
hold on
% finds where the strain is .2% to find yield strength by looking at graph
OakCrsItrOf2Perc = find(OakCrsStrn < .002, 1, 'last' );
OakCrsItrOfEndLin = find(OakCrsStrn < .04, 1, 'last' );
OakCrsIntersect = find(OakCrsStrn < .044, 1, 'last');
% finds modulus of ellasicity
% modulus of ellasticity is slope of linear section of graph
OakCrsMod = OakCrsStrn(1:OakCrsItrOfEndLin)\OakCrsStrs(1:OakCrsItrOfEndLin);
disp('Oak Cross Mod of ellasticity')
disp(OakCrsMod)
OakCrsStrsAt2Perc = OakCrsMod * OakCrsStrn(OakCrsItrOf2Perc);
OakCrsyieldLine = OakCrsMod * OakCrsStrn(OakCrsItrOf2Perc:OakCrsIntersect)...
    - OakCrsStrsAt2Perc;
plot(OakCrsStrn(OakCrsItrOf2Perc:OakCrsIntersect), OakCrsyieldLine);
legend('Stress Strain Curve', 'Ultimate Stress' ,'Linear Offset Stress Line');
hold off
OakCrsModRes = (OakCrsMod * (OakCrsStrn(OakCrsItrOfEndLin))^2) / 2;
disp('Oak Cross Yield Strength')
disp(OakCrsyieldLine(end))
disp('Oak cross Modulus of Resilience')
disp(OakCrsModRes)


