function [S,A,L] = default_parameters_houses

% Default parameters for detached houses

% Simulation settings (S)
S.path = 'input_stoch_model/';
S.numberOfHouseholds = 1;
S.DST = true;
S.DSTStart = '2015-03-29';
S.DSTEnd = '2015-10-25';
S.startDate = '2015-01-01';
S.endDate = '2015-12-31';
S.days = [repmat([1 1 1 1 1 2 2],1,52) 1];
S.householdSizes = [7 39 26 23 6 1 1];
S.householdType = 1;

% Appliance parameters (A)
A.FRIDGE_POWER = 50;
A.FREEZER_POWER = 80;
A.COOKING_POWER = 1500;
A.WASHING_P1 = 1800;
A.WASHING_T1 = 20;
A.WASHING_P2 = 150;
A.WASHING_T2 = 90;
A.DISHWASHING_P1 = 1944;
A.DISHWASHING_T1 = 17;
A.DISHWASHING_P2 = 120;
A.DISHWASHING_T2 = 40;
A.DISHWASHING_P3 = 1920;
A.DISHWASHING_T3 = 16;
A.TV_POWER_ACTIVE = 100;
A.TV_POWER_STANDBY = 20;
A.COMPUTER_POWER_ACTIVE = 100;
A.COMPUTER_POWER_STANDBY = 40;
A.AUDIO_POWER_ACTIVE = 30;
A.AUDIO_POWER_STANDBY = 6;
A.ADDITIONAL = 53;

% DHW parameters
A.BATH_FLOW_RATE = 16; % Litres per minute
A.SHOWER_FLOW_RATE = 10; % Litres per minute
A.ADD_FLOW_RATE = 4; % Litres per minute
A.BATH_TIME = 6; % Minutes
A.SHOWER_TIME = 4; % Minutes
A.ADDITIONAL_TIME = 2; % Minutes
A.ADD_INCIDENCE = 0.01; % Probability for additional tap
A.SHOWER_ADJUSTMENT_TIME = 360; % Time (mins) before and after bath that showering is set to zero 

% Lighting parameters (L)
L.param1 = [1000 40 80 200 0.1 40 40];
L.param2 = [1000 40 40 200 0.1 40 40];
L.param3 = [1000 0 40 160 0.1 40 0];
L.fractions = [0.2 0.2 0.6];