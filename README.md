# Paddy Pest & Disease Diagnosis Expert System

A rule-based expert system written in SWI-Prolog. It identifies common **pests and diseases of paddy
(rice)** from the symptoms seen in the field, and gives recommendations for managing them.

- **One file:** `paddy_expert.pl`
- **15 problems:** 8 diseases and 7 pests
- **27 rules** (r01-r27), each linked to its source
- Explains every result: it shows the rules used, their sources and the conditions that were true

## Knowledge source

All symptoms, thresholds and recommendations come from the **Rice Research and Development Institute
(RRDI), Department of Agriculture, Sri Lanka**: <https://doa.gov.lk/rrdi_homepage/>.
Each rule is linked to the RRDI page it was taken from (`rule_source/2` and `source/3` in the code).

| Diseases | Pests |
|----------|-------|
| Rice blast, Brown spot, Narrow brown leaf spot, Leaf scald, Bacterial leaf blight, Sheath blight, Sheath rot, False smut | Brown plant hopper, Yellow stem borer, Rice leaf-folder, Thrips, Rice gall midge, Paddy bug, Rice sheath mite |

> This system is for learning purposes. For real crop problems, contact your local agricultural officer.

---

## 1. Requirements

**SWI-Prolog** (tested with version 10.0.2), free from <https://www.swi-prolog.org/download/stable>.

## 2. How to run

**Option 1 - SWI-Prolog window**

1. Open SWI-Prolog.
2. Choose **File > Consult...** and select `paddy_expert.pl`.
3. At the `?-` prompt, type the following (with the full stop) and press Enter:
   ```prolog
   ?- main.
   ```

**Option 2 - command in the SWI-Prolog window**

```prolog
?- consult('C:/path/to/paddy_expert.pl').
?- main.
```

Use forward slashes `/` in the path.

**Option 3 - terminal**

Open a terminal in the project folder and type the following. The system starts immediately.

```
swipl paddy_expert.pl
```

## 3. How to use

The system asks three questions. Answer by typing the number(s) and pressing Enter.

| Question | What to type |
|----------|--------------|
| 1. What is the growth stage of the crop? | one number, 1-5 |
| 2. Where do you see the symptoms? | one or more numbers separated by spaces, e.g. `1 3` |
| 3. Which of these do you see? | one or more numbers, or `0` if none match |

For some problems one extra question is asked, only when a rule needs it:

- a **yes/no** question (type `y` or `n`), e.g. "Does yellowish bacterial ooze come out?"
- a **number**, e.g. "Average number of plant hoppers per hill?"

The result shows each pest or disease found, the rules that proved it, and what to do. At the end,
type `y` to diagnose another field or `n` to finish.

Invalid input is ignored and the question is asked again.

### Example session

```
1. What is the growth stage of the crop?
  1. Seedling
  2. Tillering
  3. Booting
  4. Heading / flowering
  5. Grain filling / ripening
Enter a number > 3

2. Where do you see the symptoms?
  ...
  4. Whole plants / tillers
Enter one or more numbers (e.g. 1 3) > 4

3. Which of these do you see?
  1. seedlings wilting and turning yellow (kresek)
  2. patches of plants dried and turned brown (hopper burn)
  ...
Enter one or more numbers (e.g. 1 3) > 2

Average number of plant hoppers per hill? > 3

------------------------- RESULT -------------------------

>> Brown plant hopper (pest)
   Rule r10 (RRDI - Brown plant hopper):
     patches of plants dried and turned brown (hopper burn)
   Rule r17 (RRDI - Brown plant hopper):
     stage is booting AND hoppers_per_hill >= 2
   What to do:
   - Threshold reached: drain the field and apply a safer recommended insecticide. [r23]

Diagnose another field? (y/n) > n
```

## 4. How it works

The knowledge base is written as Prolog facts and rules. Each rule `Head :- Conditions.` means
**IF** conditions **THEN** head, and has an id (r01-r27).

