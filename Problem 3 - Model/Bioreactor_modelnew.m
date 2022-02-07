function F = Bioreactor_modelnew(t, inputs)

Fi = 51;
Fe = 51;
Tin = 25;
Tinag = 15;
%Values
V = inputs(1);
Cx = inputs(2);
Cp = inputs(3);
Cs = inputs(4);
Co2 = inputs(5);
Tr = inputs(6);
Tag = inputs(7);



% Process parameters: 
A1 = 9.5*10^8;
A2 = 2.55*10^33;
At = 1;
Cheatag = 4.18;
Cheatr = 4.18; 
Ea1 = 55000;
Ea2 = 220000;
Hna = -0.550;
Hca = -0.303;
Hmg = -0.314; 
Hh= -0.774; 
Hcl = 0.844;
Hco3 = 0.485;
Hoh = 0.941;
Kla0 = 38;
Ko2 = 8.86;
Kp = 0.139;
Kp1 = 0.070; 
Ks = 1.030; 
Ks1 = 1.680;
Kt = 3.6*10^5; 
Rsp = 0.435; 
Rsx = 0.607; 
V=1000; 
Vj = 50; 
Yo2 = 0.970; 
delHr = 518; 
Muo2 = 0.5; 
Mup = 1.790; 
Rhoag = 1000; 
Rhor=1080;
R = 8.314;

% Random
Csin = 60;
Fag = 51;

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
Icl = 0.5*Ccl*1; 
Ico3 = 0.5*Cco3*4; 
Ih = 0.5*Ch*1;
Ioh = 0.5*Coh*1; 

% Global Ionic Strength 
gis = Hna*Ina + Hca*Ica + Hmg*Img + Hh*Ih + Hcl*Icl + Hco3*Ico3 + Hoh*Ioh; 
% Dependence of eqm conc of O2 on temperature
C_o20 = 14.6 - 0.3943*Tr + 0.007714*Tr^2 - 0.0000646*Tr^3;

% Eqm conc of O2 in liquid phase
C_o2 = C_o20 * 10^(-gis); 

% Mass Transfer coeeficient
Kla = Kla0*(1.024^(Tr-20));

% Maximum specific growth rate
Mux = A1*exp(-(Ea1/(R*(Tr+273)))) - A2*exp(-(Ea2/(R*(Tr+273))));

% Model Equations
dVdt = Fi - Fe; 
dCxdt = ((Mux*Cx*Cs*exp(-(Kp*Cp)))/(Ks+Cs)) - ((Fe*Cx)/V);
dCpdt = ((Mup*Cx*Cs*exp(-(Kp1*Cp)))/(Ks1 + Cs)) - ((Fe*Cp)/V);
dCsdt = ((-Mux*Cx*Cs*exp(-(Kp*Cp)))/(Rsx*(Ks + Cs))) - ((Mup*Cx*Cs*exp(-(Kp1*Cp)))/(Rsp*(Ks1 + Cs))) + ((Fi*Csin)/V) - ((Fe*Cs)/V);
% Rate of O2 consumption
ro2 = (Muo2*Cx*Co2)/(Yo2*(Ko2+Co2));

dCo2dt = (Kla)*(C_o2 - Co2) - ro2;
dTrdt = ((Fi*(Tin + 273))/V) - ((Fe*(Tr+273))/(V)) + ((ro2*delHr)/(32*Rhor*Cheatr)) + ((Kt*At*(Tr - Tag))/(V*Rhor*Cheatr));
dTagdt = ((Fag*(Tinag - Tag))/Vj) + ((Kt*At*(Tr-Tag))/(Vj*Rhoag*Cheatag)); 
F = [dVdt; dCxdt; dCpdt; dCsdt; dCo2dt; dTrdt; dTagdt]; 
%F(1) = dVdt;
%F(2) = dCxdt;
%F(3) = dCpdt;
%F(4) = dCsdt; 
%F(5)= dCo2dt; 
%F(6) = dTrdt; 
%F(7) = dTagdt; 
end

