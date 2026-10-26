# pi-code

`pi-code` is a distribution package focused on **Software Engineering**, **Clean Code** and **Agile Development**. It injects engineering intelligence and technical rigor into [Pipa Core](https://github.com/aelinrezende/pipa), turning your generic orchestrator into a complete development team.

This package is not about designing products on paper (for that, use `pi-discovery`), but about **writing code, refactoring systems, building clean architectures and guaranteeing the technical quality** of the software being built.

It extends Pi with structured task execution, decentralized teammates, persistent
project planning, knowledge management, permission guards, and context hygiene.

Add the package to your Pi configuration (`settings.json` or `package.json`):

```json
"packages": [
  "git:github.com/aelinrezende/pi-code"
]
```

## 🚀 How It Works

When loaded, Pipa Core's base architecture detects this package and configures the local environment (`.pi/`) with domain rules exclusive to Engineering, bringing a mature Development Squad ready to operate.

### 👑 The Leadership (Chief Engineer)

Pipa takes on the **Chief Engineer** persona. She sets the rules of the game: strict adherence to Code Standards (`CODE-STANDARDS.md`), principles such as _Early Return_ (Fail Fast), mandatory unit tests and strict typing (TypeScript without `any`). Pipa coordinates the flow to keep the architecture solid on every delivery.

### 🤝 The Engineering Squad (Teammates)

To build software, the Chief Engineer relies on the following specialists:

1. **Product Manager** (`gerente-produto`): Gathers the initial scope, understands the user's pain, resolves ambiguities and defines business rules before a single line of code is written.
2. **Planner (Tech Lead)** (`planejadora`): Takes the business rules and produces the technical execution plan (`PLANO.md`), translating "what to do" into "how to do it".
3. **Quality Reviewer** (`revisora-qualidade`): Analyzes the Planner's plan adversarially and raises unanticipated questions and edge cases. The Planner refines the plan until the Quality Reviewer emits an **APPROVED** verdict — only then does the plan move to code. The cycle is capped at **3 rounds**; if the limit is reached without approval, the case escalates to the user.
4. **Staff (Execution Engineer)** (`staff`): The lead developer. Takes the technical plan and codes the solution in a robust, incremental and test-validated way. Chooses between **Fast-Track** (direct execution) and **Legião** (parallelism) by objective criteria, never by judging complexity.
5. **Developer** (`desenvolvedora`): A more tactical dev, ideal for quick bugs and isolated micro-tasks where the full planning bureaucracy is not worth it.
6. **Code Reviewer** (`revisora-codigo`): Reviews code diffs in Pull Requests (via GitHub CLI) and points out improvements.
7. **Acceptance Tester (UAT)** (`homologadora`): Tests the coded work through the eyes and journey of the end user, making sure the software really solves the stated problem.
8. **Communicator** (`comunicadora`): Writes update messages for the project's end client (non-technical people) — short, casual, WhatsApp-style, no jargon, always starting from the real delivery (diff/PR).

## 🛠️ Practical Usage

1. Start the session by handing the demand (new _feature_ or refactor) to Pipa.
2. The Chief Engineer may call the **Product Manager** (`gerente-produto`) to close business scope and the **Planner** (`planejadora`) to document the technical solution in `PLANO.md`.
3. The **Quality Reviewer** (`revisora-qualidade`) reviews the plan adversarially — the Planner adjusts and resubmits on every **REJECTED**, capped at **3 rounds** before escalating to the user — preventing future bugs.
4. The **Staff** (`staff`) takes the terminal. The path is chosen by objective criteria: **Fast-Track** when the plan touches fewer than 3 files, a single domain, and no API contract or database migration; anything else goes to **Legião**, where multiple **Developer** (`desenvolvedora`) instances run subtasks in parallel, each in its own subtask directory, under a **Disjunction Map** that prevents two workers from touching the same file.
5. Finally, the **Code Reviewer** (`revisora-codigo`) reviews the code and the **Acceptance Tester** (`homologadora`) signs off on the value delivered. Everything is tracked in the _artifacts_.

## 📦 Completion Artifacts

Every agent concludes its task with the `complete` action and delivers a named artifact:

| Agent                                   | Artifact                                                 |
| --------------------------------------- | -------------------------------------------------------- |
| Product Manager (`gerente-produto`)     | `ESCOPO.md`                                              |
| Planner (`planejadora`)                 | `PLANO.md`                                               |
| Quality Reviewer (`revisora-qualidade`) | `AUDITORIA.md` or `LAUDO.md`                             |
| Staff (`staff`)                         | `EXECUTION-REPORT.md`                                    |
| Developer (`desenvolvedora`)            | `EXECUTION-REPORT.md` (inside its own subtask directory) |
| Acceptance Tester (`homologadora`)      | `UAT-REPORT.md`                                          |
| Code Reviewer (`revisora-codigo`)       | `PR-REVIEW.md`                                           |
| Communicator (`comunicadora`)           | `CLIENT-UPDATE.md`                                       |
