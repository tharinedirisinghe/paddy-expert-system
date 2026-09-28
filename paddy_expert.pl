% Paddy Pest & Disease Diagnosis Expert System
% Run: swipl paddy_expert.pl
% Knowledge source: Rice Research and Development Institute (RRDI),
% Department of Agriculture, Sri Lanka

:- dynamic fact/2.

% ---------------- KNOWLEDGE BASE ----------------

source(s1,  'RRDI - Diagnosis of rice diseases', 'https://doa.gov.lk/rrdi_ricediseases_diagnose/').
source(s2,  'RRDI - Rice blast',                 'https://doa.gov.lk/rrdi_ricediseases_riceblast/').
source(s3,  'RRDI - Sheath blight',              'https://doa.gov.lk/rrdi_ricediseases_sheathblight/').
source(s4,  'RRDI - Brown spot',                 'https://doa.gov.lk/rrdi_ricediseases_brownspot/').
source(s5,  'RRDI - Bacterial leaf blight',      'https://doa.gov.lk/rrdi_ricediseases_bacterialleafblight').
source(s6,  'RRDI - Leaf scald',                 'https://doa.gov.lk/rrdi_ricediseases_leafscald/').
source(s7,  'RRDI - False smut',                 'https://doa.gov.lk/rrdi_ricediseases_flashsmut/').
source(s8,  'RRDI - Sheath rot',                 'https://doa.gov.lk/rrdi_ricediseases_sheathrot/').
source(s9,  'RRDI - Narrow brown leaf spot',     'https://doa.gov.lk/rrdi_ricediseases_narrowbrownleafspot/').
source(s10, 'RRDI - Brown plant hopper',         'https://doa.gov.lk/rrdi_pests_brownplanthopper/').
source(s11, 'RRDI - Yellow stem borer',          'https://doa.gov.lk/rrdi_pests_yellowstemborer/').
source(s12, 'RRDI - Thrips',                     'https://doa.gov.lk/rrdi_pests_thrips/').
source(s13, 'RRDI - Rice leaf-folders',          'https://doa.gov.lk/rrdi_pests_riceleaffolders/').
source(s14, 'RRDI - Rice gall midge',            'https://doa.gov.lk/rrdi_pests_ricegallmidge/').
source(s15, 'RRDI - Paddy bug',                  'https://doa.gov.lk/rrdi_pests_paddybug/').
source(s16, 'RRDI - Rice sheath mite',           'https://doa.gov.lk/rrdi_pests_ricesheathmite/').

problem(rice_blast,             'Rice blast',             disease).
problem(brown_spot,             'Brown spot',             disease).
problem(narrow_brown_leaf_spot, 'Narrow brown leaf spot', disease).
problem(leaf_scald,             'Leaf scald',             disease).
problem(bacterial_leaf_blight,  'Bacterial leaf blight',  disease).
problem(sheath_blight,          'Sheath blight',          disease).
problem(sheath_rot,             'Sheath rot',             disease).
problem(false_smut,             'False smut',             disease).
problem(brown_plant_hopper,     'Brown plant hopper',     pest).
problem(yellow_stem_borer,      'Yellow stem borer',      pest).
problem(rice_leaffolder,        'Rice leaf-folder',       pest).
problem(thrips,                 'Thrips',                 pest).
problem(rice_gall_midge,        'Rice gall midge',        pest).
problem(paddy_bug,              'Paddy bug',              pest).
problem(rice_sheath_mite,       'Rice sheath mite',       pest).

stage_name(seedling,  'Seedling').
stage_name(tillering, 'Tillering').
stage_name(booting,   'Booting').
stage_name(flowering, 'Heading / flowering').
stage_name(ripening,  'Grain filling / ripening').

part_name(leaf,    'Leaf blades').
part_name(sheath,  'Leaf sheath / stem').
part_name(panicle, 'Panicle / grains').
part_name(plant,   'Whole plants / tillers').

symptom(leaf,    blast_spots,        'spindle-shaped spots with grey centre, brown margin, pointed ends').
symptom(leaf,    brown_spots,        'circular or oval brown spots with a dark brown margin').
symptom(leaf,    linear_lesions,     'short narrow brown streaks parallel to the veins').
symptom(leaf,    chevron_lesions,    'lesions from the leaf tip with a zig-zag banded pattern').
symptom(leaf,    orange_stripes,     'water-soaked yellow-orange stripes with wavy margins').
symptom(leaf,    folded_leaves,      'leaf edges fastened together with a caterpillar inside').
symptom(leaf,    leaves_roll_inward, 'young leaves roll inwards along the margins and dry').
symptom(sheath,  banded_lesions,     'lesions near the water level, white centre with brown bands').
symptom(sheath,  red_flag_sheath,    'reddish-brown discolouration of the top (flag leaf) sheath').
symptom(sheath,  chocolate_lesions,  'chocolate-brown lesions on the leaf sheaths').
symptom(panicle, orange_balls,       'grains replaced by orange balls with greenish-black spores').
symptom(panicle, empty_grains,       'empty or partly filled grains with bugs on the panicles').
symptom(plant,   kresek,             'seedlings wilting and turning yellow (kresek)').
symptom(plant,   hopper_burn,        'patches of plants dried and turned brown (hopper burn)').
symptom(plant,   dead_heart,         'central shoot of young tillers dead and dry (dead heart)').
symptom(plant,   onion_shoots,       'pale tubular silver shoots / onion shoots').

question(bacterial_ooze, 'Squeeze a cut leaf. Does yellowish bacterial ooze come out?').
question(spreading_fast, 'Is the disease spreading rapidly in the field?').
question(hoppers_per_hill, 'Average number of plant hoppers per hill?').
question(damaged_leaves, 'Percentage of leaves that are more than half damaged (0-100)?').

