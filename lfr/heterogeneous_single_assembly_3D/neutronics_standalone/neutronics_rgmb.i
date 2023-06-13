# ==============================================================================
# Model description
# Application : Griffin
# ------------------------------------------------------------------------------
# Lemont, ANL, November 14th, 2022
# Author(s): Hansol Park, Emily Shemon
# If using or referring to this model, please cite as explained in
# https://mooseframework.inl.gov/virtual_test_bed/citing.html
# ==============================================================================
# - LFR 3D Single Assembly Hot Full Power Configuration GRIFFIN neutronics input
# - Single App
# ==============================================================================
# Geometry Info.
# ==============================================================================
pinpitch = 0.013424621          # m
fuel_r_o = 0.004318648          # m
fuel_r_i = 0.00202042           # m
clad_r_i = 0.004495             # m
clad_r_o = 0.0054037675         # m
duct_thickness = 0.003533       # m
asmgap_thickness = 0.0018375    # m
flat_to_flat = 0.153424         # m
asmpitch = ${fparse flat_to_flat + 2. * duct_thickness + 2. * asmgap_thickness}

# Below are axial coordinates in meter.
hA = 0.1007 # Lower Core Plate
hB = 0.4086 # Inlet Wrapper
hC = 0.4742 # Lower Bundle Grid and Lower Pins Plug
hD = 1.3327 # Lower Gas Plenum
hE = 1.3479 # Lower Thermal Insulator
hF = 2.4086 # Active Fuel Region
hG = 2.4237 # Upper Thermal Insulator
hH = 2.5450 # Upper Gas Plenum
hI = 2.5955 # Upper Bundle Grid and Upper Pins Plug
hJ = 3.5342 # Outlet Wrapper

# Below are heights of each axial zone in meter.
dhA = ${fparse hA - 0.0}
dhB = ${fparse hB - hA}
dhC = ${fparse hC - hB}
dhD = ${fparse hD - hC}
dhE = ${fparse hE - hD}
dhF = ${fparse hF - hE}
dhG = ${fparse hG - hF}
dhH = ${fparse hH - hG}
dhI = ${fparse hI - hH}
dhJ = ${fparse hJ - hI}

# Below are the numbers of axial meshes per axial zone.
num_axmeshA = 1
num_axmeshB = 3
num_axmeshC = 1
num_axmeshD = 9
num_axmeshE = 1
num_axmeshF = 20
num_axmeshG = 1
num_axmeshH = 2
num_axmeshI = 1
num_axmeshJ = 9

# ==============================================================================
# Library IDs
# ==============================================================================
lid_rgmb = 1

# ==============================================================================
# Material IDs
# ==============================================================================
mid_A = 100 # lid_A
mid_B = 200 # lid_B
mid_C = 300 # lid_C

# lid_D
mid_D_lead = 410
mid_D_clad = 420
mid_D_duct = 430
mid_D_tubemix = 440 # Plenum tube + Helium mixture

# lid_E
mid_E_lead = 510
mid_E_clad = 520
mid_E_duct = 530
mid_E_yszmix = 540 # YSZ + Helium mixture

mid_F_lead = 620    # lid_F_lead
mid_F_helium = 610  # lid_fuel_R1
mid_F_fuel_R1 = 601 # lid_fuel_R1
mid_F_fuel_R2 = 602 # lid_fuel_R2
mid_F_fuel_R3 = 603 # lid_fuel_R3
mid_F_fuel_R4 = 604 # lid_fuel_R4
mid_F_fuel_R5 = 605 # lid_fuel_R5
mid_F_fuel_R6 = 606 # lid_fuel_R6
mid_F_fuel_R7 = 607 # lid_fuel_R7
mid_F_clad = 640    # lid_F_clad
mid_F_duct = 650    # lid_F_duct
mid_F_leadgap = 630 # lid_F_leadgap

# lid_G
mid_G_lead = 710
mid_G_clad = 720
mid_G_duct = 730
mid_G_yszmix = 740 # YSZ + Helium mixture

# lid_H
mid_H_lead = 810
mid_H_clad = 820
mid_H_duct = 830
mid_H_springmix = 840 # Spring + Helium mixture

mid_I = 900  # lid_I
mid_J = 1000 # lid_J

# ==============================================================================
# Block IDs
# ==============================================================================
bid_rgmb = 'RGMB_ASSEMBLY1 RGMB_ASSEMBLY1_TRI'

# ==============================================================================
# Power
# ==============================================================================
totalpower = 3700000.0 # W

