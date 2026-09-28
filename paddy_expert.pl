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

% ---------------- RULES ----------------

diagnose(rice_blast, r01)             :- seen(blast_spots).
diagnose(brown_spot, r02)             :- seen(brown_spots).
diagnose(narrow_brown_leaf_spot, r03) :- seen(linear_lesions).
diagnose(leaf_scald, r04)             :- seen(chevron_lesions).
diagnose(bacterial_leaf_blight, r05)  :- seen(orange_stripes).
diagnose(bacterial_leaf_blight, r06)  :- seen(kresek), stage(seedling), yes(bacterial_ooze).
diagnose(sheath_blight, r07)          :- seen(banded_lesions).
diagnose(sheath_rot, r08)             :- seen(red_flag_sheath).
diagnose(false_smut, r09)             :- seen(orange_balls).
diagnose(brown_plant_hopper, r10)     :- seen(hopper_burn).
diagnose(yellow_stem_borer, r11)      :- seen(dead_heart), stage_in([seedling, tillering]).
diagnose(rice_leaffolder, r12)        :- seen(folded_leaves).
diagnose(thrips, r13)                 :- seen(leaves_roll_inward), stage(seedling).
diagnose(rice_gall_midge, r14)        :- seen(onion_shoots).
diagnose(paddy_bug, r15)              :- seen(empty_grains), stage_in([flowering, ripening]).
diagnose(rice_sheath_mite, r16)       :- seen(chocolate_lesions), stage(booting).

threshold_reached(brown_plant_hopper, r17) :- stage(booting), at_least(hoppers_per_hill, 2).
threshold_reached(brown_plant_hopper, r18) :- stage(flowering), at_least(hoppers_per_hill, 5).
threshold_reached(rice_leaffolder, r19)    :- at_least(damaged_leaves, 25).

advice(D, r20, 'Apply urea only at the recommended dose, or according to the leaf colour chart.') :-
    problem(D, _, disease).
advice(D, r21, 'Next season use certified seed paddy, add burnt paddy husk (250 kg/acre) and do not plough in infected straw.') :-
    problem(D, _, disease), D \== bacterial_leaf_blight.
advice(rice_blast, r22, 'Spray Tebuconazole, Isoprothiolane, Carbendazim or Tricyclazole (8-10 tanks per acre).') :-
    yes(spreading_fast).
advice(brown_plant_hopper, r23, 'Threshold reached: drain the field and apply a safer recommended insecticide.') :-
    threshold_reached(brown_plant_hopper, _).
advice(brown_plant_hopper, r24, 'Below threshold: do not spray; drain the field and keep monitoring.') :-
    \+ threshold_reached(brown_plant_hopper, _).
advice(rice_leaffolder, r25, 'Threshold reached: use a safer insect growth regulator (IGR).') :-
    threshold_reached(rice_leaffolder, _).
advice(rice_leaffolder, r26, 'Below threshold: keep proper spacing, use nitrogen at the recommended rate and monitor.') :-
    \+ threshold_reached(rice_leaffolder, _).

refer_to_expert(r27) :- \+ diagnose(_, _).

rule_source(r01, s2).  rule_source(r02, s4).  rule_source(r03, s9).  rule_source(r04, s6).
rule_source(r05, s5).  rule_source(r06, s5).  rule_source(r07, s3).  rule_source(r08, s8).
rule_source(r09, s7).  rule_source(r10, s10). rule_source(r11, s11). rule_source(r12, s13).
rule_source(r13, s12). rule_source(r14, s14). rule_source(r15, s15). rule_source(r16, s16).
rule_source(r17, s10). rule_source(r18, s10). rule_source(r19, s13). rule_source(r20, s2).
rule_source(r21, s2).  rule_source(r22, s2).  rule_source(r23, s10). rule_source(r24, s10).
rule_source(r25, s13). rule_source(r26, s13). rule_source(r27, s1).

treatment(sheath_blight, 'Spray Hexaconazole or Propiconazole (8-10 tanks per acre).').
treatment(brown_spot, 'Next season treat seed with hot water (53-54 C for 10-12 minutes).').
treatment(bacterial_leaf_blight, 'Stop irrigation and let the field dry; apply potassium fertilizer.').
treatment(sheath_rot, 'Control insect vectors, especially the rice sheath mite.').
treatment(yellow_stem_borer, 'Prepare land properly to destroy plant debris and manage weeds.').
treatment(thrips, 'Submerge the crop for 1-2 days, or drag a wet cloth over the seedlings.').
treatment(rice_gall_midge, 'Grow resistant varieties (e.g. Bg 304, Bg 305, Bg 357, Bg 359, Bg 360).').
treatment(paddy_bug, 'Protect natural enemies such as the egg parasitoid Gryon nixoni.').
treatment(rice_sheath_mite, 'Apply an approved insecticide; after harvest plough in or burn crop residue.').

% ---------------- INFERENCE ENGINE ----------------

seen(S)        :- fact(seen, S).
stage(S)       :- fact(stage, S).
stage_in(List) :- fact(stage, S), member(S, List).

yes(Q) :- fact(Q, Answer), !, Answer == yes.
yes(Q) :- question(Q, Text), ask_yes_no(Text, Answer), assertz(fact(Q, Answer)), Answer == yes.

at_least(Q, Min) :- fact(Q, N), !, N >= Min.
at_least(Q, Min) :- question(Q, Text), ask_number(Text, N), assertz(fact(Q, N)), N >= Min.

because(Head, Text) :-
    clause(Head, Body),
    conditions(Body, List),
    maplist(describe, List, Texts),
    atomic_list_concat(Texts, ' AND ', Text).

conditions((A, B), [A|Rest]) :- !, conditions(B, Rest).
conditions(A, [A]).

describe(seen(S), T)        :- symptom(_, S, T).
describe(stage(S), T)       :- format(atom(T), 'stage is ~w', [S]).
describe(stage_in(L), T)    :- atomic_list_concat(L, ' or ', A), format(atom(T), 'stage is ~w', [A]).
describe(yes(Q), T)         :- format(atom(T), '~w = yes', [Q]).
describe(at_least(Q, N), T) :- format(atom(T), '~w >= ~w', [Q, N]).

