# Route contracts and postconditions

Use this reference for every Logic Pro request. A card may have a useful portable lane while its Logic-native lane remains blocked.

## LP1 - Standalone music versus editable production

- Trigger: create original music, a cue, underscore, demo, or editable Logic production.
- Retained state: portable WAV/MP3 for P1; tracks, regions, MIDI, routing, plug-ins, automation, and project relationships for L1.
- Primary route: use a Manus-native music capability only when it is exposed in the active session and P1 is sufficient.
- Escalation: any request for separately editable musical parts or Logic project state becomes L1.
- Hybrid handoff: a generated or user-supplied portable audio seed may enter a future Logic session after O1.
- Fallback: produce a structured creative brief and source manifest when native generation is absent; do not manufacture project state.
- Objective postcondition: the portable file opens, has the declared format and duration, and passes listening against the brief. The L1 branch additionally requires saved and reopened native state; it is currently blocked.

## LP2 - Arrange supplied audio and MIDI

- Trigger: organize supplied stems, loops, recordings, or MIDI into a timed editable arrangement.
- Retained state: validated source files and arrangement manifest for P1; Logic tracks, regions, timing, instruments, markers, and asset relationships for L1.
- Primary route: use Sandbox file inspection for source inventory and preparation.
- Escalation: creating the editable arrangement is L1 and requires current-build O1.
- Hybrid handoff: deliver hashes, audio/MIDI metadata, naming, tempo/meter assumptions, and an arrangement manifest to the live Logic lane.
- Fallback: stop at the validated source pack and manifest when Logic is unavailable.
- Objective postcondition: every supplied file appears once in the inventory with parse status and declared role. Native completion additionally requires one-to-one project objects, resolved media, audition, and save/reopen proof; it is currently blocked.

## LP3 - Comp and tune vocals

- Trigger: choose takes, preserve alternatives, or apply editable timing and pitch correction.
- Retained state: decision map for D1; take folders, alternatives, comp map, and Flex or pitch state for L1.
- Primary route: prepare a phrase-level decision rubric and source-protection plan.
- Escalation: any actual comping, tuning, flattening, or app-native state change is L1.
- Hybrid handoff: provide take identifiers, approved selection criteria, correction tolerance, and listening checkpoints to a future O1 run.
- Fallback: return the decision map without claiming edited audio or native state.
- Objective postcondition: the plan identifies every source alternative and each approval point. Native completion additionally requires alternatives and correction state to survive reopen plus an artifact-focused listening review; it is currently blocked.

## LP4 - Mix, automate, and export

- Trigger: retain a Logic mix while delivering a master, individual tracks, or grouped stems.
- Retained state: export specification and portable audio for P1/D1; mixer graph, routing, plug-ins, buses, sends, and automation for L1.
- Primary route: prepare an explicit export specification and inspect already exported files in the Sandbox.
- Escalation: editing mix state or initiating Logic exports is L1.
- Hybrid handoff: define range, master versus tracks versus grouped stems, wet/dry policy, tails, format, naming, and destination before a future live run; verify outputs afterward outside Logic.
- Fallback: return the export specification and QA gaps rather than guessing app state.
- Objective postcondition: existing output files match the declared count, names, formats, channels, duration expectations, and listening checklist. Native completion additionally requires mixer and automation save/reopen proof; it is currently blocked.

## LP5 - Spoken-audio cleanup and assembly

- Trigger: remove approved sections, assemble dialogue, normalize portable format, or produce an edit manifest.
- Retained state: cleaned portable audio and change manifest for P1; Logic regions, processing, routing, or automation only when explicitly requested as L1.
- Primary route: use available Sandbox audio tools after confirming privacy, content cuts, rights, and delivery target.
- Escalation: an editable Logic dialogue project or Logic-specific processing state becomes L1.
- Hybrid handoff: portable sources and an edit decision list can seed a future native project.
- Fallback: provide a timestamped edit and processing specification if the required audio tool is unavailable.
- Objective postcondition: a new output file opens, preserves the approved content order, matches declared metadata, and passes complete listening for continuity, word loss, and intelligibility. If no transform ran, only the specification is claimed.

## LP6 - Project archive and collaborator handoff

- Trigger: move, archive, back up, or hand a Logic project to another environment.
- Retained state: dependency inventory, hashes, portable companions, and loss report for D1; authoritative Logic copy with intended assets for L1.
- Primary route: inspect supplied files read-only and prepare a dependency, destination, and interchange-loss manifest.
- Escalation: authoring a copy, changing asset policy, or proving a project reopens is L1.
- Hybrid handoff: Logic creates and reopens the authoritative copy after O1; the Sandbox inventories, hashes, and checks the staged file set.
- Fallback: deliver portable stems or interchange recommendations only when already supplied or separately created, and state every known loss.
- Objective postcondition: the manifest names source, destination, recipient constraints, dependencies, portable companions, hashes, and unsupported state. A full project handoff additionally requires unchanged source and staged reopen proof; it is currently blocked.

## LP7 - Deterministic Scripter MIDI effect

- Trigger: prepare bounded MIDI transformation logic for Logic Scripter.
- Retained state: reviewed JavaScript plus input/output MIDI vectors for S1; Scripter setting, patch, or project persistence for L1.
- Primary route: generate or review source and oracle files in the Sandbox.
- Escalation: inserting, executing, auditioning, or persisting Scripter state is L1.
- Hybrid handoff: use `scripts/prepare_scripter_transpose.py` for the supported transpose template, then reserve the source and vectors for a future live test.
- Fallback: provide pseudocode and an event oracle when the requested behavior exceeds the evidenced template; do not emit unsupported Logic API calls as fact.
- Objective postcondition: JavaScript parses as text, parameters stay within the declared bounds, the oracle contains exact input/output notes, and the files are separate from any claim of Logic execution. Native completion additionally requires event equality, no stuck notes, and save/reopen persistence; it is currently blocked.

## LP8 - Reversible troubleshooting

- Trigger: Logic will not open a project, a plug-in fails, playback is unstable, or performance is degraded.
- Retained state: observation log, diagnostic copy plan, isolated cause class, and restoration record for D1.
- Primary route: guidance and read-only evidence collection.
- Escalation: live reproduction, app observation, host log collection, preference movement, resets, reinstallation, or deletion requires the matching verified runtime and separate authorization.
- Hybrid handoff: collect version, hardware, audio device, storage, plug-in, and project context; compare a protected project copy with a minimal empty-project hypothesis only in a future live run.
- Fallback: return a prioritized first-party-aligned test plan with every unexecuted step marked.
- Objective postcondition: each proposed test changes one variable, names its restore action, and records expected evidence. No cause is called confirmed without a reproduced A/B result.