# ==============================================================================
# Mesh
# ==============================================================================
[Mesh]
  [rmp]
    type = ReactorMeshParams
    dim = 3
    geom = "Hex"
    assembly_pitch = ${fparse asmpitch}
    axial_regions = '${dhA} ${dhB} ${dhC} ${dhD} ${dhE} ${dhF} ${dhG} ${dhH} ${dhI} ${dhJ}'
    axial_mesh_intervals = '${num_axmeshA} ${num_axmeshB} ${num_axmeshC} ${num_axmeshD} ${num_axmeshE} ${num_axmeshF} ${num_axmeshG} ${num_axmeshH} ${num_axmeshI} ${num_axmeshJ}'
    top_boundary_id = 201
    bottom_boundary_id = 202
    radial_boundary_id = 200
  []

  [Pin1]
    type = PinMeshGenerator
    reactor_params = rmp
    pin_type = 1
    pitch = '${pinpitch}'
    num_sectors = 2
    mesh_intervals = '1 1 1 1 1'
    ring_radii = '${fuel_r_i} ${fuel_r_o} ${clad_r_i} ${clad_r_o}'
    region_ids='${mid_A} ${mid_A} ${mid_A} ${mid_A} ${mid_A};
                ${mid_B} ${mid_B} ${mid_B} ${mid_B} ${mid_B};
                ${mid_C} ${mid_C} ${mid_C} ${mid_C} ${mid_C};
                ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_clad} ${mid_D_lead};
                ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_clad} ${mid_E_lead};
                ${mid_F_helium} ${mid_F_fuel_R1} ${mid_F_helium} ${mid_F_clad} ${mid_F_lead};
                ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_clad} ${mid_G_lead};
                ${mid_H_springmix} ${mid_H_springmix} ${mid_H_springmix} ${mid_H_clad} ${mid_H_lead};
                ${mid_I} ${mid_I} ${mid_I} ${mid_I} ${mid_I};
                ${mid_J} ${mid_J} ${mid_J} ${mid_J} ${mid_J}'
    quad_center_elements = false
  []
  [Pin2]
    type = PinMeshGenerator
    reactor_params = rmp
    pin_type = 2
    pitch = '${pinpitch}'
    num_sectors = 2
    mesh_intervals = '1 1 1 1 1'
    ring_radii = '${fuel_r_i} ${fuel_r_o} ${clad_r_i} ${clad_r_o}'
    region_ids='${mid_A} ${mid_A} ${mid_A} ${mid_A} ${mid_A};
                ${mid_B} ${mid_B} ${mid_B} ${mid_B} ${mid_B};
                ${mid_C} ${mid_C} ${mid_C} ${mid_C} ${mid_C};
                ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_clad} ${mid_D_lead};
                ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_clad} ${mid_E_lead};
                ${mid_F_helium} ${mid_F_fuel_R2} ${mid_F_helium} ${mid_F_clad} ${mid_F_lead};
                ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_clad} ${mid_G_lead};
                ${mid_H_springmix} ${mid_H_springmix} ${mid_H_springmix} ${mid_H_clad} ${mid_H_lead};
                ${mid_I} ${mid_I} ${mid_I} ${mid_I} ${mid_I};
                ${mid_J} ${mid_J} ${mid_J} ${mid_J} ${mid_J}'
    quad_center_elements = false
  []
  [Pin3]
    type = PinMeshGenerator
    reactor_params = rmp
    pin_type = 3
    pitch = '${pinpitch}'
    num_sectors = 2
    mesh_intervals = '1 1 1 1 1'
    ring_radii = '${fuel_r_i} ${fuel_r_o} ${clad_r_i} ${clad_r_o}'
    region_ids='${mid_A} ${mid_A} ${mid_A} ${mid_A} ${mid_A};
                ${mid_B} ${mid_B} ${mid_B} ${mid_B} ${mid_B};
                ${mid_C} ${mid_C} ${mid_C} ${mid_C} ${mid_C};
                ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_clad} ${mid_D_lead};
                ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_clad} ${mid_E_lead};
                ${mid_F_helium} ${mid_F_fuel_R3} ${mid_F_helium} ${mid_F_clad} ${mid_F_lead};
                ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_clad} ${mid_G_lead};
                ${mid_H_springmix} ${mid_H_springmix} ${mid_H_springmix} ${mid_H_clad} ${mid_H_lead};
                ${mid_I} ${mid_I} ${mid_I} ${mid_I} ${mid_I};
                ${mid_J} ${mid_J} ${mid_J} ${mid_J} ${mid_J}'
    quad_center_elements = false
  []
  [Pin4]
    type = PinMeshGenerator
    reactor_params = rmp
    pin_type = 4
    pitch = '${pinpitch}'
    num_sectors = 2
    mesh_intervals = '1 1 1 1 1'
    ring_radii = '${fuel_r_i} ${fuel_r_o} ${clad_r_i} ${clad_r_o}'
    region_ids='${mid_A} ${mid_A} ${mid_A} ${mid_A} ${mid_A};
                ${mid_B} ${mid_B} ${mid_B} ${mid_B} ${mid_B};
                ${mid_C} ${mid_C} ${mid_C} ${mid_C} ${mid_C};
                ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_clad} ${mid_D_lead};
                ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_clad} ${mid_E_lead};
                ${mid_F_helium} ${mid_F_fuel_R4} ${mid_F_helium} ${mid_F_clad} ${mid_F_lead};
                ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_clad} ${mid_G_lead};
                ${mid_H_springmix} ${mid_H_springmix} ${mid_H_springmix} ${mid_H_clad} ${mid_H_lead};
                ${mid_I} ${mid_I} ${mid_I} ${mid_I} ${mid_I};
                ${mid_J} ${mid_J} ${mid_J} ${mid_J} ${mid_J}'
    quad_center_elements = false
  []
  [Pin5]
    type = PinMeshGenerator
    reactor_params = rmp
    pin_type = 5
    pitch = '${pinpitch}'
    num_sectors = 2
    mesh_intervals = '1 1 1 1 1'
    ring_radii = '${fuel_r_i} ${fuel_r_o} ${clad_r_i} ${clad_r_o}'
    region_ids='${mid_A} ${mid_A} ${mid_A} ${mid_A} ${mid_A};
                ${mid_B} ${mid_B} ${mid_B} ${mid_B} ${mid_B};
                ${mid_C} ${mid_C} ${mid_C} ${mid_C} ${mid_C};
                ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_clad} ${mid_D_lead};
                ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_clad} ${mid_E_lead};
                ${mid_F_helium} ${mid_F_fuel_R5} ${mid_F_helium} ${mid_F_clad} ${mid_F_lead};
                ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_clad} ${mid_G_lead};
                ${mid_H_springmix} ${mid_H_springmix} ${mid_H_springmix} ${mid_H_clad} ${mid_H_lead};
                ${mid_I} ${mid_I} ${mid_I} ${mid_I} ${mid_I};
                ${mid_J} ${mid_J} ${mid_J} ${mid_J} ${mid_J}'
    quad_center_elements = false
  []
  [Pin6]
    type = PinMeshGenerator
    reactor_params = rmp
    pin_type = 6
    pitch = '${pinpitch}'
    num_sectors = 2
    mesh_intervals = '1 1 1 1 1'
    ring_radii = '${fuel_r_i} ${fuel_r_o} ${clad_r_i} ${clad_r_o}'
    region_ids='${mid_A} ${mid_A} ${mid_A} ${mid_A} ${mid_A};
                ${mid_B} ${mid_B} ${mid_B} ${mid_B} ${mid_B};
                ${mid_C} ${mid_C} ${mid_C} ${mid_C} ${mid_C};
                ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_clad} ${mid_D_lead};
                ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_clad} ${mid_E_lead};
                ${mid_F_helium} ${mid_F_fuel_R6} ${mid_F_helium} ${mid_F_clad} ${mid_F_lead};
                ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_clad} ${mid_G_lead};
                ${mid_H_springmix} ${mid_H_springmix} ${mid_H_springmix} ${mid_H_clad} ${mid_H_lead};
                ${mid_I} ${mid_I} ${mid_I} ${mid_I} ${mid_I};
                ${mid_J} ${mid_J} ${mid_J} ${mid_J} ${mid_J}'
    quad_center_elements = false
  []
  [Pin7]
    type = PinMeshGenerator
    reactor_params = rmp
    pin_type = 7
    pitch = '${pinpitch}'
    num_sectors = 2
    mesh_intervals = '1 1 1 1 1'
    ring_radii = '${fuel_r_i} ${fuel_r_o} ${clad_r_i} ${clad_r_o}'
    region_ids='${mid_A} ${mid_A} ${mid_A} ${mid_A} ${mid_A};
                ${mid_B} ${mid_B} ${mid_B} ${mid_B} ${mid_B};
                ${mid_C} ${mid_C} ${mid_C} ${mid_C} ${mid_C};
                ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_tubemix} ${mid_D_clad} ${mid_D_lead};
                ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_yszmix} ${mid_E_clad} ${mid_E_lead};
                ${mid_F_helium} ${mid_F_fuel_R7} ${mid_F_helium} ${mid_F_clad} ${mid_F_lead};
                ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_yszmix} ${mid_G_clad} ${mid_G_lead};
                ${mid_H_springmix} ${mid_H_springmix} ${mid_H_springmix} ${mid_H_clad} ${mid_H_lead};
                ${mid_I} ${mid_I} ${mid_I} ${mid_I} ${mid_I};
                ${mid_J} ${mid_J} ${mid_J} ${mid_J} ${mid_J}'
    quad_center_elements = false
  []

  # This assembles the 7 pins into an assembly with a duct
  [ASM]
    type = AssemblyMeshGenerator
    inputs = 'Pin1 Pin2 Pin3 Pin4 Pin5 Pin6 Pin7'
    assembly_type = 1
    background_intervals = 1
    background_region_id = '${mid_A}
                            ${mid_B}
                            ${mid_C}
                            ${mid_D_lead}
                            ${mid_E_lead}
                            ${mid_F_lead}
                            ${mid_G_lead}
                            ${mid_H_lead}
                            ${mid_I}
                            ${mid_J}'
    duct_halfpitch = '${fparse flat_to_flat/2} ${fparse flat_to_flat/2 + duct_thickness}'
    duct_intervals = '1 1'
    duct_region_ids = '${mid_A} ${mid_A};
                       ${mid_B} ${mid_B};
                       ${mid_C} ${mid_C};
                       ${mid_D_duct} ${mid_D_lead};
                       ${mid_E_duct} ${mid_E_lead};
                       ${mid_F_duct} ${mid_F_leadgap};
                       ${mid_G_duct} ${mid_G_lead};
                       ${mid_H_duct} ${mid_H_lead};
                       ${mid_I} ${mid_I};
                       ${mid_J} ${mid_J}'
    extrude = true
    pattern = '6 6 6 6 6 6 6;
              6 5 5 5 5 5 5 6;
             6 5 4 4 4 4 4 5 6;
            6 5 4 3 3 3 3 4 5 6;
           6 5 4 3 2 2 2 3 4 5 6;
          6 5 4 3 2 1 1 2 3 4 5 6;
         6 5 4 3 2 1 0 1 2 3 4 5 6;
          6 5 4 3 2 1 1 2 3 4 5 6;
           6 5 4 3 2 2 2 3 4 5 6;
            6 5 4 3 3 3 3 4 5 6;
             6 5 4 4 4 4 4 5 6;
              6 5 5 5 5 5 5 6;
               6 6 6 6 6 6 6'
  []

  [copy_matid]
    type = ExtraElementIDCopyGenerator
    input = ASM
    source_extra_element_id = region_id
    target_extra_element_ids = 'material_id'
  []

  [PinIn_CM]
    type = PolygonConcentricCircleMeshGenerator
    num_sides = 6 # must be six to use hex pattern
    num_sectors_per_side = '2 2 2 2 2 2'
    polygon_size = ${fparse pinpitch / 2.}
    background_intervals = '1'
    background_block_ids = '1'
    preserve_volumes = on
    quad_center_elements = false
  []

  [PinOut_CM]
    type = PolygonConcentricCircleMeshGenerator
    num_sides = 6 # must be six to use hex pattern
    num_sectors_per_side = '2 2 2 2 2 2'
    polygon_size = ${fparse pinpitch / 2.}
    ring_radii = '${clad_r_o}'
    ring_intervals = '1'
    ring_block_ids = '2'
    background_intervals = '1'
    background_block_ids = '3'
    preserve_volumes = on
    quad_center_elements = false
  []

  # This assembles the 7 pins into an assembly with a duct
  [ASM_CM]
    type = PatternedHexMeshGenerator
    inputs = 'PinIn_CM PinOut_CM'
    pattern_boundary = hexagon
    background_intervals = '1'
    hexagon_size = ${fparse asmpitch / 2.}
    duct_sizes = '${fparse flat_to_flat/2} ${fparse flat_to_flat/2 + duct_thickness}'
    duct_sizes_style = apothem
    duct_intervals = '1 1'
    background_block_id = '4'
    duct_block_ids = '5 6'
    external_boundary_id = 997
    pattern = '1 1 1 1 1 1 1;
              1 0 0 0 0 0 0 1;
             1 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 1;
           1 0 0 0 0 0 0 0 0 0 1;
          1 0 0 0 0 0 0 0 0 0 0 1;
         1 0 0 0 0 0 0 0 0 0 0 0 1;
          1 0 0 0 0 0 0 0 0 0 0 1;
           1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 1;
             1 0 0 0 0 0 0 0 1;
              1 0 0 0 0 0 0 1;
               1 1 1 1 1 1 1'
  []
  [coarse_mesh]
    type = AdvancedExtruderGenerator
    input = ASM_CM
    heights = '${dhA} ${dhB} ${dhC} ${dhD} ${dhE} ${dhF} ${dhG} ${dhH} ${dhI} ${dhJ}'
    num_layers = '${num_axmeshA} ${num_axmeshB} ${num_axmeshC} ${num_axmeshD} ${num_axmeshE} ${num_axmeshF} ${num_axmeshG} ${num_axmeshH} ${num_axmeshI} ${num_axmeshJ}'
    direction = '0 0 1'
    top_boundary = 998
    bottom_boundary = 999
  []

  [cmesh]
    type = CoarseMeshExtraElementIDGenerator
    input = copy_matid
    coarse_mesh = coarse_mesh
    extra_element_id_name = coarse_element_id
  []
  uniform_refine = 0
[]

# ==============================================================================
# Transport Systems
# ==============================================================================
[TransportSystems]
  particle = neutron
  equation_type = eigenvalue
  G = 9
  VacuumBoundary = 'top bottom'
  ReflectingBoundary = 'outer_assembly_1'
  [sn]
    scheme = DFEM-SN
    family = L2_LAGRANGE
    order = FIRST
    AQtype = Gauss-Chebyshev
    NPolar = 2
    NAzmthl = 3
    NA = 1
    using_array_variable = true
    collapse_scattering  = true
  []