| Rules | Predicate | Purpose |
|-------|-----------|---------|
| r01-r16 | `diagnose/2` | symptoms (and growth stage) -> pest or disease |
| r17-r19 | `threshold_reached/2` | economic threshold level for pests |
| r20-r26 | `advice/3` | recommendations that depend on a condition |
| r27 | `refer_to_expert/1` | nothing found -> refer the case to an expert |

- **Inference:** Prolog's built-in backward chaining. The system asks Prolog to prove `diagnose(D, R)`,
  and Prolog tries each rule in turn, backtracking when a condition fails.
- **Working memory:** answers are stored with `assertz` as `fact/2`.
- **Questions only when needed:** yes/no and number questions are asked only when a rule reaches them,
  and are never asked twice.
- **Explanation:** the system reads each rule's conditions with `clause/2` and prints them in plain English.

## 5. Test cases

Start the system and type the values in the **Inputs** column, one per line, pressing Enter after each.
Values are separated by `;` in the table. An input such as `1 2` is typed on one line, with a space.

| ID | Test | Inputs | Expected result |
|----|------|--------|-----------------|
| TC01 | Rice blast, disease spreading | 2; 1; 1; y | Rice blast (r01); advice r20, r21, r22 |
| TC02 | Brown spot | 2; 1; 2 | Brown spot (r02); advice r20, r21 + hot-water seed treatment |
| TC03 | Bacterial leaf blight (stripes) | 2; 1; 5 | Bacterial leaf blight (r05); r20 only (no seed advice); drain field |
| TC04 | Kresek with bacterial ooze | 1; 4; 1; y | Bacterial leaf blight (r06) |
| TC05 | Kresek without ooze | 1; 4; 1; n | No diagnosis; refer to expert (r27) |
| TC06 | Dead heart at tillering | 2; 4; 3 | Yellow stem borer (r11) |
| TC07 | Dead heart at booting | 3; 4; 3 | No diagnosis (wrong stage); r27 |
| TC08 | Leaf rolling at seedling | 1; 1; 7 | Thrips (r13) |
| TC09 | Hoppers at booting, 3 per hill | 3; 4; 2; 3 | Brown plant hopper (r10); threshold (r17); control (r23) |
| TC10 | Hoppers at booting, 1 per hill | 3; 4; 2; 1 | Brown plant hopper (r10); monitor (r24) |
| TC11 | Hoppers at heading, 3 per hill | 4; 4; 2; 3 | Brown plant hopper (r10); below 5, monitor (r24) |
| TC12 | Leaf-folder, 30% leaves damaged | 2; 1; 6; 30 | Rice leaf-folder (r12); threshold (r19); IGR (r25) |
| TC13 | Two problems at once | 2; 1 2; 1 8; n | Rice blast (r01) and Sheath blight (r07) |
| TC14 | No matching symptom | 2; 1; 0 | No diagnosis; refer to expert (r27) |
| TC15 | Sheath mite at booting | 3; 2; 3 | Rice sheath mite (r16) |
| TC16 | Paddy bug at heading | 4; 3; 2 | Paddy bug (r15) |

## 6. Troubleshooting

| Problem | Solution |
|---------|----------|
| `swipl` is not recognized in the terminal | Use Option 1 or 2, or add SWI-Prolog's `bin` folder to the PATH |
| Nothing happens after File > Consult | The file is loaded but not started yet. Type `main.` and press Enter |
| The same question appears again | The answer was not valid. Type numbers from the list, or `y` / `n` |

## References

- RRDI, Department of Agriculture, Sri Lanka - Rice diseases: <https://doa.gov.lk/rrdi_commonricediseases/>
- RRDI, Department of Agriculture, Sri Lanka - Rice pests: <https://doa.gov.lk/rrdi_pests/>
- The page used for each rule is listed in `source/3` in `paddy_expert.pl`.
