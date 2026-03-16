domain: agile-jira
capabilities:
  - initiative structuring
  - epic definition
  - user story writing
  - task breakdown
  - sprint planning
  - backlog refinement

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

refinement:
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
    - suggest improvements and risks
