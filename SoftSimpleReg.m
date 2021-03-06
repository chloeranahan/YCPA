winstyle = 'docked';
% winstyle = 'normal';

set(0,'DefaultFigureWindowStyle',winstyle)
set(0,'defaultaxesfontsize',18)
set(0,'defaultaxesfontname','Times New Roman')
% set(0,'defaultfigurecolor',[1 1 1])

% clear VARIABLES;
clear
global spatialFactor;
global c_eps_0 c_mu_0 c_c c_eta_0
global simulationStopTimes;
global AsymForcing
global dels
global SurfHxLeft SurfHyLeft SurfEzLeft SurfHxRight SurfHyRight SurfEzRight



dels = 0.75;
spatialFactor = 1;

c_c = 299792458;                  % speed of light
c_eps_0 = 8.8542149e-12;          % vacuum permittivity
c_mu_0 = 1.2566370614e-6;         % vacuum permeability
c_eta_0 = sqrt(c_mu_0/c_eps_0);


tSim = 200e-15
f = 230e12; %excitation frequency
% f = 100e12;
lambda = c_c/f;

xMax{1} = 20e-6;
nx{1} = 200;
ny{1} = 0.75*nx{1};


Reg.n = 1;

mu{1} = ones(nx{1},ny{1})*c_mu_0;

epi{1} = ones(nx{1},ny{1})*c_eps_0; %permittivity of area
%epi{1}(125:150,55:95)= c_eps_0*11.3; %permittivity of inclusion

%additional iniclusions to simulate grating (pt 3)
% epi{1}(125:150,5:45)= c_eps_0*11.3;
% epi{1}(125:150,105:145)= c_eps_0*11.3;

epi{1}(125:150,5:10)= c_eps_0*11.3;
epi{1}(125:150,15:20)= c_eps_0*11.3;
epi{1}(125:150,25:30)= c_eps_0*11.3;
epi{1}(125:150,35:40)= c_eps_0*11.3;
epi{1}(125:150,45:50)= c_eps_0*11.3;
epi{1}(125:150,55:60)= c_eps_0*11.3;
epi{1}(125:150,65:70)= c_eps_0*11.3;
epi{1}(125:150,75:80)= c_eps_0*11.3;
epi{1}(125:150,85:90)= c_eps_0*11.3;
epi{1}(125:150,95:100)= c_eps_0*11.3;
epi{1}(125:150,105:110)= c_eps_0*11.3;
epi{1}(125:150,115:120)= c_eps_0*11.3;
epi{1}(125:150,125:130)= c_eps_0*11.3;
epi{1}(125:150,135:140)= c_eps_0*11.3;
epi{1}(125:150,145:150)= c_eps_0*11.3;


sigma{1} = zeros(nx{1},ny{1});
sigmaH{1} = zeros(nx{1},ny{1});

dx = xMax{1}/nx{1};
dt = 0.25*dx/c_c;
nSteps = round(tSim/dt*2);
yMax = ny{1}*dx;
nsteps_lamda = lambda/dx

movie = 1;
Plot.off = 0;
Plot.pl = 0;
Plot.ori = '13';
Plot.N = 100;
Plot.MaxEz = 1.1;
Plot.MaxH = Plot.MaxEz/c_eta_0;
Plot.pv = [0 0 90];
Plot.reglim = [0 xMax{1} 0 yMax];


bc{1}.NumS = 1;
bc{1}.s(1).xpos = nx{1}/(4) + 1;
bc{1}.s(1).type = 'ss';
bc{1}.s(1).fct = @PlaneWaveBC;


% mag = -1/c_eta_0;
mag = 1; %turning on/off wave?
phi = 0;
omega = f*2*pi; %larger omega gives smaller wavelength (smaller, closer waves), smaller omega gives larger wavelength (larger waves)
% omega = 20*f;
betap = 0;
t0 = 30e-15; %speed/delay of wave propagation
% t0 = 0;
% st = 15e-15; %Electric field intensity
st = -0.05; %pt 3- enhanced the EF intenisty of the wave
s = 0; %scatter?
y0 = yMax/2; %wave vertical centre on axis
% y0 = 0;
sty = 1.5*lambda; %wave height
% sty = 0;
bc{1}.s(1).paras = {mag,phi,omega,betap,t0,st,s,y0,sty,'s'};

Plot.y0 = round(y0/dx);

bc{1}.xm.type = 'a';
bc{1}.xp.type = 'a'; %wrap around/deflection in those directions?
bc{1}.ym.type = 'a';
bc{1}.yp.type = 'a';

pml.width = 20 * spatialFactor;
pml.m = 3.5;

Reg.n  = 1;
Reg.xoff{1} = 0;
Reg.yoff{1} = 0;


% %multiple sources attempt
% bc{2}.NumS = 1;
% bc{2}.s(1).xpos = nx{1} + 1;
% bc{2}.s(1).type = 'ss';
% bc{2}.s(1).fct = @PlaneWaveBC;
% 
% mag2 = 1;
% phi2 = 0;
% omega2 = f*2*pi; 
% betap2 = 0;
% t02 = 0;
% st2 = -0.05; 
% s2 = 0;
% y02 = yMax/8;
% sty2 = 1.5*lambda;
% 
% bc{2}.s(1).paras = {mag2,phi2,omega2,betap2,t02,st2,s2,y02,sty2,'s'};
% 
% bc{2}.xm.type = 'a';
% bc{2}.xp.type = 'a'; 
% bc{2}.ym.type = 'a';
% bc{2}.yp.type = 'a';


RunYeeReg