[]

# ==============================================================================
# Executioner
# ==============================================================================
[Executioner]
  type = SweepUpdate
  verbose = true

  richardson_rel_tol = 1e-4
  richardson_max_its = 500
  richardson_value = 'eigenvalue'
  inner_solve_type = SI
  max_inner_its = 7

  cmfd_acceleration = true
  coarse_element_id = coarse_element_id
[]

# ==============================================================================
# Flux Normalization for Total Power
# ==============================================================================
[PowerDensity]
  power = ${totalpower}
  power_density_variable = power_density
[]

# ==============================================================================
# Fuel pin-wise and axial mesh-wise power output
# ==============================================================================
[AuxVariables]
  [volume]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 1
  []
  [x_coord]
    family = LAGRANGE
    order = FIRST
    [InitialCondition]
      type = FunctionIC
      function = x
    []
  []
  [y_coord]
    family = LAGRANGE
    order = FIRST
    [InitialCondition]
      type = FunctionIC
      function = y
    []
  []
[]

[VectorPostprocessors]
  [pin_powers]
    type = ExtraIDIntegralVectorPostprocessor
    variable = 'volume x_coord y_coord power_density'
    id_name = 'pin_id plane_id'
  []
[]

[Outputs]
  [console]
    type = Console
    outlier_variable_norms = false
  []
  [pgraph]
    type = PerfGraphOutput
    level = 2
  []
  csv = true
  execute_on = 'timestep_end'
[]

# ==============================================================================
# Material assignment and cross section library
# ==============================================================================
[GlobalParams]
  library_file = '../cross_section/LFR_127Pin_9g_rgmb.xml'
  library_name = ISOTXS-neutron
  is_meter = true
  plus = true
  dbgmat = false
  grid_names = 'Tfuel'
  grid = '1'
  maximum_diffusion_coefficient = 1000
[]

