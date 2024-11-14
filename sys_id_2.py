"""
Getting system identification reference signals
"""

import matplotlib.pyplot as plt
import matplotlib.animation as animation
import math
import numpy as np

# external python code files
import ref_gen_3 as ref_gen
import ref_print_0 as ref_print
import hardware_conv_0  as hardware_conv
import ref_fitting_2 as ref_fit
import ref_sig_plot

# define global parameters
# length measurements are in m
num_int = 1000
r = 0.044
sq_sl = 0.086
tri_sl = 0.094
origin = [0.08, -0.005]
L1 = 0.095
L2 = 0.095

# generate reference coordinates
# xy = ref_gen.circle_gen(r, origin, num_int)
[xy,num_int] = ref_gen.square_gen(sq_sl, origin, num_int)
# [xy,num_int] = ref_gen.tri_gen(tri_sl, origin, num_int)


# split array for testing
x_b = xy[:,0]
y_b = xy[:,1]
# print(xy)

# test functions
ref_gen.test_range(x_b, y_b, L1, L2)
ref_gen.test_paper(x_b)

# get theta values

[th_1, th_2] = ref_gen.get_thetas(xy[:, 0], xy[:, 1], L1, L2)

th_1_w = hardware_conv.wrap_ref(th_1)
th_2_w = hardware_conv.wrap_ref(th_2)


ref_gen.test_clash(th_2-th_1-180)

# making reference signal file
# make time array
drawtime = 20 # s
dt = drawtime/num_int
ref_t = np.linspace(0,drawtime, num_int)

# combining arrays
reference = np.column_stack((ref_t, th_1_w, th_2_w))

enc_per_rot = 131.25*16
ref_new = hardware_conv.enc_count(reference, enc_per_rot)
ref_new = hardware_conv.izzy_big_brain(ref_new)
ref_new = hardware_conv.izzy_big_brain_2(ref_new)

# for the square and triangle references
# ref_new = hardware_conv.Lizzy_adj(ref_new, 4)
# print(np.shape(ref_new))
# ref_new = ref_fit.b_spline_t(ref_new, 30, dt)
ref_new = ref_fit.S_curve(ref_new, 0.012)
print(ref_new)
print(reference)
ref_sig_plot.ref_plot([reference, ref_new], ["base","s_curve"])

# calling print function

save_dir = '/home/sez26/Uni2024/MVNLC/Uni2024_MVNLC/reference_signals/'
filename = 'ref_tri_6.h'
# ref_new = hardware_conv.Lizzy_adj(ref_new, 3)
# ref_print.print_ref(save_dir,filename, ref_new)
