
STOCHASTIC LOAD MODEL
---------------------

(Updated 2018-01-16 by Joakim Widén, Uppsala University, joakim.widen@angstrom.uu.se)

This Matlab package generates stochastic load profiles with the models described in the two scientific papers:

J. Widén & E. Wäckelgård (2010), A high-resolution stochastic model of domestic activity pattern and electricity demand, Applied Energy 87: 1880-1892.

J. Widén et al. (2009), A combined Markov-chain and bottom-up approach to modelling of domestic lighting demand, Energy and Buildings 41: 1001-1012.


UPDATES SINCE PUBLICATION OF THE SCIENTIFIC PAPERS:

In addition to the model as described in these papers, use of domestic hot water has been added. Two activities were added and identified from the time-use data: bathing and showering. Both showering and bathing were modeled with a constant flow rate during a specified period of time. In addition to these, a simple model was implemented for miscellaneous hot water tappings. These additional tappings are randomly added with a constant probability for each household member during times when the person is at home and active (not sleeping). Also, to make sure baths and showers do not occur unreasonably close together, a time frame is placed around baths within which all showers are removed.

In the standard parameters, the following is assumed: For showering a flow rate of 10 l/min during 4 minutes is assumed, and for bathing a flow rate of 16 l/min during 6 minutes. Additional tappings are assumed to occur at a given minute with a probability of 1%, with a flow rate of 4 l/min during 2 minutes. All these flow rates and times were chosen to comply with the DHW profiles developed within the IEA SHC Task 44(Haller et al., 2013).


HOW TO RUN THE MODEL: 

The model is run by first defining input parameter structs S, A and L and then using these as input to the function stochastic_load_model.m. Default values for the parameters are included in the m-files default_parameters_xxx.m, with xxx replaced by apartments or houses.

Simply write the following in the Matlab command window (or in a script):

>> [S,A,L] = default_parameters_apartments;

>> [P W act num_of_members] = stochastic_load_model(S,A,L);

The results are given in the structs P (for electric power) and W (for hot water). P.total gives the total power in Watts (1-min resolution) and W.total the total hot water use in liters/min.

See the m-files for more information about inputs and outputs. Further details are also given below.


M-FILES:

- stochastic_load_model.m: The main file. Imports input data and runs the activity sequence generation and the various appliance functions.

- default_parameters_xxx: Generates input parameter structs for stochastic_load_model.m using the default parameter values in the papers above. The parameter structs can be changed to include more simulated households, other appliance parameters, etc.

- synth_act_data_general.m: Generates activity sequences from the transition matrices.

- xxx_load.m: Appliance functions that build load profiles from the household members' activity sequences.

- persons_to_households.m: Transforms a matrix with data for individual persons into a matrix with household totals, e.g. for load profiles.


DATA FILES (in the input_stoch_model folder):

- M_x_y.mat; x = ap,det; y = wd,wed: Transition matrices for detached houses and apartments on weekdays and weekend days. The matrices are sized 12 x 12 x 1440, where the indices denote current state, next state, and time of day, respectively. The transition probabilities are hourly averaged but are stored per minute (the first 60 values are equal, and so on...) because it was practical for the minutely computations.

- x_on_load.mat and x_off_duration.mat; x = fridge,freezer: Load and cycle duration data for the cold appliances.

- daylight_year.mat: Yearly daylight data used in the lighting simulations.


DESCRIPTION OF THE MODEL PARAMETER STRUCTS (defined in default_parameters_xxx.m):

Simulation settings (S)

The following parameters defines choices and constraints for the simulation.

S.path: The path to the folder with input data (input_stoch_model)

S.numberOfHouseholds: Number of households to be simulated.

S.DST: Boolean indicating if a correction for daylight saving time (DST) is to be performed for the daylight data.

S.DSTStart: Date for shift to DST ('YYYY-MM-DD'). The exact year is not important.

S.DSTEnd: Date for shift from DST ('YYYY-MM-DD'). The exact year is not important.

S.startDate: Start date ('YYYY-MM-DD') for a subset of dates within the year that the simulation is restricted to. Running the program over the whole year is time-consuming, especially if a large number of households is simulated.

S.endDate: Corresponding subset end date ('YYYY-MM-DD').

S.days: 365 values of 1 or 2 indicating weekday (1) or weekend day (2) for each day of the year.

S.householdSizes: Distribution of household sizes. For example, [20 30 50] means that 20% of the households have 1 family member, 30% have 2 members and 50% have 3 members. The array can be arbitrarily long. N.B.: The values do not have to add up to 100%, the calculations are based on the relative proportions.  

S.householdType: A value indicating household type, set to 1 (detached houses) or 2 (apartments).
 
Appliance parameters (A)

These parameters define appliance load profiles. See the scientific papers for details.

A.FRIDGE_POWER
A.FREEZER_POWER
A.COOKING_POWER
A.WASHING_P1
A.WASHING_T1
A.WASHING_P2
A.WASHING_T2
A.DISHWASHING_P1
A.DISHWASHING_T1
A.DISHWASHING_P2
A.DISHWASHING_T2
A.DISHWASHING_P3
A.DISHWASHING_T3
A.TV_POWER_ACTIVE
A.TV_POWER_STANDBY
A.COMPUTER_POWER_ACTIVE
A.COMPUTER_POWER_STANDBY
A.AUDIO_POWER_ACTIVE
A.AUDIO_POWER_STANDBY
A.ADDITIONAL
A.BATH_FLOW_RATE
A.SHOWER_FLOW_RATE
A.ADD_FLOW_RATE
A.BATH_TIME
A.SHOWER_TIME
A.ADDITIONAL_TIME
A.ADD_INCIDENCE
A.SHOWER_ADJUSTMENT_TIME

Lighting parameters (L)

Parameters in the lighting model (see the scientific papers for details). The last array defines the proportions of households with the respective parameter set. The parameters are randomly assigned to the simulated households based on these proportions.

L.param1
L.param2
L.param3
L.fractions

