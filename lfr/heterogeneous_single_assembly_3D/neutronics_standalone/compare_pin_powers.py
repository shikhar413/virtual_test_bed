import numpy as np

base_csv_file = 'neutronics_out_pin_powers_0001.csv'
rgmb_csv_file = 'neutronics_rgmb_out_pin_powers_0001.csv'

with open(base_csv_file, 'r') as f:
    lines = f.readlines()

base_pin_powers = {}
base_pin_volumes = {}

for line in lines[1:]:
    pin_id, axial_id, power, volume = line.split(',')[:4]
    pin_id = int(pin_id)
    axial_id = int(axial_id)
    power = float(power)
    volume = float(volume)
    if axial_id > 0 and axial_id < 21:
        if pin_id not in base_pin_powers:
            base_pin_powers[pin_id] = power
            base_pin_volumes[pin_id] = volume
        else:
            base_pin_powers[pin_id] += power
            base_pin_volumes[pin_id] += volume

with open(rgmb_csv_file, 'r') as f:
    lines = f.readlines()

rgmb_pin_powers = {}
rgmb_pin_volumes = {}

for line in lines[1:]:
    pin_id, axial_id, power, volume = line.split(',')[:4]
    pin_id = int(pin_id)
    axial_id = int(axial_id)
    power = float(power)
    volume = float(volume)
    if axial_id == 5:
        rgmb_pin_powers[pin_id] = power
        rgmb_pin_volumes[pin_id] = volume

for pin_id in base_pin_powers:
    assert(np.isclose(base_pin_powers[pin_id], rgmb_pin_powers[pin_id]))
    assert(np.isclose(base_pin_volumes[pin_id], rgmb_pin_volumes[pin_id]))
