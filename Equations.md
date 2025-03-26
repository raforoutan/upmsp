# The proposed MILP / Model Validation, Eq. 1-24

Equations (1-23) and (24) can be found in the folder : " Model Validation Example\FINAL CODE.lg4 "

In this line of code: f_sum=0.33*f1+0.33*f2+0.34*f3,
if you set all coefficients to 1, you will have the proposed MILP, and if you keep the same coefficients, 
you will have the weighted validation objective functions in relation 24.


# Comparison metrics, #Eq. 25-29
Equations (25-29) calculate the following metrics: MID, DM, SNS, RAS

In all benchmark algorithms, as well as the proposed Hybrid algorithm, 
the following function is used to calculate these metrics, as well as NPS:  " CreateOutput.m "
To calculate QM look for : " QM (Non-dominated sorting) " or " QM " which can be found in different folders.


# Parameter tuning, Eq. 30-32
Equations (30-32) are used to convert the metric values into a unified value, 
prioritizing metrics based on their significance and assigning weights accordingly.

Results can be found in : " Parameters Setting\Parameters Setting.xlsx "


# Shannon entropy (Finding superior algorithms), Eq. 33-35
Shannon entropy is first used to assign weights to each metric based on equations (33-35).

All comparisons between benchmark algorithms can be found in : " Numerical Experiments "
Results of Shannon entropy and Vikor can be found in : " Numerical Experiments\Numerical Results.xlsx "


# VIKOR MCDM, Eq. 36-40
The VIKOR multi-criteria decision making (MCDM) method is used to rank the algorithms as equations (36-40).

Code to calculate Vikor MCDM can be found in : " Numerical Experiments\Vikor\ALL\Entropy "
Vikor results to find superior algorithms are in : " Numerical Experiments\Vikor "
