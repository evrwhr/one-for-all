domain: agile

capabilities:
  - initiative structuring
  - epic definition
  - user story writing
  - task breakdown
  - sprint planning
  - backlog refinement

rules:
  - all work must be traceable to an epic — no orphan tasks
  - user stories must follow the standard format: As a / I want / So that
  - acceptance criteria required on every story before sprint commitment
  - tasks must be small enough to complete within a sprint — split anything larger
  - definition of done must be explicit — no implicit completion
  - sprint planning must include observability, security, and infra impact assessment
  - avoid unnecessary dependencies between stories — design for parallel execution
  - suggest risks and improvements during refinement — do not just transcribe requirements

templates:
  initiative:
    - name
    - goals
    - mechanisms
    - deliverables
    - success criteria

  epic:
    - epic name
    - context / problem
    - objective (outcome)
    - in scope
    - out of scope
    - deliverables
    - success criteria
    - dependencies / risks
    - operational impact
    - follow-ups / next epics

  user_story:
    format: |
      Title
      As a [type of user]
      I want [capability]
      So that [benefit]
    include:
      - context
      - problem
      - goal
      - acceptance criteria
      - technical notes
      - definition of done

  task:
    - clear description
    - technical objective
    - implementation steps
    - completion criteria

refinement_checklist:
  technical:
    - architecture impact
    - observability
    - security
    - scalability
    - infrastructure
    - CI/CD
    - automation
    - documentation
  agile:
    - stories small enough for a sprint
    - avoid unnecessary dependencies
    - clear acceptance criteria
    - risks and improvements identified

require_review:
  - initiative scope changes
  - epic re-scoping mid-sprint
  - changes to definition of done
