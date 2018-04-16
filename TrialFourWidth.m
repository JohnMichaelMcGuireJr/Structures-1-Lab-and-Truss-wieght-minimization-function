%% @coAuthor Pearson Hall aka the MF GOAT better than JMMcGuire
%% @Author John Michael McGuire AKA the human Matlab AKA the OG person to give himself a tag in Matlab
%% clear all is lazy 
format long;



PLAcompMax = 93.8 * 10^6;
PLATensile = 65.7 * 10^6;
PLAFlexural = 94.7 * 10^6;
PLAYoungsMod = 3.5 * 10^9;
E = 3.5 * 10^9;
sigmaY = 37 * 10^6;
PLAShearMod = 2.4 * 10^9;
PLATensileUlt = 35 * 10^6;
k = .5;
filename= 'Member Force Table';
safetyFactor = 1.2;
safetyFactorBreak = 1.08; 


axialLoadrange= 'd2:d23';
axialLoad= xlsread(filename, axialLoadrange);
shearFrange= 'e2:e23';
shearF= xlsread(filename, shearFrange);
momentsrange= 'f2:f23';
moments= xlsread(filename, momentsrange);
lengthRange = 'g2:g23';
L = xlsread(filename, lengthRange);
CompUlt = 17.9 * 10^6;
% width= .007;
% depth= .002:.00001:.012;
% 
% normStress = zeros(length(depth), leng
% th(axialLoad));
% for i = 1:length(depth)
%     MomentInertia = 1/12 * width * depth(i) ^ 3;
%     normStress(i,:) = axialLoad'./(width.*depth(i)) + moments'.*(width/2)./MomentInertia;
% end
% disp(normStress)

width = .003:.0001:.007;
depth = .008;
i = 1;
maxNormStress = ones(22, 41);
MomentInertia = ones(22, 41);
broken = zeros(22, 41);
JohnsonInt = ones(1,22);
JohnsonMethod = ones(22,41);
for  i = 1:41
    for j = 1:22
        if width(i) > depth
MomentInertia(j, i) = 1/12 .* width(i) * depth^ 3;
        else 
MomentInertia(j, i) = 1/12 .* depth * (width(i) ^ 3);
        end 
    A = width(i).*depth;
    maxNormStress(j, i) = abs(axialLoad(j)/(width(i).*depth)) + abs((moments(j)/1000).*(width(i)/2)./MomentInertia(j,i));
    r = sqrt(MomentInertia./A);
    Le = k.*L;
    EulerInt = Le(j)./r;
    JohnsonInt(j) = sqrt(2*pi^2*E/sigmaY);
    sigmaYMatrix = sigmaY .* ones(22, 41);
    PLATensileSafe = safetyFactor * PLATensileUlt;
    CompUltSafe = safetyFactor * CompUlt;
    EulerAxialLoad = pi^2 * E .* MomentInertia ./ ((k .* L).^2);
    if  EulerInt(j) < JohnsonInt(j)
        JohnsonMethod(j,i) = sigmaY - sigmaY^2./(4 .* pi^2 .* E) .* (Le(j)/r(j)).^2; 
    end
    % if norm stress failure and tensile failure would happen broken adds 1
    % if just norm stress would fail it adds a .5 so tension is ignored.
    maxNormStressSafe = maxNormStress.*safetyFactor;
    if (maxNormStressSafe(j, i)  > CompUlt) && (maxNormStressSafe(j, i) > PLATensileUlt)
        broken(j,i) = 1;
    elseif (maxNormStressSafe(j, i) > CompUlt) && (axialLoad(j) > 0)
        broken(j,i) = .5;
    end
    % if normal axial force with safety factor is higher than the load then
    % it adds .25 to the broken map matrix.  ignore if in tension. 
    maxNormalAxial = maxNormStress .* A;
    maxNormAxialSafe = maxNormalAxial * safetyFactor;
    if maxNormAxialSafe(j,i) > EulerAxialLoad(j,i) && axialLoad(j) > 0
        broken(j,i) = broken(j,i) + .25;
    end   
    if maxNormStressSafe(j,i) > JohnsonMethod(j,i) && (axialLoad(j) > 0)
       broken(j,i) =  broken(j,i) + .1;
    end    
    
    
    %
    %
    end
    M1 = broken(1:2,:);
    M2 = broken(3:4,:);
    M3 = broken(5:6,:);
    M4 = broken(7:8,:);
    M5 = broken(9:10,:);
    M6 = broken(11:12,:);
    M7 = broken(13:14,:);
    M8 = broken(15:16,:);
    M9 = broken(17:18,:);
    M10 = broken(19:20,:);
    M11 = broken(21:22,:);
    
% for j = 1:22
%     broken = ones(22, 81);
%     end
end 



