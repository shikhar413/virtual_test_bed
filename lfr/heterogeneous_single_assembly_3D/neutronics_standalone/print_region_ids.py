# Map block ID to material ID in assign

with open('neutronics.i', 'r') as f:
    lines = f.readlines()

read_pin_line = False
read_assembly_line = False
read_extrude_line = False
read_assign_line = False
assembly_base_block_ids = {}
subdomain_swaps = {}
subdomain_mid_map = {}
n_axial = 10

for i, line in enumerate(lines):
    if read_pin_line:
        if 'ring_block_ids' in line:
            ring_block_ids = line.split('=')[-1].split("'")[1]
            for block_id in ring_block_ids.split():
                base_block_ids.append(block_id.split('{')[-1].split('}')[0])
        elif 'background_block_ids' in line:
            base_block_ids.append(line.split('{')[-1].split("}")[0])
            assembly_base_block_ids[pin_id] = base_block_ids
    if read_assembly_line:
        if 'background_block_id' in line:
            background_block_id = line.split('{')[-1].split('}')[0]
            assembly_base_block_ids['assembly_background'] = [background_block_id]
        elif 'duct_block_ids' in line:
            duct_block_ids = [j.split('{')[-1].split('}')[0] for j in line.split("'")[1].split()]
            assembly_base_block_ids['assembly_ducts'] = duct_block_ids
    if read_extrude_line:
        if 'subdomain_swaps' in line:
            for a in range(i, i+ n_axial):
                if a - i == 0:
                    blocks = [k.split('}')[0] for k in lines[a].split("'")[-1].split(';')[0].split('{')[1:]]
                elif a - i == 9:
                    blocks = [k.split('}')[0] for k in lines[a].split("'")[0].split('{')[1:]]
                else:
                    blocks = [k.split('}')[0] for k in lines[a].split(";")[0].split('{')[1:]]
                for k in range(0, len(blocks), 2):
                    subdomain_swaps['{}_ax{}'.format(blocks[k], a - i)] = blocks[k + 1]
    if read_assign_line:
        if 'subdomains' in line:
            subdomains = [k.split('{')[-1].split('}')[0] for k in line.split("'")[1].split()]
        if 'extra_element_ids' in line:
            eeids = [k.split('{')[-1].split('}')[0] for k in line.split("'")[1].split()]
            for j, subdomain in enumerate(subdomains):
                subdomain_mid_map[subdomain] = eeids[j]
    if '[]' in line:
        read_pin_line = False
        read_assembly_line = False
        read_extrude_line = False
        read_assign_line = False
    if '[Pin' in line and len(line) == 9:
        read_pin_line = True
        pin_id = line.split('[')[-1].split(']')[0]
        base_block_ids = []
    if '[ASM]' in line:
        read_assembly_line = True
    if '[extrude]' in line:
        read_extrude_line = True
    if '[assign]' in line:
        read_assign_line = True

for region_id in assembly_base_block_ids:
    print("\n" + region_id)
    for a in range(n_axial):
        axial_material_ids = []
        for block_id in assembly_base_block_ids[region_id]:
            axial_block_id = subdomain_swaps['{}_ax{}'.format(block_id, a)]
            axial_material_id = subdomain_mid_map[axial_block_id]
            axial_material_ids.append('${{{}}}'.format(axial_material_id))
        print(' '.join(axial_material_ids))
#print(assembly_base_block_ids)
#print(subdomain_swaps)
