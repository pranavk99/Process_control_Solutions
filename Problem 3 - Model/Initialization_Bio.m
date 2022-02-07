% Initialization

% Inorganic salts
mnacl = 500; 
mcaco3 = 100; 
mmgcl2 = 100; 

Mna = 22.9898;
Mca = 40.0789; 
Mmg = 24.3051;
Mco3 = 62;
Mcl = 35.5;
Mnacl = 58.44277;
Mcaco3 = 100.0869;
Mmgcl2 = 95.211;
%pH od liquid phase
pH = 6;

% Inputs
Fi = 511; 
Fe = 511;
Tin = 25;
Tout = 25;
Tinag = 15; 

% Molar concentrations
Cna = (mnacl*Mna)/(Mnacl*V); 
Cca = (mcaco3*Mca)/(Mcaco3*V);
Cmg = (mmgcl2*Mmg)/(Mmgcl2*V); 
Ccl = ((mnacl/Mnacl)+ (2*(mmgcl2/Mmgcl2)))*(Mcl/V);
Cco3 = (mcaco3*Mco3)/(Mcaco3*V); 
Ch = 10^(-pH); 
Coh = 10^(-(14-pH));

% Ionic strength
Ina = 0.5*Cna*1;
Ica = 0.5*Cca*4;
Img = 0.5*Cmg*4; 

% Global Ionic Strength 
gis = Hna*Ina + Hca*Ica + Hmg*Img + Hh*Ih + Hcl*Icl + Hco3*Ico3 + Hoh*Ioh; 
% Dependence of eqm conc of O2 on temperature
C_o20 = 14.6 - 0.3943*Tr + 0.007714*Tr^2 - 0.0000646*Tr^3;

% Eqm conc of O2 in liquid phase
C_o2 = C_o20 * 10^(-gis); 

% Mass Transfer coeeficient
Kla = Kla0*(1.024^(Tr-20));

% Rate of O2 consumption
ro2 = (Muo2*Cx*Co2)/(Yo2*(Ko2+Co2));

% Maximum specific growth rate
Mux = A1*exp(-(Ea1/(R*(Tr+273)))) - A2*exp(-(Ea2/(R*(Tr+273))));
