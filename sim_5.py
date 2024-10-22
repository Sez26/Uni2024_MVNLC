"""
Mutlivariable Nonlinear Control
Working on creating animated visuals for the simulation of the robotic arm control system
"""

import matplotlib.pyplot as plt
import matplotlib.animation as animation
import math
import numpy as np

# external python code files
import ref_gen_3 as ref_gen
import ref_print_0 as ref_print
import hardware_conv_0  as hardware_conv

# forgetting the control aspect lets get it to plot the linkage system
# closely following this example: https://matplotlib.org/stable/gallery/animation/double_pendulum.html#sphx-glr-gallery-animation-double-pendulum-py

# define global parameters
# length measurements are in m
num_int = 1000
r = 0.044
sq_sl = 0.086
tri_sl = 0.094
origin = [0.07, 0]
L1 = 0.095
L2 = 0.095

# generate reference coordinates
xy = ref_gen.circle_gen(r, origin, num_int)
# [xy,num_int] = ref_gen.square_gen(sq_sl, origin, num_int)
# [xy,num_int] = ref_gen.tri_gen(tri_sl, origin, num_int)


# split array for plotting
x_b = xy[:,0]
y_b = xy[:,1]
# print(xy)

# test functions
ref_gen.test_range(x_b, y_b, L1, L2)
ref_gen.test_paper(x_b)

# get theta values

[th_1, th_2] = ref_gen.get_thetas(xy[:, 0], xy[:, 1], L1, L2)
print(th_1[0:10])

th_1_w = hardware_conv.wrap_ref(th_1)
th_2_w = hardware_conv.wrap_ref(th_2)

print(th_2_w[0:10])

# th_1 = np.linspace(0,40,num_int)
# th_2 = np.linspace(0,40,num_int)


ref_gen.test_clash(th_2-th_1-math.pi)

# making reference signal file
# make time array
drawtime = 20 # s
dt = drawtime/num_int
ref_t = np.linspace(0,drawtime, num_int)

# combining arrays
save_dir = '/home/sez26/Uni2024/MVNLC/Uni2024_MVNLC/reference_signals/'
filename = 'ref_circ_5.h'
reference = np.column_stack((ref_t, th_1_w, th_2_w))

enc_per_rot = 131.25*16
ref_new = hardware_conv.enc_count(reference, enc_per_rot)

# calling print function
ref_print.print_ref(save_dir,filename, ref_new)


x_a = L1*np.cos(np.radians(th_1))
y_a = L1*np.sin(np.radians(th_1))

x_b = x_a + L2*np.cos(np.radians(th_2))
y_b = y_a + L2*np.sin(np.radians(th_2))

# plotting code (adapted)

fig = plt.figure(figsize=(5, 4))
ax = fig.add_subplot(autoscale_on=True, xlim=(-0.01, (L1+L2+0.01)), ylim=(-(L1+L2), (L1+L2)))
ax.set_aspect('equal')
ax.grid()

line, = ax.plot([], [], 'o-', lw=2)
trace, = ax.plot([], [], '.-', lw=1, ms=2)
time_template = 'time = %.1fs'
time_text = ax.text(0.05, 0.9, '', transform=ax.transAxes)

def animate(i):
    thisx = [0, x_a[i], x_b[i]]
    thisy = [0, y_a[i], y_b[i]]

    history_x = x_b[:i]
    history_y = y_b[:i]

    line.set_data(thisx, thisy)
    trace.set_data(history_x, history_y)
    time_text.set_text(time_template % (i*dt))
    return line, trace, time_text


ani = animation.FuncAnimation(
    fig, animate, num_int, interval=dt, blit=True)
plt.show()