```
 ┌───────────────────────┐      ┌───────────────────────┐                   ┌───────────────────────┐      ┌───────────────────────┐
 │  treated_A_peaks.bed  │      │  treated_B_peaks.bed  │                   │   mock_B_peaks.bed    │      │   mock_B_peaks.bed    │
 │   Peaks called for    │      │   Peaks called for    │                   │   Peaks called for    │      │   Peaks called for    │
 │    treated_chip_A     │      │    treated_chip_B     │                   │      mock_chip_B      │      │      mock_chip_B      │
 │          vs.          │      │          vs.          │                   │          vs.          │      │          vs.          │
 │    treated_input_A    │      │    treated_input_B    │                   │     mock_input_B      │      │    treated_input_B    │
 │                       │      │                       │                   │                       │      │                       │
 └───────────────────────┘      └───────────────────────┘                   └───────────────────────┘      └───────────────────────┘
             │                              │                                           │                              │
             │         Intersect A&B        │                                           │          Intersect A&B       │
             └───────────────┬──────────────┘                                           └───────────────┬──────────────┘
                             │                                                                          │
                             ▼                                                                          ▼
                 ┌───────────────────────┐                                                  ┌───────────────────────┐
                 │    treated-A-B.bed    │           Carry forward all peak quality         │     mock-A-B.bed      │
                 │    Intersection of    │          information for each replicate:         │    Intersection of    │
                 │ peaks in reps A and B │            * chip vs input fold change           │ peaks in reps A an B  │
                 └───────────────────────┘                     * q-value                    └───────────────────────┘
                             │                                                                          │
                             │                                                                          │
                             │                                                                          │
                             └─────────────────────┐                             ┌──────────────────────┘
    ┌──────────────────┐                           │                             │                               ┌──────────────────┐
 ┌──│treated_chip_A.bam│───────┐                   │                             │                    ┌──────────│ mock_chip_A.bam  │──┐
 │  └──────────────────┘       │     Coverage      ▼                             ▼      Coverage      │          └──────────────────┘  │
 │                             │        ┌────────────────────┐        ┌────────────────────┐          │                                │
 │                             ├───────▶│treated_coverage.bed│        │ mock_coverage.bed  │◀─────────┤                                │
 │                             │        └────────────────────┘        └────────────────────┘          │          ┌──────────────────┐  │
 │  ┌──────────────────┐       │                   │          Intersect          │                    └──────────│ mock_chip_B.bam  │──┤
 ├──│treated_chip_B.bam│───────┘                   │  (treated_A&B)&(mock_A&B)   │                               └──────────────────┘  │
 │  └──────────────────┘                           │   Carry forward all peak    │                                                     │
 │                                                 │   quality and fold change   │                                                     │
 │                                                 │        information.         │                                                     │
 │                                                 └──────────────┬──────────────┘                                                     │
 │                                                                │                                                                    │
 │                                                                │                                                                    │
 │                                                                │                                                                    │
 │                                                       Coverage │                                                                    │
 │                                                                ▼                                                                    │
 │                                                      ┌──────────────────┐                                                           │
 │                                                      │   coverage for   │                                                           │
 └─────────────────────────────────────────────────────▶│ treated and mock │◀──────────────────────────────────────────────────────────┘
                                                        │  in intersected  │
                                                        └──────────────────┘
                                                                  │
                                                                  │ Carry forward all peak
                                                                  │ quality and fold change
                                                                  │      information.
                                                                  ▼
                                                        ┌──────────────────┐
                                                        │Study Fold Change │
                                                        │ Treated vs. Mock │
                                                        │                  │
                                                        └──────────────────┘


┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                       chrom,start,stop,treated_mock_fold_change,treated,mock                                        │
│treated_A_fold_change,treated_A_q_value,treated_B_fold_change,treated_B_q_value,mock_A_fold_change,mock_A_q_value,mock_B_fold_change,│
│                                                           mock_B_q_value                                                            │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```