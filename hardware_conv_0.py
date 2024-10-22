"""
This is code to tweak the reference signals so they match the hardware requirements
"""
import numpy as np

def enc_count(ref, enc_per_rot):
    ref[:,[1,2]] = ref[:,[1,2]] / (360/enc_per_rot)
    ref_new = ref
    return ref_new

def wrap_ref(th):
    # convert theta range from 0 - 360 to -180 - 180
    # check if over 180
    # true then -360
    # otherwise return unchanged theta value
    wrap_th = np.where(th>180,(th-360),th)
    return wrap_th