[Materials]
  [AllMaterials]
    type = MicroNeutronicsMaterial
    block = '${bid_rgmb}'
    library_id = '${lid_rgmb}'

    materials = '
     Fuel_Hole ${mid_F_helium}
       pseudo_HE4L:2.512611E-05;

     Fuel_Ring1 ${mid_F_fuel_R1}
       pseudo_U234L:1.769055E-07
       pseudo_U235L:4.404137E-05
       pseudo_U238L:1.735054E-02
       pseudo_PU238L:1.244939E-05
       pseudo_PU239L:3.413306E-03
       pseudo_PU240L:1.319941E-03
       pseudo_PU241L:8.656869E-05
       pseudo_PU242L:1.234538E-04
       pseudo_AM241L:2.087265E-04
       pseudo_O16L:4.444138E-02;

     Fuel_Ring2 ${mid_F_fuel_R2}
       pseudo_U234M:1.769055E-07
       pseudo_U235M:4.404137E-05
       pseudo_U238M:1.735054E-02
       pseudo_PU238M:1.244939E-05
       pseudo_PU239M:3.413306E-03
       pseudo_PU240M:1.319941E-03
       pseudo_PU241M:8.656869E-05
       pseudo_PU242M:1.234538E-04
       pseudo_AM241M:2.087265E-04
       pseudo_O16M:4.444138E-02;

     Fuel_Ring3 ${mid_F_fuel_R3}
       pseudo_U234N:1.769055E-07
       pseudo_U235N:4.404137E-05
       pseudo_U238N:1.735054E-02
       pseudo_PU238N:1.244939E-05
       pseudo_PU239N:3.413306E-03
       pseudo_PU240N:1.319941E-03
       pseudo_PU241N:8.656869E-05
       pseudo_PU242N:1.234538E-04
       pseudo_AM241N:2.087265E-04
       pseudo_O16N:4.444138E-02;

     Fuel_Ring4 ${mid_F_fuel_R4}
       pseudo_U234O:1.769055E-07
       pseudo_U235O:4.404137E-05
       pseudo_U238O:1.735054E-02
       pseudo_PU238O:1.244939E-05
       pseudo_PU239O:3.413306E-03
       pseudo_PU240O:1.319941E-03
       pseudo_PU241O:8.656869E-05
       pseudo_PU242O:1.234538E-04
       pseudo_AM241O:2.087265E-04
       pseudo_O16O:4.444138E-02;

     Fuel_Ring5 ${mid_F_fuel_R5}
       pseudo_U234P:1.769055E-07
       pseudo_U235P:4.404137E-05
       pseudo_U238P:1.735054E-02
       pseudo_PU238P:1.244939E-05
       pseudo_PU239P:3.413306E-03
       pseudo_PU240P:1.319941E-03
       pseudo_PU241P:8.656869E-05
       pseudo_PU242P:1.234538E-04
       pseudo_AM241P:2.087265E-04
       pseudo_O16P:4.444138E-02;

     Fuel_Ring6 ${mid_F_fuel_R6}
       pseudo_U234Q:1.769055E-07
       pseudo_U235Q:4.404137E-05
       pseudo_U238Q:1.735054E-02
       pseudo_PU238Q:1.244939E-05
       pseudo_PU239Q:3.413306E-03
       pseudo_PU240Q:1.319941E-03
       pseudo_PU241Q:8.656869E-05
       pseudo_PU242Q:1.234538E-04
       pseudo_AM241Q:2.087265E-04
       pseudo_O16Q:4.444138E-02;

     Fuel_Ring7 ${mid_F_fuel_R7}
       pseudo_U234R:1.769055E-07
       pseudo_U235R:4.404137E-05
       pseudo_U238R:1.735054E-02
       pseudo_PU238R:1.244939E-05
       pseudo_PU239R:3.413306E-03
       pseudo_PU240R:1.319941E-03
       pseudo_PU241R:8.656869E-05
       pseudo_PU242R:1.234538E-04
       pseudo_AM241R:2.087265E-04
       pseudo_O16R:4.444138E-02;

     Fuel_Clad ${mid_F_clad}
       pseudo_FE54S:3.185952E-03
       pseudo_FE56S:5.001168E-02
       pseudo_FE57S:1.154947E-03
       pseudo_FE58S:1.537129E-04
       pseudo_NI58S:8.373412E-03
       pseudo_NI60S:3.225451E-03
       pseudo_NI61S:1.402235E-04
       pseudo_NI62S:4.469793E-04
       pseudo_NI64S:1.138947E-04
       pseudo_CR50S:5.643439E-04
       pseudo_CR52S:1.088250E-02
       pseudo_CR53S:1.234043E-03
       pseudo_CR54S:3.071758E-04
       pseudo_MN55S:1.271641E-03
       pseudo_MO92S:1.080550E-04
       pseudo_MO94S:6.735188E-05
       pseudo_MO95S:1.159146E-04
       pseudo_MO96S:1.214544E-04
       pseudo_MO97S:6.953578E-05
       pseudo_MO98S:1.757019E-04
       pseudo_MO100S:7.011875E-05
       pseudo_SI28S:1.300140E-03
       pseudo_SI29S:6.601594E-05
       pseudo_SI30S:4.351798E-05
       pseudo_CS:3.489938E-04
       pseudo_P31S:6.766687E-05
       pseudo_S32S:2.068704E-05
       pseudo_S33S:1.656123E-07
       pseudo_S34S:9.348567E-07
       pseudo_S36S:4.358298E-09
       pseudo_TI46S:3.210951E-05
       pseudo_TI47S:2.895766E-05
       pseudo_TI48S:2.869267E-04
       pseudo_TI49S:2.105602E-05
       pseudo_TI50S:2.016107E-05
       pseudo_VS:2.742873E-05
       pseudo_ZR90S:7.880535E-06
       pseudo_ZR91S:1.718520E-06
       pseudo_ZR92S:2.626878E-06
       pseudo_ZR94S:2.662077E-06
       pseudo_ZR96S:4.288701E-07
       pseudo_W182S:2.014107E-06
       pseudo_W183S:1.087650E-06
       pseudo_W184S:2.337892E-06
       pseudo_W186S:2.160800E-06
       pseudo_CU63S:1.520930E-05
       pseudo_CU65S:6.778986E-06
       pseudo_CO59S:2.370990E-05
       pseudo_CA40S:3.379743E-05
       pseudo_CA42S:2.255696E-07
       pseudo_CA43S:4.706582E-08
       pseudo_CA44S:7.272563E-07
       pseudo_CA46S:1.394535E-09
       pseudo_CA48S:6.519498E-08
       pseudo_NB93S:7.519752E-06
       pseudo_N14S:4.969370E-05
       pseudo_N15S:1.835515E-07
       pseudo_AL27S:2.589280E-05
       pseudo_TA181S:3.861021E-06
       pseudo_B10S:5.144462E-06
       pseudo_B11S:2.070704E-05;

     Fuel_Lead ${mid_F_lead}
       pseudo_PB204K:4.232323E-04
       pseudo_PB206K:7.285612E-03
       pseudo_PB207K:6.680995E-03
       pseudo_PB208K:1.584046E-02;

     Fuel_LeadGap ${mid_F_leadgap}
       pseudo_PB204U:4.232323E-04
       pseudo_PB206U:7.285612E-03
       pseudo_PB207U:6.680995E-03
       pseudo_PB208U:1.584046E-02;

     Fuel_Duct ${mid_F_duct}
       pseudo_FE54T:3.192503E-03
       pseudo_FE56T:5.011505E-02
       pseudo_FE57T:1.157401E-03
       pseudo_FE58T:1.540302E-04
       pseudo_NI58T:8.390808E-03
       pseudo_NI60T:3.232103E-03
       pseudo_NI61T:1.405101E-04
       pseudo_NI62T:4.479004E-04
       pseudo_NI64T:1.141301E-04
       pseudo_CR50T:5.655206E-04
       pseudo_CR52T:1.090501E-02
       pseudo_CR53T:1.236601E-03
       pseudo_CR54T:3.078103E-04
       pseudo_MN55T:1.274301E-03
       pseudo_MO92T:1.082801E-04
       pseudo_MO94T:6.749107E-05
       pseudo_MO95T:1.161601E-04
       pseudo_MO96T:1.217001E-04
       pseudo_MO97T:6.968007E-05
       pseudo_MO98T:1.760602E-04
       pseudo_MO100T:7.026407E-05
       pseudo_SI28T:1.302801E-03
       pseudo_SI29T:6.615206E-05
       pseudo_SI30T:4.360804E-05
       pseudo_CT:3.497203E-04
       pseudo_P31T:6.780707E-05
       pseudo_S32T:2.073002E-05
       pseudo_S33T:1.659602E-07
       pseudo_S34T:9.367909E-07
       pseudo_S36T:4.367304E-09
       pseudo_TI46T:3.217603E-05
       pseudo_TI47T:2.901703E-05
       pseudo_TI48T:2.875203E-04
       pseudo_TI49T:2.110002E-05
       pseudo_TI50T:2.020302E-05
       pseudo_VT:2.748603E-05
       pseudo_ZR90T:7.896908E-06
       pseudo_ZR91T:1.722102E-06
       pseudo_ZR92T:2.632303E-06
       pseudo_ZR94T:2.667603E-06
       pseudo_ZR96T:4.297604E-07
       pseudo_W182T:2.018302E-06
       pseudo_W183T:1.089901E-06
       pseudo_W184T:2.342702E-06
       pseudo_W186T:2.165302E-06
       pseudo_CU63T:1.524101E-05
       pseudo_CU65T:6.793007E-06
       pseudo_CO59T:2.375902E-05
       pseudo_CA40T:3.386703E-05
       pseudo_CA42T:2.260402E-07
       pseudo_CA43T:4.716405E-08
       pseudo_CA44T:7.287707E-07
       pseudo_CA46T:1.397401E-09
       pseudo_CA48T:6.533006E-08
       pseudo_NB93T:7.535407E-06
       pseudo_N14T:4.979705E-05
       pseudo_N15T:1.839302E-07
       pseudo_AL27T:2.594703E-05
       pseudo_TA181T:3.869004E-06
       pseudo_B10T:5.155105E-06
       pseudo_B11T:2.075002E-05;

     LowerCorePlate ${mid_A}
       pseudo_FE54A:2.357119E-03
       pseudo_FE56A:3.700230E-02
       pseudo_FE57A:8.545370E-04
       pseudo_FE58A:1.137209E-04
       pseudo_NI58A:4.964541E-03
       pseudo_NI60A:1.912316E-03
       pseudo_NI61A:8.313568E-05
       pseudo_NI62A:2.650122E-04
       pseudo_NI64A:6.752956E-05
       pseudo_CR50A:4.670038E-04
       pseudo_CR52A:9.005674E-03
       pseudo_CR53A:1.021208E-03
       pseudo_CR54A:2.541921E-04
       pseudo_MN55A:6.804056E-04
       pseudo_MO92A:1.208810E-04
       pseudo_MO94A:7.534562E-05
       pseudo_MO95A:1.296811E-04
       pseudo_MO96A:1.358711E-04
       pseudo_MO97A:7.778964E-05
       pseudo_MO98A:1.965516E-04
       pseudo_MO100A:7.844165E-05
       pseudo_SI28A:6.346952E-04
       pseudo_SI29A:3.222827E-05
       pseudo_SI30A:2.124518E-05
       pseudo_CA:1.414012E-04
       pseudo_P31A:2.963124E-05
       pseudo_S32A:1.501712E-05
       pseudo_S33A:1.202210E-07
       pseudo_S34A:6.786456E-07
       pseudo_S36A:3.163826E-09
       pseudo_TI46A:4.392136E-06
       pseudo_TI47A:3.960833E-06
       pseudo_TI48A:3.924632E-05
       pseudo_TI49A:2.880124E-06
       pseudo_TI50A:2.757723E-06
       pseudo_VA:3.751831E-06
       pseudo_ZR90A:1.077909E-06
       pseudo_ZR91A:2.350719E-07
       pseudo_ZR92A:3.593130E-07
       pseudo_ZR94A:3.641330E-07
       pseudo_ZR96A:5.866348E-08
       pseudo_W182A:2.755023E-07
       pseudo_W183A:1.487712E-07
       pseudo_W184A:3.197926E-07
       pseudo_W186A:2.955624E-07
       pseudo_CU63A:2.080417E-06
       pseudo_CU65A:9.272576E-07
       pseudo_CO59A:3.243027E-06
       pseudo_CA40A:4.622938E-06
       pseudo_CA42A:3.085425E-08
       pseudo_CA43A:6.437853E-09
       pseudo_CA44A:9.947682E-08
       pseudo_CA46A:1.907516E-10
       pseudo_CA48A:8.917673E-09
       pseudo_NB93A:1.028608E-06
       pseudo_N14A:6.797356E-06
       pseudo_N15A:2.510621E-08
       pseudo_AL27A:3.541729E-06
       pseudo_TA181A:5.281244E-07
       pseudo_B10A:7.036758E-07
       pseudo_B11A:2.832423E-06
       pseudo_PB204A:1.170210E-04
       pseudo_PB206A:2.014417E-03
       pseudo_PB207A:1.847215E-03
       pseudo_PB208A:4.379936E-03;

     InletWrapper ${mid_B}
       pseudo_FE54B:2.614802E-04
       pseudo_FE56B:4.104560E-03
       pseudo_FE57B:9.479369E-05
       pseudo_FE58B:1.261549E-05
       pseudo_NI58B:6.872268E-04
       pseudo_NI60B:2.647203E-04
       pseudo_NI61B:1.150845E-05
       pseudo_NI62B:3.668443E-05
       pseudo_NI64B:9.347864E-06
       pseudo_CR50B:4.631781E-05
       pseudo_CR52B:8.931848E-04
       pseudo_CR53B:1.012839E-04
       pseudo_CR54B:2.521098E-05
       pseudo_MN55B:1.043741E-04
       pseudo_MO92B:8.868246E-06
       pseudo_MO94B:5.527715E-06
       pseudo_MO95B:9.513671E-06
       pseudo_MO96B:9.967888E-06
       pseudo_MO97B:5.707022E-06
       pseudo_MO98B:1.441956E-05
       pseudo_MO100B:5.754824E-06
       pseudo_SI28B:1.067042E-04
       pseudo_SI29B:5.418111E-06
       pseudo_SI30B:3.571639E-06
       pseudo_CB:2.864312E-05
       pseudo_P31_B:5.553616E-06
       pseudo_S32_B:1.697766E-06
       pseudo_S33_B:1.359253E-08
       pseudo_S34_B:7.672599E-08
       pseudo_S36_B:3.576939E-10
       pseudo_TI46B:2.635303E-06
       pseudo_TI47B:2.376593E-06
       pseudo_TI48B:2.354892E-05
       pseudo_TI49B:1.728167E-06
       pseudo_TI50B:1.654664E-06
       pseudo_VB:2.251188E-06
       pseudo_ZR90B:6.467752E-07
       pseudo_ZR91B:1.410455E-07
       pseudo_ZR92B:2.155884E-07
       pseudo_ZR94B:2.184885E-07
       pseudo_ZR96B:3.519937E-08
       pseudo_W182B:1.653064E-07
       pseudo_W183B:8.926448E-08
       pseudo_W184B:1.918775E-07
       pseudo_W186B:1.773469E-07
       pseudo_CU63B:1.248249E-06
       pseudo_CU65B:5.563717E-07
       pseudo_CO59B:1.945876E-06
       pseudo_CA40B:2.773808E-06
       pseudo_CA42B:1.851272E-08
       pseudo_CA43B:3.862851E-09
       pseudo_CA44B:5.968833E-08
       pseudo_CA46B:1.144545E-10
       pseudo_CA48B:5.350809E-09
       pseudo_NB93B:6.171741E-07
       pseudo_N14B:4.078559E-06
       pseudo_N15B:1.506459E-08
       pseudo_AL27B:2.125083E-06
       pseudo_TA181B:3.168823E-07
       pseudo_B10B:4.222165E-07
       pseudo_B11B:1.699466E-06
       pseudo_PB204B:3.885751E-04
       pseudo_PB206B:6.688961E-03
       pseudo_PB207B:6.133839E-03
       pseudo_PB208B:1.454357E-02;

     LowerBundle ${mid_C}
       pseudo_FE54C:1.251752E-03
       pseudo_FE56C:1.964981E-02
       pseudo_FE57C:4.537988E-04
       pseudo_FE58C:6.039250E-05
       pseudo_NI58C:3.289936E-03
       pseudo_NI60C:1.267252E-03
       pseudo_NI61C:5.509228E-05
       pseudo_NI62C:1.756173E-04
       pseudo_NI64C:4.474985E-05
       pseudo_CR50C:2.217292E-04
       pseudo_CR52C:4.275877E-03
       pseudo_CR53C:4.848501E-04
       pseudo_CR54C:1.206850E-04
       pseudo_MN55C:4.996407E-04
       pseudo_MO92C:4.245476E-05
       pseudo_MO94C:2.646209E-05
       pseudo_MO95C:4.554388E-05
       pseudo_MO96C:4.771797E-05
       pseudo_MO97C:2.732113E-05
       pseudo_MO98C:6.903086E-05
       pseudo_MO100C:2.754914E-05
       pseudo_SI28C:5.108111E-04
       pseudo_SI29C:2.593807E-05
       pseudo_SI30C:1.709871E-05
       pseudo_CC:1.371257E-04
       pseudo_P31C:2.658610E-05
       pseudo_S32C:8.127836E-06
       pseudo_S33C:6.507069E-08
       pseudo_S34C:3.673052E-07
       pseudo_S36C:1.712371E-09
       pseudo_TI46C:1.261552E-05
       pseudo_TI47C:1.137747E-05
       pseudo_TI48C:1.127347E-04
       pseudo_TI49C:8.273042E-06
       pseudo_TI50C:7.921328E-06
       pseudo_VC:1.077645E-05
       pseudo_ZR90C:3.096328E-06
       pseudo_ZR91C:6.752279E-07
       pseudo_ZR92C:1.032143E-06
       pseudo_ZR94C:1.045943E-06
       pseudo_ZR96C:1.685070E-07
       pseudo_W182C:7.913527E-07
       pseudo_W183C:4.273277E-07
       pseudo_W184C:9.185680E-07
       pseudo_W186C:8.489851E-07
       pseudo_CU63C:5.975747E-06
       pseudo_CU65C:2.663510E-06
       pseudo_CO59C:9.315485E-06
       pseudo_CA40C:1.327855E-05
       pseudo_CA42C:8.862667E-08
       pseudo_CA43C:1.849277E-08
       pseudo_CA44C:2.857418E-07
       pseudo_CA46C:5.479227E-10
       pseudo_CA48C:2.561506E-08
       pseudo_NB93C:2.954522E-06
       pseudo_N14_C:1.952481E-05
       pseudo_N15_C:7.211698E-08
       pseudo_AL27C:1.017342E-05
       pseudo_TA181C:1.516963E-06
       pseudo_B10C:2.021284E-06
       pseudo_B11C:8.135837E-06
       pseudo_PB204C:2.570306E-04
       pseudo_PB206C:4.424583E-03
       pseudo_PB207C:4.057368E-03
       pseudo_PB208C:9.620298E-03;

     D_TUBEMIX ${mid_D_tubemix}
       pseudo_FE54D:6.532669E-04
       pseudo_FE56D:1.025499E-02
       pseudo_FE57D:2.368260E-04
       pseudo_FE58D:3.151812E-05
       pseudo_NI58D:1.716934E-03
       pseudo_NI60D:6.613685E-04
       pseudo_NI61D:2.875159E-05
       pseudo_NI62D:9.165281E-05
       pseudo_NI64D:2.335454E-05
       pseudo_CR50D:1.157225E-04
       pseudo_CR52D:2.231534E-03
       pseudo_CR53D:2.530392E-04
       pseudo_CR54D:6.298624E-05
       pseudo_MN55D:2.607607E-04
       pseudo_MO92D:2.215631E-05
       pseudo_MO94D:1.381068E-05
       pseudo_MO95D:2.376862E-05
       pseudo_MO96D:2.490384E-05
       pseudo_MO97D:1.425877E-05
       pseudo_MO98D:3.602700E-05
       pseudo_MO100D:1.437779E-05
       pseudo_SI28D:2.665818E-04
       pseudo_SI29D:1.353663E-05
       pseudo_SI30D:8.923334E-06
       pseudo_CD:7.156191E-05
       pseudo_P31D:1.387470E-05
       pseudo_S32D:4.241824E-06
       pseudo_S33D:3.395960E-08
       pseudo_S34D:1.916872E-07
       pseudo_S36D:8.936736E-10
       pseudo_TI46D:6.584079E-06
       pseudo_TI47D:5.937654E-06
       pseudo_TI48D:5.883443E-05
       pseudo_TI49D:4.317539E-06
       pseudo_TI50D:4.134003E-06
       pseudo_VD:5.624293E-06
       pseudo_ZR90D:1.615914E-06
       pseudo_ZR91D:3.523885E-07
       pseudo_ZR92D:5.386347E-07
       pseudo_ZR94D:5.458561E-07
       pseudo_ZR96D:8.794009E-08
       pseudo_W182D:4.130003E-07
       pseudo_W183D:2.230133E-07
       pseudo_W184D:4.793831E-07
       pseudo_W186D:4.430761E-07
       pseudo_CU63D:3.118706E-06
       pseudo_CU65D:1.390070E-06
       pseudo_CO59D:4.861645E-06
       pseudo_CA40D:6.930147E-06
       pseudo_CA42D:4.625299E-08
       pseudo_CA43D:9.650875E-09
       pseudo_CA44D:1.491290E-07
       pseudo_CA46D:2.859556E-10
       pseudo_CA48D:1.336860E-08
       pseudo_NB93D:1.541900E-06
       pseudo_N14D:1.018998E-05
       pseudo_N15D:3.763731E-08
       pseudo_AL27D:5.309332E-06
       pseudo_TA181D:7.916938E-07
       pseudo_B10D:1.054905E-06
       pseudo_B11D:4.245925E-06
       pseudo_HE4D:1.990687E-05;

     D_Clad ${mid_D_clad}
       pseudo_FE54D:3.185952E-03
       pseudo_FE56D:5.001168E-02
       pseudo_FE57D:1.154947E-03
       pseudo_FE58D:1.537129E-04
       pseudo_NI58D:8.373412E-03
       pseudo_NI60D:3.225451E-03
       pseudo_NI61D:1.402235E-04
       pseudo_NI62D:4.469793E-04
       pseudo_NI64D:1.138947E-04
       pseudo_CR50D:5.643439E-04
       pseudo_CR52D:1.088250E-02
       pseudo_CR53D:1.234043E-03
       pseudo_CR54D:3.071758E-04
       pseudo_MN55D:1.271641E-03
       pseudo_MO92D:1.080550E-04
       pseudo_MO94D:6.735188E-05
       pseudo_MO95D:1.159146E-04
       pseudo_MO96D:1.214544E-04
       pseudo_MO97D:6.953578E-05
       pseudo_MO98D:1.757019E-04
       pseudo_MO100D:7.011875E-05
       pseudo_SI28D:1.300140E-03
       pseudo_SI29D:6.601594E-05
       pseudo_SI30D:4.351798E-05
       pseudo_CD:3.489938E-04
       pseudo_P31D:6.766687E-05
       pseudo_S32D:2.068704E-05
       pseudo_S33D:1.656123E-07
       pseudo_S34D:9.348567E-07
       pseudo_S36D:4.358298E-09
       pseudo_TI46D:3.210951E-05
       pseudo_TI47D:2.895766E-05
       pseudo_TI48D:2.869267E-04
       pseudo_TI49D:2.105602E-05
       pseudo_TI50D:2.016107E-05
       pseudo_VD:2.742873E-05
       pseudo_ZR90D:7.880535E-06
       pseudo_ZR91D:1.718520E-06
       pseudo_ZR92D:2.626878E-06
       pseudo_ZR94D:2.662077E-06
       pseudo_ZR96D:4.288701E-07
       pseudo_W182D:2.014107E-06
       pseudo_W183D:1.087650E-06
       pseudo_W184D:2.337892E-06
       pseudo_W186D:2.160800E-06
       pseudo_CU63D:1.520930E-05
       pseudo_CU65D:6.778986E-06
       pseudo_CO59D:2.370990E-05
       pseudo_CA40D:3.379743E-05
       pseudo_CA42D:2.255696E-07
       pseudo_CA43D:4.706582E-08
       pseudo_CA44D:7.272563E-07
       pseudo_CA46D:1.394535E-09
       pseudo_CA48D:6.519498E-08
       pseudo_NB93D:7.519752E-06
       pseudo_N14D:4.969370E-05
       pseudo_N15D:1.835515E-07
       pseudo_AL27D:2.589280E-05
       pseudo_TA181D:3.861021E-06
       pseudo_B10D:5.144462E-06
       pseudo_B11D:2.070704E-05;

     D_Lead ${mid_D_lead}
       pseudo_PB204D:4.232323E-04
       pseudo_PB206D:7.285612E-03
       pseudo_PB207D:6.680995E-03
       pseudo_PB208D:1.584046E-02;

     D_Duct ${mid_D_duct}
       pseudo_FE54D:3.192503E-03
       pseudo_FE56D:5.011505E-02
       pseudo_FE57D:1.157401E-03
       pseudo_FE58D:1.540302E-04
       pseudo_NI58D:8.390808E-03
       pseudo_NI60D:3.232103E-03
       pseudo_NI61D:1.405101E-04
       pseudo_NI62D:4.479004E-04
       pseudo_NI64D:1.141301E-04
       pseudo_CR50D:5.655206E-04
       pseudo_CR52D:1.090501E-02
       pseudo_CR53D:1.236601E-03
       pseudo_CR54D:3.078103E-04
       pseudo_MN55D:1.274301E-03
       pseudo_MO92D:1.082801E-04
       pseudo_MO94D:6.749107E-05
       pseudo_MO95D:1.161601E-04
       pseudo_MO96D:1.217001E-04
       pseudo_MO97D:6.968007E-05
       pseudo_MO98D:1.760602E-04
       pseudo_MO100D:7.026407E-05
       pseudo_SI28D:1.302801E-03
       pseudo_SI29D:6.615206E-05
       pseudo_SI30D:4.360804E-05
       pseudo_CD:3.497203E-04
       pseudo_P31D:6.780707E-05
       pseudo_S32D:2.073002E-05
       pseudo_S33D:1.659602E-07
       pseudo_S34D:9.367909E-07
       pseudo_S36D:4.367304E-09
       pseudo_TI46D:3.217603E-05
       pseudo_TI47D:2.901703E-05
       pseudo_TI48D:2.875203E-04
       pseudo_TI49D:2.110002E-05
       pseudo_TI50D:2.020302E-05
       pseudo_VD:2.748603E-05
       pseudo_ZR90D:7.896908E-06
       pseudo_ZR91D:1.722102E-06
       pseudo_ZR92D:2.632303E-06
       pseudo_ZR94D:2.667603E-06
       pseudo_ZR96D:4.297604E-07
       pseudo_W182D:2.018302E-06
       pseudo_W183D:1.089901E-06
       pseudo_W184D:2.342702E-06
       pseudo_W186D:2.165302E-06
       pseudo_CU63D:1.524101E-05
       pseudo_CU65D:6.793007E-06
       pseudo_CO59D:2.375902E-05
       pseudo_CA40D:3.386703E-05
       pseudo_CA42D:2.260402E-07
       pseudo_CA43D:4.716405E-08
       pseudo_CA44D:7.287707E-07
       pseudo_CA46D:1.397401E-09
       pseudo_CA48D:6.533006E-08
       pseudo_NB93D:7.535407E-06
       pseudo_N14D:4.979705E-05
       pseudo_N15D:1.839302E-07
       pseudo_AL27D:2.594703E-05
       pseudo_TA181D:3.869004E-06
       pseudo_B10D:5.155105E-06
       pseudo_B11D:2.075002E-05;

     E_YSZMIX ${mid_E_yszmix}
       pseudo_ZR90E:1.110556E-02
       pseudo_ZR91E:2.421721E-03
       pseudo_ZR92E:3.701685E-03
       pseudo_ZR94E:3.751388E-03
       pseudo_ZR96E:6.043603E-04
       pseudo_Y89__E:3.753788E-03
       pseudo_O16__E:4.880044E-02
       pseudo_HE4E:2.388520E-06;

     E_CLAD00 ${mid_E_clad}
       pseudo_FE54E:3.185952E-03
       pseudo_FE56E:5.001168E-02
       pseudo_FE57E:1.154947E-03
       pseudo_FE58E:1.537129E-04
       pseudo_NI58E:8.373412E-03
       pseudo_NI60E:3.225451E-03
       pseudo_NI61E:1.402235E-04
       pseudo_NI62E:4.469793E-04
       pseudo_NI64E:1.138947E-04
       pseudo_CR50E:5.643439E-04
       pseudo_CR52E:1.088250E-02
       pseudo_CR53E:1.234043E-03
       pseudo_CR54E:3.071758E-04
       pseudo_MN55E:1.271641E-03
       pseudo_MO92E:1.080550E-04
       pseudo_MO94E:6.735188E-05
       pseudo_MO95E:1.159146E-04
       pseudo_MO96E:1.214544E-04
       pseudo_MO97E:6.953578E-05
       pseudo_MO98E:1.757019E-04
       pseudo_MO100E:7.011875E-05
       pseudo_SI28E:1.300140E-03
       pseudo_SI29E:6.601594E-05
       pseudo_SI30E:4.351798E-05
       pseudo_CE:3.489938E-04
       pseudo_P31E:6.766687E-05
       pseudo_S32E:2.068704E-05
       pseudo_S33E:1.656123E-07
       pseudo_S34E:9.348567E-07
       pseudo_S36E:4.358298E-09
       pseudo_TI46E:3.210951E-05
       pseudo_TI47E:2.895766E-05
       pseudo_TI48E:2.869267E-04
       pseudo_TI49E:2.105602E-05
       pseudo_TI50E:2.016107E-05
       pseudo_VE:2.742873E-05
       pseudo_ZR90E:7.880535E-06
       pseudo_ZR91E:1.718520E-06
       pseudo_ZR92E:2.626878E-06
       pseudo_ZR94E:2.662077E-06
       pseudo_ZR96E:4.288701E-07
       pseudo_W182E:2.014107E-06
       pseudo_W183E:1.087650E-06
       pseudo_W184E:2.337892E-06
       pseudo_W186E:2.160800E-06
       pseudo_CU63E:1.520930E-05
       pseudo_CU65E:6.778986E-06
       pseudo_CO59E:2.370990E-05
       pseudo_CA40E:3.379743E-05
       pseudo_CA42E:2.255696E-07
       pseudo_CA43E:4.706582E-08
       pseudo_CA44E:7.272563E-07
       pseudo_CA46E:1.394535E-09
       pseudo_CA48E:6.519498E-08
       pseudo_NB93E:7.519752E-06
       pseudo_N14_E:4.969370E-05
       pseudo_N15_E:1.835515E-07
       pseudo_AL27E:2.589280E-05
       pseudo_TA181E:3.861021E-06
       pseudo_B10E:5.144462E-06
       pseudo_B11E:2.070704E-05;

     E_Lead ${mid_E_lead}
       pseudo_PB204E:4.232323E-04
       pseudo_PB206E:7.285612E-03
       pseudo_PB207E:6.680995E-03
       pseudo_PB208E:1.584046E-02;

     E_Duct ${mid_E_duct}
       pseudo_FE54E:3.192503E-03
       pseudo_FE56E:5.011505E-02
       pseudo_FE57E:1.157401E-03
       pseudo_FE58E:1.540302E-04
       pseudo_NI58E:8.390808E-03
       pseudo_NI60E:3.232103E-03
       pseudo_NI61E:1.405101E-04
       pseudo_NI62E:4.479004E-04
       pseudo_NI64E:1.141301E-04
       pseudo_CR50E:5.655206E-04
       pseudo_CR52E:1.090501E-02
       pseudo_CR53E:1.236601E-03
       pseudo_CR54E:3.078103E-04
       pseudo_MN55E:1.274301E-03
       pseudo_MO92E:1.082801E-04
       pseudo_MO94E:6.749107E-05
       pseudo_MO95E:1.161601E-04
       pseudo_MO96E:1.217001E-04
       pseudo_MO97E:6.968007E-05
       pseudo_MO98E:1.760602E-04
       pseudo_MO100E:7.026407E-05
       pseudo_SI28E:1.302801E-03
       pseudo_SI29E:6.615206E-05
       pseudo_SI30E:4.360804E-05
       pseudo_CE:3.497203E-04
       pseudo_P31E:6.780707E-05
       pseudo_S32E:2.073002E-05
       pseudo_S33E:1.659602E-07
       pseudo_S34E:9.367909E-07
       pseudo_S36E:4.367304E-09
       pseudo_TI46E:3.217603E-05
       pseudo_TI47E:2.901703E-05
       pseudo_TI48E:2.875203E-04
       pseudo_TI49E:2.110002E-05
       pseudo_TI50E:2.020302E-05
       pseudo_VE:2.748603E-05
       pseudo_ZR90E:7.896908E-06
       pseudo_ZR91E:1.722102E-06
       pseudo_ZR92E:2.632303E-06
       pseudo_ZR94E:2.667603E-06
       pseudo_ZR96E:4.297604E-07
       pseudo_W182E:2.018302E-06
       pseudo_W183E:1.089901E-06
       pseudo_W184E:2.342702E-06
       pseudo_W186E:2.165302E-06
       pseudo_CU63E:1.524101E-05
       pseudo_CU65E:6.793007E-06
       pseudo_CO59E:2.375902E-05
       pseudo_CA40E:3.386703E-05
       pseudo_CA42E:2.260402E-07
       pseudo_CA43E:4.716405E-08
       pseudo_CA44E:7.287707E-07
       pseudo_CA46E:1.397401E-09
       pseudo_CA48E:6.533006E-08
       pseudo_NB93E:7.535407E-06
       pseudo_N14_E:4.979705E-05
       pseudo_N15_E:1.839302E-07
       pseudo_AL27E:2.594703E-05
       pseudo_TA181E:3.869004E-06
       pseudo_B10E:5.155105E-06
       pseudo_B11E:2.075002E-05;

     G_YSZMIX ${mid_G_yszmix}
       pseudo_ZR90G:1.110556E-02
       pseudo_ZR91G:2.421721E-03
       pseudo_ZR92G:3.701685E-03
       pseudo_ZR94G:3.751388E-03
       pseudo_ZR96G:6.043603E-04
       pseudo_Y89G:3.753788E-03
       pseudo_O16G:4.880044E-02
       pseudo_HE4G:2.388520E-06;

     G_Clad ${mid_G_clad}
       pseudo_FE54G:3.185952E-03
       pseudo_FE56G:5.001168E-02
       pseudo_FE57G:1.154947E-03
       pseudo_FE58G:1.537129E-04
       pseudo_NI58G:8.373412E-03
       pseudo_NI60G:3.225451E-03
       pseudo_NI61G:1.402235E-04
       pseudo_NI62G:4.469793E-04
       pseudo_NI64G:1.138947E-04
       pseudo_CR50G:5.643439E-04
       pseudo_CR52G:1.088250E-02
       pseudo_CR53G:1.234043E-03
       pseudo_CR54G:3.071758E-04
       pseudo_MN55G:1.271641E-03
       pseudo_MO92G:1.080550E-04
       pseudo_MO94G:6.735188E-05
       pseudo_MO95G:1.159146E-04
       pseudo_MO96G:1.214544E-04
       pseudo_MO97G:6.953578E-05
       pseudo_MO98G:1.757019E-04
       pseudo_MO100G:7.011875E-05
       pseudo_SI28G:1.300140E-03
       pseudo_SI29G:6.601594E-05
       pseudo_SI30G:4.351798E-05
       pseudo_CG:3.489938E-04
       pseudo_P31G:6.766687E-05
       pseudo_S32G:2.068704E-05
       pseudo_S33G:1.656123E-07
       pseudo_S34G:9.348567E-07
       pseudo_S36G:4.358298E-09
       pseudo_TI46G:3.210951E-05
       pseudo_TI47G:2.895766E-05
       pseudo_TI48G:2.869267E-04
       pseudo_TI49G:2.105602E-05
       pseudo_TI50G:2.016107E-05
       pseudo_VG:2.742873E-05
       pseudo_ZR90G:7.880535E-06
       pseudo_ZR91G:1.718520E-06
       pseudo_ZR92G:2.626878E-06
       pseudo_ZR94G:2.662077E-06
       pseudo_ZR96G:4.288701E-07
       pseudo_W182G:2.014107E-06
       pseudo_W183G:1.087650E-06
       pseudo_W184G:2.337892E-06
       pseudo_W186G:2.160800E-06
       pseudo_CU63G:1.520930E-05
       pseudo_CU65G:6.778986E-06
       pseudo_CO59G:2.370990E-05
       pseudo_CA40G:3.379743E-05
       pseudo_CA42G:2.255696E-07
       pseudo_CA43G:4.706582E-08
       pseudo_CA44G:7.272563E-07
       pseudo_CA46G:1.394535E-09
       pseudo_CA48G:6.519498E-08
       pseudo_NB93G:7.519752E-06
       pseudo_N14G:4.969370E-05
       pseudo_N15G:1.835515E-07
       pseudo_AL27G:2.589280E-05
       pseudo_TA181G:3.861021E-06
       pseudo_B10G:5.144462E-06
       pseudo_B11G:2.070704E-05;

     G_Lead ${mid_G_lead}
       pseudo_PB204G:4.232323E-04
       pseudo_PB206G:7.285612E-03
       pseudo_PB207G:6.680995E-03
       pseudo_PB208G:1.584046E-02;

     G_Duct ${mid_G_duct}
       pseudo_FE54G:3.192503E-03
       pseudo_FE56G:5.011505E-02
       pseudo_FE57G:1.157401E-03
       pseudo_FE58G:1.540302E-04
       pseudo_NI58G:8.390808E-03
       pseudo_NI60G:3.232103E-03
       pseudo_NI61G:1.405101E-04
       pseudo_NI62G:4.479004E-04
       pseudo_NI64G:1.141301E-04
       pseudo_CR50G:5.655206E-04
       pseudo_CR52G:1.090501E-02
       pseudo_CR53G:1.236601E-03
       pseudo_CR54G:3.078103E-04
       pseudo_MN55G:1.274301E-03
       pseudo_MO92G:1.082801E-04
       pseudo_MO94G:6.749107E-05
       pseudo_MO95G:1.161601E-04
       pseudo_MO96G:1.217001E-04
       pseudo_MO97G:6.968007E-05
       pseudo_MO98G:1.760602E-04
       pseudo_MO100G:7.026407E-05
       pseudo_SI28G:1.302801E-03
       pseudo_SI29G:6.615206E-05
       pseudo_SI30G:4.360804E-05
       pseudo_CG:3.497203E-04
       pseudo_P31G:6.780707E-05
       pseudo_S32G:2.073002E-05
       pseudo_S33G:1.659602E-07
       pseudo_S34G:9.367909E-07
       pseudo_S36G:4.367304E-09
       pseudo_TI46G:3.217603E-05
       pseudo_TI47G:2.901703E-05
       pseudo_TI48G:2.875203E-04
       pseudo_TI49G:2.110002E-05
       pseudo_TI50G:2.020302E-05
       pseudo_VG:2.748603E-05
       pseudo_ZR90G:7.896908E-06
       pseudo_ZR91G:1.722102E-06
       pseudo_ZR92G:2.632303E-06
       pseudo_ZR94G:2.667603E-06
       pseudo_ZR96G:4.297604E-07
       pseudo_W182G:2.018302E-06
       pseudo_W183G:1.089901E-06
       pseudo_W184G:2.342702E-06
       pseudo_W186G:2.165302E-06
       pseudo_CU63G:1.524101E-05
       pseudo_CU65G:6.793007E-06
       pseudo_CO59G:2.375902E-05
       pseudo_CA40G:3.386703E-05
       pseudo_CA42G:2.260402E-07
       pseudo_CA43G:4.716405E-08
       pseudo_CA44G:7.287707E-07
       pseudo_CA46G:1.397401E-09
       pseudo_CA48G:6.533006E-08
       pseudo_NB93G:7.535407E-06
       pseudo_N14G:4.979705E-05
       pseudo_N15G:1.839302E-07
       pseudo_AL27G:2.594703E-05
       pseudo_TA181G:3.869004E-06
       pseudo_B10G:5.155105E-06
       pseudo_B11G:2.075002E-05;

     H_SPRINGMIX ${mid_H_springmix}
       pseudo_FE54H:3.504949E-04
       pseudo_FE56H:5.501991E-03
       pseudo_FE57H:1.270690E-04
       pseudo_FE58H:1.691020E-05
       pseudo_NI58H:9.211855E-04
       pseudo_NI60H:3.548352E-04
       pseudo_NI61H:1.542610E-05
       pseudo_NI62H:4.917349E-05
       pseudo_NI64H:1.252989E-05
       pseudo_CR50H:6.208541E-05
       pseudo_CR52H:1.197285E-03
       pseudo_CR53H:1.357596E-04
       pseudo_CR54H:3.379340E-05
       pseudo_MN55H:1.398999E-04
       pseudo_MO92H:1.188684E-05
       pseudo_MO94H:7.409526E-06
       pseudo_MO95H:1.275291E-05
       pseudo_MO96H:1.336095E-05
       pseudo_MO97H:7.649844E-06
       pseudo_MO98H:1.932937E-05
       pseudo_MO100H:7.713948E-06
       pseudo_SI28H:1.430302E-04
       pseudo_SI29H:7.262616E-06
       pseudo_SI30H:4.787540E-06
       pseudo_CH:3.839473E-05
       pseudo_P31H:7.444329E-06
       pseudo_S32H:2.275762E-06
       pseudo_S33H:1.822029E-08
       pseudo_S34H:1.028473E-07
       pseudo_S36H:4.794741E-10
       pseudo_TI46H:3.532451E-06
       pseudo_TI47H:3.185626E-06
       pseudo_TI48H:3.156524E-05
       pseudo_TI49H:2.316465E-06
       pseudo_TI50H:2.217958E-06
       pseudo_VH:3.017514E-06
       pseudo_ZR90H:8.669616E-07
       pseudo_ZR91H:1.890634E-07
       pseudo_ZR92H:2.889905E-07
       pseudo_ZR94H:2.928608E-07
       pseudo_ZR96H:4.718135E-08
       pseudo_W182H:2.215757E-07
       pseudo_W183H:1.196485E-07
       pseudo_W184H:2.571983E-07
       pseudo_W186H:2.377169E-07
       pseudo_CU63H:1.673219E-06
       pseudo_CU65H:7.457830E-07
       pseudo_CO59H:2.608385E-06
       pseudo_CA40H:3.718164E-06
       pseudo_CA42H:2.481576E-08
       pseudo_CA43H:5.177868E-09
       pseudo_CA44H:8.000768E-08
       pseudo_CA46H:1.534209E-10
       pseudo_CA48H:7.172310E-09
       pseudo_NB93H:8.272788E-07
       pseudo_N14H:5.466988E-06
       pseudo_N15H:2.019243E-08
       pseudo_AL27H:2.848602E-06
       pseudo_TA181H:4.247602E-07
       pseudo_B10H:5.659602E-07
       pseudo_B11H:2.278062E-06
       pseudo_HE4H:2.228358E-05;

     H_Clad ${mid_H_clad}
       pseudo_FE54H:3.185952E-03
       pseudo_FE56H:5.001168E-02
       pseudo_FE57H:1.154947E-03
       pseudo_FE58H:1.537129E-04
       pseudo_NI58H:8.373412E-03
       pseudo_NI60H:3.225451E-03
       pseudo_NI61H:1.402235E-04
       pseudo_NI62H:4.469793E-04
       pseudo_NI64H:1.138947E-04
       pseudo_CR50H:5.643439E-04
       pseudo_CR52H:1.088250E-02
       pseudo_CR53H:1.234043E-03
       pseudo_CR54H:3.071758E-04
       pseudo_MN55H:1.271641E-03
       pseudo_MO92H:1.080550E-04
       pseudo_MO94H:6.735188E-05
       pseudo_MO95H:1.159146E-04
       pseudo_MO96H:1.214544E-04
       pseudo_MO97H:6.953578E-05
       pseudo_MO98H:1.757019E-04
       pseudo_MO100H:7.011875E-05
       pseudo_SI28H:1.300140E-03
       pseudo_SI29H:6.601594E-05
       pseudo_SI30H:4.351798E-05
       pseudo_CH:3.489938E-04
       pseudo_P31H:6.766687E-05
       pseudo_S32H:2.068704E-05
       pseudo_S33H:1.656123E-07
       pseudo_S34H:9.348567E-07
       pseudo_S36H:4.358298E-09
       pseudo_TI46H:3.210951E-05
       pseudo_TI47H:2.895766E-05
       pseudo_TI48H:2.869267E-04
       pseudo_TI49H:2.105602E-05
       pseudo_TI50H:2.016107E-05
       pseudo_VH:2.742873E-05
       pseudo_ZR90H:7.880535E-06
       pseudo_ZR91H:1.718520E-06
       pseudo_ZR92H:2.626878E-06
       pseudo_ZR94H:2.662077E-06
       pseudo_ZR96H:4.288701E-07
       pseudo_W182H:2.014107E-06
       pseudo_W183H:1.087650E-06
       pseudo_W184H:2.337892E-06
       pseudo_W186H:2.160800E-06
       pseudo_CU63H:1.520930E-05
       pseudo_CU65H:6.778986E-06
       pseudo_CO59H:2.370990E-05
       pseudo_CA40H:3.379743E-05
       pseudo_CA42H:2.255696E-07
       pseudo_CA43H:4.706582E-08
       pseudo_CA44H:7.272563E-07
       pseudo_CA46H:1.394535E-09
       pseudo_CA48H:6.519498E-08
       pseudo_NB93H:7.519752E-06
       pseudo_N14H:4.969370E-05
       pseudo_N15H:1.835515E-07
       pseudo_AL27H:2.589280E-05
       pseudo_TA181H:3.861021E-06
       pseudo_B10H:5.144462E-06
       pseudo_B11H:2.070704E-05;

     H_Lead ${mid_H_lead}
       pseudo_PB204H:4.232323E-04
       pseudo_PB206H:7.285612E-03
       pseudo_PB207H:6.680995E-03
       pseudo_PB208H:1.584046E-02;

     H_Duct ${mid_H_duct}
       pseudo_FE54H:3.192503E-03
       pseudo_FE56H:5.011505E-02
       pseudo_FE57H:1.157401E-03
       pseudo_FE58H:1.540302E-04
       pseudo_NI58H:8.390808E-03
       pseudo_NI60H:3.232103E-03
       pseudo_NI61H:1.405101E-04
       pseudo_NI62H:4.479004E-04
       pseudo_NI64H:1.141301E-04
       pseudo_CR50H:5.655206E-04
       pseudo_CR52H:1.090501E-02
       pseudo_CR53H:1.236601E-03
       pseudo_CR54H:3.078103E-04
       pseudo_MN55H:1.274301E-03
       pseudo_MO92H:1.082801E-04
       pseudo_MO94H:6.749107E-05
       pseudo_MO95H:1.161601E-04
       pseudo_MO96H:1.217001E-04
       pseudo_MO97H:6.968007E-05
       pseudo_MO98H:1.760602E-04
       pseudo_MO100H:7.026407E-05
       pseudo_SI28H:1.302801E-03
       pseudo_SI29H:6.615206E-05
       pseudo_SI30H:4.360804E-05
       pseudo_CH:3.497203E-04
       pseudo_P31H:6.780707E-05
       pseudo_S32H:2.073002E-05
       pseudo_S33H:1.659602E-07
       pseudo_S34H:9.367909E-07
       pseudo_S36H:4.367304E-09
       pseudo_TI46H:3.217603E-05
       pseudo_TI47H:2.901703E-05
       pseudo_TI48H:2.875203E-04
       pseudo_TI49H:2.110002E-05
       pseudo_TI50H:2.020302E-05
       pseudo_VH:2.748603E-05
       pseudo_ZR90H:7.896908E-06
       pseudo_ZR91H:1.722102E-06
       pseudo_ZR92H:2.632303E-06
       pseudo_ZR94H:2.667603E-06
       pseudo_ZR96H:4.297604E-07
       pseudo_W182H:2.018302E-06
       pseudo_W183H:1.089901E-06
       pseudo_W184H:2.342702E-06
       pseudo_W186H:2.165302E-06
       pseudo_CU63H:1.524101E-05
       pseudo_CU65H:6.793007E-06
       pseudo_CO59H:2.375902E-05
       pseudo_CA40H:3.386703E-05
       pseudo_CA42H:2.260402E-07
       pseudo_CA43H:4.716405E-08
       pseudo_CA44H:7.287707E-07
       pseudo_CA46H:1.397401E-09
       pseudo_CA48H:6.533006E-08
       pseudo_NB93H:7.535407E-06
       pseudo_N14H:4.979705E-05
       pseudo_N15H:1.839302E-07
       pseudo_AL27H:2.594703E-05
       pseudo_TA181H:3.869004E-06
       pseudo_B10H:5.155105E-06
       pseudo_B11H:2.075002E-05;

     UpperBundle ${mid_I}
       pseudo_FE54I:1.251752E-03
       pseudo_FE56I:1.964981E-02
       pseudo_FE57I:4.537988E-04
       pseudo_FE58I:6.039250E-05
       pseudo_NI58I:3.289936E-03
       pseudo_NI60I:1.267252E-03
       pseudo_NI61I:5.509228E-05
       pseudo_NI62I:1.756173E-04
       pseudo_NI64I:4.474985E-05
       pseudo_CR50I:2.217292E-04
       pseudo_CR52I:4.275877E-03
       pseudo_CR53I:4.848501E-04
       pseudo_CR54I:1.206850E-04
       pseudo_MN55I:4.996407E-04
       pseudo_MO92I:4.245476E-05
       pseudo_MO94I:2.646209E-05
       pseudo_MO95I:4.554388E-05
       pseudo_MO96I:4.771797E-05
       pseudo_MO97I:2.732113E-05
       pseudo_MO98I:6.903086E-05
       pseudo_MO100I:2.754914E-05
       pseudo_SI28I:5.108111E-04
       pseudo_SI29I:2.593807E-05
       pseudo_SI30I:1.709871E-05
       pseudo_CI:1.371257E-04
       pseudo_P31I:2.658610E-05
       pseudo_S32I:8.127836E-06
       pseudo_S33I:6.507069E-08
       pseudo_S34I:3.673052E-07
       pseudo_S36I:1.712371E-09
       pseudo_TI46I:1.261552E-05
       pseudo_TI47I:1.137747E-05
       pseudo_TI48I:1.127347E-04
       pseudo_TI49I:8.273042E-06
       pseudo_TI50I:7.921328E-06
       pseudo_VI:1.077645E-05
       pseudo_ZR90I:3.096328E-06
       pseudo_ZR91I:6.752279E-07
       pseudo_ZR92I:1.032143E-06
       pseudo_ZR94I:1.045943E-06
       pseudo_ZR96I:1.685070E-07
       pseudo_W182I:7.913527E-07
       pseudo_W183I:4.273277E-07
       pseudo_W184I:9.185680E-07
       pseudo_W186I:8.489851E-07
       pseudo_CU63I:5.975747E-06
       pseudo_CU65I:2.663510E-06
       pseudo_CO59I:9.315485E-06
       pseudo_CA40I:1.327855E-05
       pseudo_CA42I:8.862667E-08
       pseudo_CA43I:1.849277E-08
       pseudo_CA44I:2.857418E-07
       pseudo_CA46I:5.479227E-10
       pseudo_CA48I:2.561506E-08
       pseudo_NB93I:2.954522E-06
       pseudo_N14I:1.952481E-05
       pseudo_N15I:7.211698E-08
       pseudo_AL27I:1.017342E-05
       pseudo_TA181I:1.516963E-06
       pseudo_B10I:2.021284E-06
       pseudo_B11I:8.135837E-06
       pseudo_PB204I:2.570306E-04
       pseudo_PB206I:4.424583E-03
       pseudo_PB207I:4.057368E-03
       pseudo_PB208I:9.620298E-03;

     OutletWrapper ${mid_J}
       pseudo_FE54J:7.604462E-04
       pseudo_FE56J:1.193694E-02
       pseudo_FE57J:2.756886E-04
       pseudo_FE58J:3.668882E-05
       pseudo_NI58J:1.998690E-03
       pseudo_NI60J:7.698761E-04
       pseudo_NI61J:3.346883E-05
       pseudo_NI62J:1.066895E-04
       pseudo_NI64J:2.718586E-05
       pseudo_CR50J:1.347093E-04
       pseudo_CR52J:2.597687E-03
       pseudo_CR53J:2.945585E-04
       pseudo_CR54J:7.332063E-05
       pseudo_MN55J:3.035385E-04
       pseudo_MO92J:2.579187E-05
       pseudo_MO94J:1.607592E-05
       pseudo_MO95J:2.766886E-05
       pseudo_MO96J:2.898985E-05
       pseudo_MO97J:1.659792E-05
       pseudo_MO98J:4.193779E-05
       pseudo_MO100J:1.673692E-05
       pseudo_SI28J:3.103184E-04
       pseudo_SI29J:1.575692E-05
       pseudo_SI30J:1.038695E-05
       pseudo_CJ:8.330258E-05
       pseudo_P31J:1.615192E-05
       pseudo_S32J:4.937775E-06
       pseudo_S33J:3.953080E-08
       pseudo_S34J:2.231389E-07
       pseudo_S36J:1.040295E-09
       pseudo_TI46J:7.664362E-06
       pseudo_TI47J:6.911865E-06
       pseudo_TI48J:6.848666E-05
       pseudo_TI49J:5.025975E-06
       pseudo_TI50J:4.812276E-06
       pseudo_VJ:6.547067E-06
       pseudo_ZR90J:1.880991E-06
       pseudo_ZR91J:4.102079E-07
       pseudo_ZR92J:6.270069E-07
       pseudo_ZR94J:6.354168E-07
       pseudo_ZR96J:1.023695E-07
       pseudo_W182J:4.807576E-07
       pseudo_W183J:2.596087E-07
       pseudo_W184J:5.580372E-07
       pseudo_W186J:5.157674E-07
       pseudo_CU63J:3.630382E-06
       pseudo_CU65J:1.618092E-06
       pseudo_CO59J:5.659272E-06
       pseudo_CA40J:8.067160E-06
       pseudo_CA42J:5.384173E-08
       pseudo_CA43J:1.123394E-08
       pseudo_CA44J:1.735891E-07
       pseudo_CA46J:3.328683E-10
       pseudo_CA48J:1.556192E-08
       pseudo_NB93J:1.794891E-06
       pseudo_N14J:1.186194E-05
       pseudo_N15J:4.381178E-08
       pseudo_AL27J:6.180469E-06
       pseudo_TA181J:9.215854E-07
       pseudo_B10J:1.227894E-06
       pseudo_B11J:4.942575E-06
       pseudo_PB204J:3.224084E-04
       pseudo_PB206J:5.549972E-03
       pseudo_PB207J:5.089375E-03
       pseudo_PB208J:1.206694E-02'
  []
[]
