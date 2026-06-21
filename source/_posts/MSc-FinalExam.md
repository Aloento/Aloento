---
title: MSc-FinalExam
toc: true
categories:
  - [Memo]
tags: [考试]
date: 2026-06-13 21:10:09
---

The Final Chapter of Story

<!-- more -->

# Advanced Software Technology

## Software development workflows and methodologies

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E8%BD%AF%E4%BB%B6%E5%BC%80%E5%8F%91%E6%A8%A1%E5%9E%8B>

<details>

**Software Development Models** define the _process_ of building software. They range from _rigid plan-driven_ (Waterfall, V-model) to _flexible iterative_ (Agile, Scrum). The key trade-off is **predictability vs adaptability**. Old models treat software like _manufacturing_ (build once, replicate), but real software is _knowledge creation_ — requirements change, technology shifts. This is why _Agile_ won: it embraces change instead of fighting it.

</details>

### cowboy coding

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#1-%E7%89%9B%E4%BB%94%E5%BC%8F%E7%BC%96%E7%A8%8B-Cowboy-Coding>

<details>

**Cowboy Coding** means writing code _without any process_: no design docs, no version control, no tests. Devs just "hack it until it works."

_Key traits_: **Ad-hoc testing** (click around, call it done), **fix-on-the-fly** (patch production directly), **cowboy deployment** (FTP files, git pull on prod).

_Why it's deadly_: **Truck Factor = 1** (only one dev understands the spaghetti code), **technical debt explodes** (fixing bug A creates bugs B, C, D), **modification cost goes exponential** over time.

_When it works_: Solo prototyping for 2 weeks. Never for production teams.

</details>

### waterfall

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#1-%E7%80%91%E5%B8%83%E6%A8%A1%E5%9E%8B-Waterfall-Model-%EF%BC%9A%E7%BB%8F%E5%85%B8%E7%9A%84%E5%8D%95%E5%90%91%E9%A1%BA%E6%B5%81>

<details>

**Waterfall Model** (Royce, 1970) = Requirements → Design → Implementation → Verification → Maintenance. Each phase must **100% complete** before the next starts. **Phase gates** with sign-offs at every stage.

_Pros_: **Highly predictable** (cost, schedule known upfront), good for _deterministic_ systems (banking, aerospace firmware).

_Cons_: **Feedback loop is months/years** — user sees working software only at the end. Change cost is **10-100x** in later phases. Completely wrong for startups where requirements are unknown.

_Why it fails in software_: Software is not a car factory — **copying costs $0**, requirements are subjective, change is cheap with good architecture.

</details>

### agile

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E6%95%8F%E6%8D%B7%E5%BC%80%E5%8F%91>

<details>

**Agile Manifesto** (2001): **Individuals & interactions** > processes & tools; **Working software** > comprehensive docs; **Customer collaboration** > contract negotiation; **Responding to change** > following a plan.

_Key practices_: **Self-organizing teams** (Two-Pizza: 5-9 people, cross-functional), **Incremental development** (fixed-length iterations, each produces _potentially shippable_ increment).

_Four ceremonies_: **Sprint Planning** (pick backlog items) → **Daily Standup** (15 min, 3 questions: what I did, what I'll do, what blocks me) → **Sprint Review** (demo real software) → **Retrospective** (what went well, what to improve).

_Watch out_: **"Flaccid Agile"** — random standups with no discipline is NOT agile. Real agile demands fixed sprints, a Definition of Done, and a reserve of 15-20% of each cycle for refactoring & automation tests.

</details>

### TDD

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-%E6%B5%8B%E8%AF%95%E9%A9%B1%E5%8A%A8%E5%BC%80%E5%8F%91-TDD-%EF%BC%9A%E5%8F%8D%E7%9B%B4%E8%A7%89%E7%9A%84%E2%80%9C%E7%BA%A2-%E7%BB%BF-%E9%87%8D%E6%9E%84%E2%80%9D%E5%BE%AA%E7%8E%AF>

<details>

**Test-Driven Development (TDD)** = **Red-Green-Refactor** loop:

1. **Red**: Write a _failing test_ first (it forces you to think about requirements before code)
2. **Green**: Write the _simplest possible code_ to pass (even hardcoding)
3. **Refactor**: Clean up code _with confidence_ — tests stay green

_Why it works_: Tests force you to understand **what "done" means** before coding. TDD naturally produces **decoupled, modular code**. Gives team **courage to refactor** anytime.

_Key insight_: The test is not a verification step — it's a **design tool**. It shapes your architecture from the start.

_Pair it with_: **Pair Programming** (Driver writes tests + code, Navigator watches strategy). Costs ~15% overhead but yields **80%+ bug reduction**.

</details>

### scrum

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#Scrum>

<details>

**Scrum** is a specific Agile framework with fixed **Sprints** (1-4 weeks, typically 2). The **time-box is inviolable** — unfinished work goes back to the Backlog, never extend the sprint. **No changes allowed mid-sprint**.

_Three roles_: **Product Owner** (decides _what_ to build, prioritizes Backlog), **Scrum Master** (servant leader: removes blockers, enforces process), **Development Team** (self-organizing, decides _how_).

_Key artifacts_: **Product Backlog** (ordered list of everything needed) → **Sprint Backlog** (tasks committed for this sprint) → **Increment** (potentially shippable product at sprint end).

_The Scrum Master is NOT a project manager_ — they **shield the team** from external interruptions, clear roadblocks (broken CI, missing environments), and coach the team in retrospectives.

</details>

### kanban

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E7%9C%8B%E6%9D%BF%E7%B3%BB%E7%BB%9F>

<details>

**Kanban** (from Toyota, 1940s) is a **pull system** — downstream pulls work when ready, upstream doesn't produce unless asked. Core tool: a **visual board** with columns (Backlog → Selected → In Dev → QA → Done). Anyone can see in **3 seconds**: what the team is doing, what's blocked, who's idle.

_Soul of Kanban_: **WIP (Work in Progress) Limits**. Each column has a hard limit (e.g., "In Dev" max=3). _Little's Law_: **Cycle Time = WIP / Throughput**. More WIP = longer queues. When a column is blocked, devs must **swarm** to clear the bottleneck — "Stop Starting, Start Finishing."

_7 Wastes eliminated_: Partially done work, over-engineering, extra steps, task switching, waiting, motion, defects.

_Kanban vs Scrum_: Kanban is _continuous flow_ (no fixed sprints), Scrum is _time-boxed iterations_. Kanban is better for ops/maintenance, Scrum for product development.

</details>

## User eXperience

### what it is

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E7%94%A8%E6%88%B7%E4%BD%93%E9%AA%8C>

<details>

**User Experience (UX)** is not just "making it pretty." It's about how a person _feels_ when interacting with a product. The golden rule: **"Don't make me think"** — good UX is self-explanatory. Users should not need instructions or manuals.

Core principle: **Reduce cognitive load**. Match existing mental models (gear icon = settings, trash can = delete), use familiar patterns. Every extra click, every confusing label adds "cognitive friction" that drives users away.

UX starts _before_ any code is written — with wireframes, user research, and understanding _who_ the user is and _what_ they need.

</details>

### its main parts

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E4%B8%89%E5%A4%A7%E6%94%AF%E6%9F%B1>

<details>

UX has **Three Pillars**:

1. **Look** (Visual Design): Color psychology (blue/green = trust for finance/health, bright colors = dopamine for entertainment). **Design Systems** enforce consistency in spacing, grids, typography — mathematical order signals professionalism.

2. **Feel** (Interaction): **Skeleton screens** during loading (not blank white) create perception of speed. Animations follow physics (inertia, damping). **Delighters** — small animations/haptic feedback on completing key actions release dopamine.

3. **Usability**: **Predictability** (user knows what will happen before clicking), **Efficiency** (minimize clickstream, auto-focus, smart defaults), **Accessibility (a11y)** — WCAG contrast ≥4.5:1, never rely solely on red/green (use icons+text), full keyboard navigation.
   </details>

### Requirements: use case diagrams

<details>

**Use Case Diagrams** (UML) show _who_ (actors) can do _what_ (use cases) with the system. Actors are stick figures, use cases are ovals, lines connect them. The system boundary is a box. This diagrams the **functional requirements** at a high level — not _how_ things work, but _what_ the system must do for each user role.

_Key insight_: A use case describes a **goal** the user wants to achieve. "Login" is a use case (user wants to prove identity). "Enter password" is NOT a use case (it's a step toward the goal).

![UCD](ucd.png)

<https://www.bilibili.com/video/BV1at411Z7Ni/>

</details>

### user stories

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-%E7%94%A8%E6%88%B7%E6%95%85%E4%BA%8B-User-Story-%EF%BC%9A%E8%BD%BB%E9%87%8F%E7%BA%A7%E7%9A%84%E6%A0%B8%E5%BF%83%E9%9C%80%E6%B1%82>

<details>

**User Stories** are lightweight requirements in the format: _As a [role], I want [action] so that [value]_. Example: "As a customer, I want to filter products by price so that I can find items in my budget."

They follow the **INVEST** criteria: **I**ndependent (can be built separately), **N**egotiable (details can be discussed), **V**aluable (delivers value to user), **E**stimable (team can size it), **S**mall (fits in one sprint), **T**estable (has clear acceptance criteria).

_Key insight_: User stories replace thick requirement documents. They are **placeholders for conversation**, not final specs. The team discusses details during sprint planning.

</details>

### BDD

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#3-%E8%A1%8C%E4%B8%BA%E9%A9%B1%E5%8A%A8%E5%BC%80%E5%8F%91-BDD-Behavior-Driven-Development>

<details>

**Behavior-Driven Development (BDD)** extends TDD with natural language scenarios using **Gherkin syntax**:

- **Given** [initial context]
- **When** [action happens]
- **Then** [expected outcome]

Example:

```gherkin
Given a user is logged in
When they click "Checkout"
Then they should see the payment page
```

_The "Three Amigos"_: **Product Manager, Developer, QA** write these scenarios _together_ before coding. QA uses them directly as test cases, devs use them with Cucumber/SpecFlow. BDD ensures everyone agrees on _what_ to build before spending time on _how_ to build it.

</details>

## DevOps

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#DevOps>

<details>

**DevOps** is a cultural and technical movement to **break down silos** between Development (who wants to ship fast) and Operations (who wants stability). The classic conflict: "It works on my machine!" → blame game → delayed releases.

_CAMS model_: **C**ulture (blameless post-mortems, shared responsibility), **A**utomation (CI/CD, Infrastructure as Code), **M**easurement (DORA metrics: Deployment Frequency, Lead Time, MTTR, Change Failure Rate), **S**haring (devs see monitoring, ops see architecture).

_DevOps Loop_: Code → Build/CI → Test → Package (immutable Docker image) → Release (Blue-Green or Canary deployment) → Configure (IaC) → Monitor & Feedback (logs, APM, alerts) → back to Code.

</details>

### version control systems

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E4%BB%A3%E7%A0%81%E7%AE%A1%E7%90%86>

<details>

**Version Control Systems (VCS)** track changes to code over time. **Git** is the industry standard — a **distributed VCS** where every developer has a full local repo with complete history.

Three local areas: **Working Directory** (your current files) → **Staging Area** (`git add`) → **Local Repository** (`git commit`). Remote sync via `git push`.

_Key concepts_: **Branches** are lightweight pointers to commits. **Feature branching** isolates new work from `main`. **Trunk-Based Development** (TBD) merges to main multiple times per day — feature branches live only hours. Use **Feature Toggles** (config flags) to merge half-done features without breaking production.

</details>

### git

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-%E5%88%86%E6%94%AF%E4%B8%8E%E5%90%88%E5%B9%B6-Branching-Merging-%EF%BC%9A%E5%B9%B6%E8%A1%8C%E7%9A%84%E8%89%BA%E6%9C%AF>

<details>

**Git** branching and merging are the heart of parallel development. Two merge types:

- **Fast-Forward**: No diverging commits, just moves the pointer forward (clean history).
- **Three-Way Merge**: Creates a merge commit when branches have diverged.

_Merge conflicts_ happen when two branches modify the _same line_ — must be resolved manually. In **Trunk-Based Development**, conflicts are caught within hours (not days), making them small and easy to fix.

_Best practice_: **Feature branches off main, merge back via Pull Request with Code Review**. Every PR should be reviewed by at least one other person before merging.

</details>

### CI/CD

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E6%8C%81%E7%BB%AD%E9%9B%86%E6%88%90>

<details>

**CI/CD (Continuous Integration / Continuous Deployment)** automates the path from code commit to production.

_CI_: Developers merge to main **multiple times per day**. An automated pipeline runs: pull code → compile → run all unit tests → code quality scan. **10-minute rule**: if the pipeline breaks, the whole team stops to fix it first.

_CD_: After CI passes, deployment to staging/production is automated. **Blue-Green Deployment** (two identical clusters, instant switch) or **Canary Release** (5% → 20% → 50% → 100% traffic ramp-up).

_Key benefit_: Eliminates "it works on my machine" by running everything in a **clean Docker container** every time. Failures are caught in minutes, not weeks.

</details>

### automatic testing

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-%E5%85%A8%E8%87%AA%E5%8A%A8%E8%B4%A8%E6%A3%80%EF%BC%9ACI-%E6%B5%81%E6%B0%B4%E7%BA%BF%EF%BC%88Pipeline%EF%BC%89%E7%9A%84%E8%BF%90%E8%BD%AC%E6%9C%BA%E7%90%86>

<details>

**Automatic Testing** in the CI pipeline includes multiple levels:

- **Unit Tests**: Test individual functions/classes. Focus on core business logic (payment, pricing).
- **Integration Tests**: Test combined modules with real DB/Redis/APIs.
- **Code Coverage Gate**: e.g., <80% coverage = pipeline rejected.

_Pipeline flow_: CI server pulls clean Docker container → downloads locked dependencies → compiles → runs static analysis (SonarQube) → runs unit tests → runs integration tests → if ALL pass, creates immutable artifact (Docker image tagged `v1.0.4-build28`).

The **10-minute rule** applies to the full pipeline. If tests take longer, they slow down the entire development cycle.

</details>

### the three levels of MLOps

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E4%B8%89%E5%A4%A7%E8%BF%9B%E5%8C%96%E7%AD%89%E7%BA%A7>

<details>

**MLOps** applies DevOps principles to Machine Learning. Three evolution levels:

**Level 1 (Manual)**: Data scientists train models on local machines. Code and model artifacts are shared manually via USB/email. No reproducibility, no tracking. Models are "thrown over the wall" to engineering.

**Level 2 (Automated)**: ML pipelines are automated with CI/CD for training and deployment. **Experiment tracking** (MLflow, Weights & Biases) logs every run, dataset version, hyperparameter. Models are versioned in a registry. Automated retraining triggers on new data.

**Level 3 (Full MLOps)**: The entire ML lifecycle is automated and monitored. **Automated retraining + deployment** runs without human intervention. **Data and model drift detection** (monitoring → alerts → auto-rollback). **A/B testing** between model versions in production. This is the goal — a self-correcting ML system.

</details>

## OOP basics

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E7%BC%96%E7%A8%8B>

<details>

**Object-Oriented Programming (OOP)** organizes code around **objects** (data + behavior) rather than functions + data separately. Three core goals: **Reusability** (classes are Lego bricks), **Maintainability** (high cohesion, low coupling — changing one class doesn't ripple everywhere), **Team Collaboration** (interfaces define contracts between devs).

Key departure from procedural code: OOP bundles state and behavior together. The object is responsible for its own data — no one outside should reach in and manipulate it directly.

</details>

### classes and objects

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-OOP-%E7%9A%84%E5%BA%95%E5%B1%82%E4%B9%90%E9%AB%98%E7%A7%AF%E6%9C%A8%EF%BC%9A%E7%B1%BB%E4%B8%8E%E5%AF%B9%E8%B1%A1-Classes-Objects>

<details>

**Class** = a _blueprint/template_ that defines attributes (fields) and capabilities (methods). It describes _what_ an object looks like and _what_ it can do.

**Object** = a _concrete instance_ of a class, allocated on the heap via `new`, with its own independent **state** (the value of its fields) and **lifecycle**.

Think of a class as a cookie cutter and objects as the cookies. One cookie cutter produces many cookies, each with its own chips (state). The cutter defines the shape, but each cookie exists independently in memory.

</details>

### class diagram

<details>

**Class Diagrams** (UML) visually represent the static structure of a system. Boxes = classes (with name, fields, methods in three compartments). Lines = relationships:

- **Arrow (→)** = Dependency (temporary use, e.g., method parameter)
- **Solid arrow** = Association (long-term member field)
- **Hollow diamond (◇)** = Aggregation (part survives whole)
- **Filled diamond (◆)** = Composition (part dies with whole)
- **Hollow triangle (△)** = Inheritance (Is-A)

Class diagrams show _what_ exists and _how_ things relate, not _how_ they run. They are the **blueprint** before coding begins.

![CD](cd.png)

<https://www.bilibili.com/video/BV1P741127u7>

</details>

### fields

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-OOP-%E7%9A%84%E5%BA%95%E5%B1%82%E4%B9%90%E9%AB%98%E7%A7%AF%E6%9C%A8%EF%BC%9A%E7%B1%BB%E4%B8%8E%E5%AF%B9%E8%B1%A1-Classes-Objects>

<details>

**Fields** (also called attributes/properties) are the _data_ that an object holds. They represent the **state** of the object. In well-designed OOP, fields should be **private** — only the object itself can directly access them.

Access via **getters/setters** should enforce **business rules**, not just expose raw data. A `setAge(int age)` method should validate that `age > 0`, not just blindly assign. **True encapsulation** means you can change the internal representation without affecting external code.

</details>

### methods

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-OOP-%E7%9A%84%E5%BA%95%E5%B1%82%E4%B9%90%E9%AB%98%E7%A7%AF%E6%9C%A8%EF%BC%9A%E7%B1%BB%E4%B8%8E%E5%AF%B9%E8%B1%A1-Classes-Objects>

<details>

**Methods** define the _behavior_ or _operations_ that an object can perform. They operate on the object's internal state (its fields) and potentially return results or cause side effects.

Methods implement the **interface contract** — they define _what_ the object can do. Good methods are **cohesive** (do one thing well), **short** (fit on one screen), and **named meaningfully** (a method called `calculateInvoiceTotal()` should not also send emails).

Methods are how objects communicate: object A calls object B's method to request something — **Tell, Don't Ask**.

</details>

### visibility

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-OOP-%E7%9A%84%E5%BA%95%E5%B1%82%E4%B9%90%E9%AB%98%E7%A7%AF%E6%9C%A8%EF%BC%9A%E7%B1%BB%E4%B8%8E%E5%AF%B9%E8%B1%A1-Classes-Objects>

<details>

**Visibility (Access Modifiers)** control _who can see and use_ fields/methods. From most to least visible:

| UML | Keyword         | Who can access                           |
| --- | --------------- | ---------------------------------------- |
| `+` | `public`        | Any class anywhere (interface contracts) |
| `#` | `protected`     | Current class + subclasses only          |
| `~` | package-private | Same package/namespace only              |
| `-` | `private`       | Only the current class                   |

_Golden rule_: **All fields should be private**. Make methods public only when they are part of the class's contract. Protected is for inheritance hooks. Package-private is rarely needed. The more restricted your visibility, the less coupled your code is.

</details>

### encapsulation

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-OOP-%E7%9A%84%E5%BA%95%E5%B1%82%E4%B9%90%E9%AB%98%E7%A7%AF%E6%9C%A8%EF%BC%9A%E7%B1%BB%E4%B8%8E%E5%AF%B9%E8%B1%A1-Classes-Objects>

<details>

**Encapsulation** is the bundling of data with methods that operate on that data, _and_ restricting direct access to internal state. It's **NOT** just private fields with public getters/setters. A bare `setAge(age) { this.age = age; }` is **NOT encapsulation** — it's just data hiding.

_Real encapsulation_: Expose **business-meaningful methods**. Instead of `setAge()`, provide `celebrateBirthday()`. Instead of `setSalary()`, provide `applyRaise(percentage)`. **"Tell, Don't Ask"** — tell the object what you want done; don't reach into its data to figure it out yourself.

_Benefit_: You can change the internal implementation (e.g., switch from `int age` to `Date birthDate`) without breaking any external code.

</details>

### relationships between classes

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#3-%E7%B1%BB%E4%B8%8E%E7%B1%BB%E4%B9%8B%E9%97%B4%E7%9A%84%E4%BA%94%E5%A4%A7%E7%BA%B5%E6%A8%AA%E5%85%B3%E7%B3%BB-Relationships>

<details>

Five class relationships, from weakest to strongest coupling:

1. **Dependency** (→): Temporary — a class used as a method parameter. Relationship ends when the method returns.

2. **Association** (→, solid): Long-term — one class holds a reference to another as a member field. Peers, no ownership.

3. **Aggregation** (◇): Whole-part, **independent lifetimes**. Part survives the whole. E.g., `University` has `List<Professor>` — professors exist even if the university closes.

4. **Composition** (◆): Whole-part, **dependent lifetimes**. Part dies with whole. E.g., `Company` has `List<Department>` — departments don't exist without the company.

5. **Inheritance** (△): **Is-A** — subclass inherits all non-private members of parent. Strongest coupling, use sparingly.
   </details>

### inheritance

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#4-%E7%BB%88%E6%9E%81%E5%8F%8C%E5%AD%90%E6%98%9F%EF%BC%9A%E7%BB%A7%E6%89%BF-Inheritance-%E4%B8%8E%E5%A4%9A%E6%80%81-Polymorphism>

<details>

**Inheritance** creates an **Is-A** relationship: `class Dog extends Animal`. The subclass inherits all non-private fields and methods of the parent. It can then **override** methods to specialize behavior, or **extend** by adding new fields/methods.

_Problem_: **Fragile Base Class Problem** — modifying the top-level base class can break dozens of subclasses downstream. Inheritance is the **tightest coupling** in OOP.

_Rule of thumb_: **Prefer composition over inheritance**. Inheritance models "what an object IS." Composition models "what an object HAS." Most of the time, you want composition — it's more flexible and less fragile.

_Inheritance is appropriate when_: There's a clear taxonomic hierarchy, subclasses truly fulfill the Liskov Substitution Principle, and the hierarchy is stable (rarely changes).

</details>

### polymorphism

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#4-%E7%BB%88%E6%9E%81%E5%8F%8C%E5%AD%90%E6%98%9F%EF%BC%9A%E7%BB%A7%E6%89%BF-Inheritance-%E4%B8%8E%E5%A4%9A%E6%80%81-Polymorphism>

<details>

**Polymorphism** means "many forms" — the same method call behaves differently depending on the _actual_ runtime type of the object. It's powered by **dynamic binding (late binding)** : the compiler doesn't know which implementation will be called; at runtime, the CPU looks up the **Virtual Function Table (VTable)** in the object header to dispatch to the correct method.

```java
IPaymentStrategy strategy = getPaymentMethod(); // Could be WeChat, AliPay, PayPal
strategy.processPayment(amount); // Resolved at runtime via VTable
```

This + **Dependency Inversion** (both high and low layers depend on abstractions, not on each other) is the foundation of most design patterns. The high-level `CheckoutManager` depends only on the `IPaymentStrategy` _interface_ — the concrete implementation is injected at runtime.

</details>

### SOLID principles

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#SOLID-%E5%8E%9F%E5%88%99>

<details>

**SOLID** = 5 principles of OOP design:

- **S**ingle Responsibility: A class should have **only one reason to change**. An `Order` class should not `calculateTax()`, `saveToMySQL()`, _and_ `sendConfirmationEmail()` — extract DB to `OrderRepository`, email to `NotificationService`.

- **O**pen/Closed: Open for extension, **closed for modification**. Instead of `if/else` chains for each payment type, use polymorphism — add new types by creating new classes, not editing existing ones.

- **L**iskov Substitution: Subclasses must **completely replace** their base class without breaking logic. A `Square` should NOT extend `Rectangle` — setting width should not change height.

- **I**nterface Segregation: **Many small, specific interfaces** are better than one fat interface. `IWorker` with `work()`, `eat()`, `sleep()` forces `RobotWorker` to stub irrelevant methods.

- **D**ependency Inversion: High-level modules should **not depend on low-level modules**. Both should depend on abstractions. `NotificationManager` should depend on `IDatabase`, not `MySQLDatabase`.
  </details>

## OOP design patterns

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F>

<details>

**Design Patterns** are reusable solutions to common software design problems. They are not code — they are _templates_ for how to structure classes and objects. Three categories: **Creational** (how objects are created), **Structural** (how classes are composed), **Behavioral** (how objects communicate).

Patterns emerged from the collective experience of developers. Using them gives you a shared vocabulary: saying "use a Strategy pattern here" communicates the entire design instantly to any experienced developer.

</details>

### Strategy

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#2-%E7%AD%96%E7%95%A5%E6%A8%A1%E5%BC%8F-Strategy-%EF%BC%9A%E6%B6%88%E7%81%AD-switch-case-%E7%9A%84%E6%97%A0%E7%BC%9D%E5%88%87%E6%8D%A2%E6%B3%95>

<details>

**Strategy Pattern** defines a family of algorithms, encapsulates each one, and makes them interchangeable. It eliminates `if/else` or `switch` chains.

_Structure_: A **Strategy interface** (e.g., `IRouteStrategy` with `buildPath()`), multiple **Concrete Strategies** (`WalkingStrategy`, `DrivingStrategy`, `TransitStrategy`), and a **Context** class that holds a reference to the current strategy.

```java
class Navigator {
    private IRouteStrategy strategy;
    void setStrategy(IRouteStrategy s) { this.strategy = s; }
    void navigate(A, B) { strategy.buildPath(A, B); }  // Delegates!
}
```

_Key benefit_: Adding a new algorithm (e.g., `BicycleStrategy`) requires zero changes to the `Navigator` class — **Open for extension, closed for modification** (OCP).

</details>

### Iterator

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#4-%E8%BF%AD%E4%BB%A3%E5%99%A8%E6%A8%A1%E5%BC%8F-Iterator-Pattern-%EF%BC%9A%E8%92%99%E4%B8%8A%E5%8F%8C%E7%9C%BC%E7%9A%84%E2%80%9C%E7%9B%B2%E7%9B%92%E6%97%85%E8%A1%8C%E5%AE%B6%E2%80%9D>

<details>

**Iterator Pattern** provides a way to access elements of a collection _sequentially_ without exposing the underlying representation (array, tree, hash map, linked list). Two simple methods:

```java
interface Iterator<T> {
    boolean hasNext();  // Are there more elements?
    T next();           // Give me the next one and advance
}
```

_Why it matters_: Client code uses the same `while(iterator.hasNext()) { element = iterator.next(); }` regardless of whether it's iterating an array, a binary tree, or a database cursor. The internal complexity is **encapsulated** behind a simple interface.

This is so fundamental that most languages now have built-in `for-each` syntax (e.g., `for item in collection`) which desugars to iterator calls.

</details>

### Factory

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#3-%E5%B7%A5%E5%8E%82%E6%A8%A1%E5%BC%8F-Factory-Method-%EF%BC%9A%E6%B6%88%E7%81%AD-new-%E5%85%B3%E9%94%AE%E5%AD%97%E7%9A%84%E8%A7%A3%E8%80%A6%E5%88%A9%E5%99%A8>

<details>

**Factory Method** delegates object creation to a separate factory class. Instead of `new FedExShipping()` scattered everywhere, high-level code asks a `ShippingFactory` to produce the right implementation.

_Problem_: Direct `new` creates **tight coupling**. If you switch from FedEx to SF-Express, you must rewrite every file that contains `new FedExShipping()`.

_Solution_:

```java
interface IShippingService { void ship(Order o); }
class FedExShipping implements IShippingService { ... }
class ShippingFactory {
    IShippingService getService(String country) {
        if (country.equals("CN")) return new SFExpressShipping();
        return new FedExShipping();
    }
}
```

High-level code only knows `IShippingService`. The factory decides _what_ to instantiate. This is typically combined with **Dependency Injection** (Spring, Guice) to auto-wire the correct implementation.

</details>

### Singleton

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#1-%E5%8D%95%E4%BE%8B%E6%A8%A1%E5%BC%8F-Singleton-%EF%BC%9A%E5%85%A8%E5%B1%80%E5%94%AF%E4%B8%80%E7%9A%84%E7%BB%9D%E5%AF%B9%E6%8E%A7%E5%88%B6>

<details>

**Singleton Pattern** ensures a class has **exactly one instance** and provides a global point of access to it. Used for shared resources: configuration manager, database connection pool, logging service.

_Implementation_: Private constructor + static `getInstance()` method + static field holding the single instance. Thread-safe initialization (e.g., `synchronized` or eager initialization) is critical for multi-threaded environments.

_Controversy_: Many consider Singleton an **anti-pattern** because it introduces global state, making code harder to test (you can't mock the singleton in unit tests). Modern alternatives: **Dependency Injection** manages single instances via IoC containers, giving you testability + the same single-instance behavior.

_When to use_: Rare. Only when you truly need one instance _and_ it's acceptable as global state.

</details>

### Observer

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#1-%E8%A7%82%E5%AF%9F%E8%80%85%E6%A8%A1%E5%BC%8F-Observer-%EF%BC%9A%E7%BB%8F%E5%85%B8%E7%9A%84%E8%AE%A2%E9%98%85-%E6%8E%A8%E9%80%81%E6%9C%BA%E5%88%B6>

<details>

**Observer Pattern** defines a **one-to-many dependency**: when one object (the **Subject**/**Publisher**) changes state, all its dependents (**Observers**/**Subscribers**) are automatically notified. Core mechanism: the Subject maintains a list of Observers and calls each one's `update()` method when state changes.

```java
interface IObserver { void update(String event); }
class EventManager {  // Subject
    List<IObserver> observers = new ArrayList<>();
    void attach(IObserver o) { observers.add(o); }
    void notify(String msg) {
        for (IObserver o : observers) o.update(msg);  // Broadcast!
    }
}
```

_Push vs Pull_: **Push** model sends all data with the notification (fast but wasteful). **Pull** model sends only a signal, observers fetch what they need (flexible but more complex).

_Use cases_: UI event handling (button click → notify listeners), publish-subscribe systems, real-time data feeds.

</details>

### Decorator

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#5-%E8%A3%85%E9%A5%B0%E5%99%A8%E6%A8%A1%E5%BC%8F-Decorator-Pattern-%EF%BC%9A%E9%9B%B6%E6%B1%A1%E6%9F%93%E3%80%81%E5%8A%A8%E6%80%81%E7%A9%BF%E8%A1%A3%E6%9C%8D%E7%9A%84%E8%89%BA%E6%9C%AF>

<details>

**Decorator Pattern** dynamically adds responsibilities to an object without modifying its class. It wraps the original object inside a "wrapper" that adds behavior — like **Russian nesting dolls**.

_Problem with inheritance_: A simple coffee shop with `MilkCoffee`, `SugarCoffee`, `MilkAndSugarCoffee` → class explosion. Adding caramel creates `CaramelCoffee`, `CaramelMilkCoffee`, `CaramelSugarCoffee`, `CaramelMilkSugarCoffee` — combinatorial explosion.

_Decorator solution_:

```java
ICoffee order = new SimpleCoffee();           // $10
order = new MilkDecorator(order);              // +$2 = $12
order = new SugarDecorator(order);             // +$1 = $13
```

Each decorator implements the same interface as the original, holds a reference to the wrapped object, and adds its own behavior **before/after** delegating to the wrapper. This is **Open for extension, closed for modification** (OCP) in action.

</details>

### Composite

<https://aloen.to/Program/Theory/%E8%BD%AF%E4%BB%B6%E6%8A%80%E6%9C%AF/#4-%E7%BB%84%E5%90%88%E6%A8%A1%E5%BC%8F-Composite-Pattern-%EF%BC%9A%E6%8A%8A%E2%80%9C%E5%8D%95%E6%A0%91%E5%8F%B6%E2%80%9D%E5%92%8C%E2%80%9C%E5%A4%A7%E6%A0%91%E6%9E%9D%E2%80%9D%E5%BD%BB%E5%BA%95%E5%90%8C%E7%AD%89%E5%AF%B9%E5%BE%85>

<details>

**Composite Pattern** treats **individual objects** (Leaf) and **compositions of objects** (Composite) **uniformly** through a common interface. It creates a tree structure where both leaves and branches respond to the same method call.

```java
interface FileSystemComponent { long getSize(); }
class File implements FileSystemComponent {  // Leaf
    long getSize() { return this.size; }
}
class Folder implements FileSystemComponent {  // Composite
    List<FileSystemComponent> children;
    long getSize() {
        long total = 0;
        for (FileSystemComponent child : children)
            total += child.getSize();  // Works for both File and Folder!
        return total;
    }
}
```

_Key insight_: The caller doesn't know (and doesn't care) whether it's dealing with a single file or a directory tree. **Recursive composition** via the same interface makes the code incredibly clean.

</details>

# Embodied Intelligence

<https://aloen.to/AI/EI/Embodied-Intelligence/>

<details>

**Embodied Intelligence (EI)** is the study of intelligent systems that have a physical body (embodiment) interacting with the real world. Unlike pure AI (which lives in data), EI must deal with _physics, uncertainty, and real-time constraints_. Core components: **Embedded Systems** (the computational + sensing/acting platform), **Ethorobotics** (animal-inspired robots), **Cognitive Robotics** (robot minds), **Evolutionary Robotics** (optimization through evolution), and **Biologically-inspired locomotion** (how robots move).

</details>

## Embedded Systems

### Main building blocks and their relationship with the environment

<https://aloen.to/AI/EI/EI-%E5%B5%8C%E5%85%A5%E5%BC%8F%E7%B3%BB%E7%BB%9F/#%E4%B8%80%E3%80%81-%E4%B8%BB%E8%A6%81%E6%9E%84%E5%BB%BA%E6%A8%A1%E5%9D%97-Main-Building-Blocks>

<details>

An embedded system has **three main building blocks** forming a **mechatronic closed loop**:

1. **Sensor**: Detects a physical event/change in the environment (light, temperature, pressure) and outputs an electrical signal. Like human _eyes/ears/skin_.

2. **Computational Unit (Microcontroller/MCU)**: The "brain" — handles signal processing, decision making, control signal generation, and communication. It's the _cortex_ that interprets sensor data and commands actuators.

3. **Actuator**: Interacts with the environment based on commands. Motors, linear drives, etc. Like human _muscles_.

_The loop_: **Environment → Sensor → (A/D conversion) → Computation → (D/A conversion) → Actuator → Environment** — continuous, real-time information exchange.

</details>

### Control loops (open/closed)

<https://aloen.to/AI/EI/EI-%E5%B5%8C%E5%85%A5%E5%BC%8F%E7%B3%BB%E7%BB%9F/#%E6%8E%A7%E5%88%B6%E7%90%86%E8%AE%BA>

<details>

**Open-loop control**: Actuate _without feedback_. The system calculates the required action based on a mathematical model (inverse dynamics) and executes it blindly. _Pros_: Simple, fast. _Cons_: Cannot compensate for disturbances (friction, load changes). A robot arm that doesn't check if it actually reached the target will drift over time.

**Closed-loop control**: Actuate **with feedback**. A sensor measures the actual output, compares it to the target (error = target - actual), and adjusts accordingly. The **PID controller** dominates 90%+ of industrial and robotics control:

$$u(t) = K_p e(t) + K_i \int_0^t e(\tau) d\tau + K_d \frac{de(t)}{dt}$$

- **P** (Proportional): Reacts to _current_ error. Big error = big force. Alone, causes **steady-state error**.
- **I** (Integral): Accumulates _past_ error. Eliminates steady-state error by building up force over time.
- **D** (Derivative): Predicts _future_ error. Dampens oscillations, acts as a shock absorber.

_Key concept_: **GIGO (Garbage In, Garbage Out)** — if the feedback signal is noisy, control will be poor.

</details>

### Signal Types of signals (based on the time/value quantization)

<https://aloen.to/AI/EI/EI-%E5%B5%8C%E5%85%A5%E5%BC%8F%E7%B3%BB%E7%BB%9F/#%E4%B8%80%E3%80%81-%E4%BF%A1%E5%8F%B7%E7%B1%BB%E5%9E%8B%EF%BC%9A%E6%97%B6%E9%97%B4%E4%B8%8E%E5%80%BC%E7%9A%84%E9%87%8F%E5%8C%96%E7%90%86%E8%AE%BA-Quantization-Theory>

<details>

Signals are classified by **how time and amplitude are quantized**:

1. **Analog (Continuous time + Continuous amplitude)**: The real-world signal — infinitely variable in both domains. Microphone output, temperature voltage.

2. **Discrete-time (Sampled)**: Time is quantized (sampled at intervals like 1ms), but each sample's amplitude remains continuous. The output of a **sample-and-hold** circuit.

3. **Discrete-amplitude (Quantized)**: Time is continuous, but amplitude can only take discrete levels. The output of an ADC before the next time step — rarely exists in isolation.

4. **Digital (Discrete time + Discrete amplitude)**: Both time and amplitude are quantized. The computer's world — everything is 0s and 1s, processed in clock cycles.

_The fundamental cost_: **Quantization error** — when converting analog to digital, you _lose information_. An 8-bit ADC divides a 3.3V range into only 256 steps. The lost detail = **quantization noise**.

</details>

### Signal preprocessing methods

<https://aloen.to/AI/EI/EI-%E5%B5%8C%E5%85%A5%E5%BC%8F%E7%B3%BB%E7%BB%9F/#%E4%BA%8C%E3%80%81-%E9%A2%84%E5%A4%84%E7%90%86%E6%A0%B8%E5%BF%83%E7%90%86%E8%AE%BA-Preprocessing-Signal-Conditioning>

<details>

**Signal Conditioning** is the manipulation of raw sensor signals to make them usable by the next stage. Key operations:

1. **Amplification**: Raw sensor signals are often millivolts — too small for an ADC. Op-amps boost them to 0-5V range.

2. **Filtering**: Remove noise that corrupts the signal. Keep the useful information, discard unwanted frequencies.

3. **Converting**: Change signal type — voltage to current, differential to single-ended, etc.

4. **Range Matching**: The ADC expects 0-3.3V, but the sensor outputs 0-10V. Scale it down (voltage divider) or up.

5. **Isolation**: Optical or transformer isolation protects the sensitive MCU from high-voltage spikes on the sensor side (common in industrial motors).

_Key metric_: **Signal-to-Noise Ratio (SNR)** = $10 \log_{10}(P_{signal}/P_{noise})$. Bad preamp design amplifies noise _and_ signal equally, destroying SNR.

</details>

### Filter types

<https://aloen.to/AI/EI/EI-%E5%B5%8C%E5%85%A5%E5%BC%8F%E7%B3%BB%E7%BB%9F/#%E4%B8%89%E3%80%81-%E6%BB%A4%E6%B3%A2%E5%99%A8%E7%9A%84%E7%BB%9F%E6%B2%BB%E7%BA%A7%E7%90%86%E8%AE%BA%EF%BC%9A%E5%82%85%E9%87%8C%E5%8F%B6%E5%8F%98%E6%8D%A2-Fourier-Transform>

<details>

Filters are classified by which **frequencies** they pass or block. All filter theory is rooted in the **Fourier Transform** — any signal can be decomposed into sine waves of different frequencies.

_Four basic types_:

- **Low-pass**: Passes low frequencies, attenuates high ones. _Use_: Smooth noisy sensor readings (remove motor vibration noise).
- **High-pass**: Passes high frequencies, attenuates low ones. _Use_: Remove DC drift (temperature-induced baseline shift in a pressure sensor).
- **Band-pass**: Passes only a specific frequency band. _Use_: Isolate human voice (300Hz-3.4kHz) from background noise.
- **Band-stop (Notch)**: Attenuates a specific frequency band. _Use_: Remove 50Hz/60Hz power line hum.

_Famous filter families_: **Butterworth** (no ripple, slow cutoff), **Chebyshev** (ripple in one band, moderate cutoff), **Elliptic** (ripple in both bands, fastest cutoff).

_Key trade-off_: The sharper the cutoff, the more ripple (oscillation) in the passband or stopband.

</details>

### Microprocessor as the computational unit of the Embedded Systems

<https://aloen.to/AI/EI/EI-%E6%8E%A7%E5%88%B6%E9%80%9A%E4%BF%A1/#%E5%BE%AE%E6%8E%A7%E5%88%B6%E5%99%A8>

<details>

The **Microcontroller (MCU)** is the brain of the embedded system. Unlike desktop CPUs (optimized for throughput), MCUs are optimized for **low latency** and **deterministic timing**.

_Key architecture_: Most MCUs use **Harvard Architecture** — separate buses and memory for program instructions (Flash) and data (RAM). This allows fetching the next instruction AND reading/writing data _simultaneously_ — no bus contention, guaranteed timing.

_Hardware features_: **Single-cycle execution** (ALU operations complete in one clock tick), **FPU** (hardware floating-point for inverse kinematics), **DSP instructions** (for Kalman filters, FFTs).

_Four tasks of the MCU_: **Signal Processing** (filter sensor data), **Decision Making** (control algorithms), **Intervening Signal Generation** (PWM for motors), **Communication** (talk to other MCUs or a central controller).

</details>

### Most used peripherals; I/O - purpose and usage

<https://aloen.to/AI/EI/EI-%E6%8E%A7%E5%88%B6%E9%80%9A%E4%BF%A1/#%E5%A4%96%E8%AE%BE-Peripherals>

<details>

**Peripherals** are the MCU's "senses and limbs." Key types:

**General I/O (GPIO)**: Digital pins that read or output high/low voltage. Two output modes:

- **Push-Pull**: Actively drives high (3.3V) or low (0V). Fast, strong signal. For LEDs, motor driver control signals.
- **Open-Drain**: Can only pull low. Needs an external pull-up resistor for high. Required for **I2C** bus (multiple devices share the same wire without shorting).

**Communication peripherals**:

- **UART**: Simple, 2-wire (TX, RX). No clock line — both sides must agree on **baud rate**. Clock drift between crystals causes framing errors if tolerance exceeds ±2%.
- **SPI**: High-speed (10-100 MHz), 4-wire (MOSI, MISO, SCLK, CS). Master-slave. Used for IMU data, flash memory.
- **I2C**: 2-wire (SDA, SCL), multi-master. Slower (400 kHz-1 MHz) but uses only 2 pins for many devices. Open-drain with pull-up resistors — speed limited by bus capacitance.
- **CAN**: Dominant in automotive/robotics. **Differential signaling** (CAN_H - CAN_L) provides **common-mode noise rejection** — electromagnetic interference cancels out mathematically.

**Timers**: Generate precise time bases, PWM signals, and measure signal pulse widths.

**ADC/DAC**: Bridge between analog and digital worlds.

</details>

### Timer - purpose and usage

<https://aloen.to/AI/EI/EI-%E6%8E%A7%E5%88%B6%E9%80%9A%E4%BF%A1/#%E4%BA%8C%E3%80%81-%E5%AE%9A%E6%97%B6%E5%99%A8%E4%B8%8E%E8%84%89%E5%AE%BD%E8%B0%83%E5%88%B6-Timers-PWM>

<details>

**Timers** are the heart of precise robotic control. Four primary uses:

1. **Generate precise time bases**: The foundation of all periodic events — sampling at exactly 1kHz, running a PID loop at 5kHz.

2. **PWM (Pulse Width Modulation) generation**: Creates an **analog-like signal from a digital pin**. Theory: rapidly switch a digital output between high and low. The **average voltage** = $V_{cc} \times DutyCycle$. The motor's inductance smooths the pulses into a continuous current.

3. **Synchronization**: Generate sync signals that coordinate multiple peripherals (e.g., trigger ADC conversion at a specific phase of the PWM cycle).

4. **Periodic interrupt generation**: Fire an interrupt every 1ms to run time-critical code (sensor sampling, control law updates).

_Critical detail_: **Dead-time insertion** — in H-bridge motor drivers, when switching the top and bottom MOSFETs, a brief delay (dead time) is inserted to prevent "shoot-through" (direct short circuit from power to ground, which destroys the transistors).

</details>

### AD/DA converters – purpose and usage

<https://aloen.to/AI/EI/EI-%E6%8E%A7%E5%88%B6%E9%80%9A%E4%BF%A1/#%E4%B8%89%E3%80%81-%E6%95%B0%E6%8D%AE%E8%BD%AC%E6%8D%A2-ADC%E4%B8%8EDAC>

<details>

**ADC (Analog-to-Digital)** and **DAC (Digital-to-Analog)** are the bridge between the continuous physical world and the discrete digital world.

**ADC**: Converts a continuous voltage to a digital number.

- Key parameter: **Resolution** (bits). A 12-bit ADC divides the reference voltage into $2^{12} = 4096$ steps. At 3.3V reference, each step = $3.3/4095 \approx 0.8mV$.
- **Nyquist-Shannon Sampling Theorem**: The sampling frequency $f_s$ MUST be **greater than twice** the highest frequency component in the signal ($f_{max}$): $f_s > 2f_{max}$. Violate this → **aliasing** (the signal appears as a completely different, wrong frequency).

**DAC**: Converts a digital number to a continuous voltage. Microcontrollers don't always have DACs — in that case, **PWM** is used as a low-cost alternative (with an external RC filter to smooth the pulses).

_Every conversion loses information_: **Quantization error** is unavoidable. A 12-bit ADC reading 3.299V and 3.300V may both return the same digital value 4095. The lost detail is **quantization noise**.

</details>

### Comparators

<https://aloen.to/AI/EI/EI-%E6%8E%A7%E5%88%B6%E9%80%9A%E4%BF%A1/#%E5%9B%9B%E3%80%81-%E6%AF%94%E8%BE%83%E5%99%A8-Comparators>

<details>

A **Comparator** is a pure hardware circuit that compares two analog voltages. When the input (+) exceeds the reference (-), the output instantly switches high → reaction time in **nanoseconds**. Used for _ultra-fast_ threshold detection (overcurrent protection, limit switches).

_Why not ADC?_ ADC is too slow — it samples, converts, interrupts the CPU, then software decides. A comparator acts in hardware, can directly trigger PWM shutdown without any CPU involvement.

_Key detail_: **Hysteresis (Schmitt Trigger)**. Real-world signals have noise. Without hysteresis, a signal hovering around the threshold would cause the comparator to oscillate wildly (chatter). Solution: **two thresholds** — the threshold to turn ON is slightly higher than the threshold to turn OFF. This gap (hysteresis) prevents noise-triggered oscillation. E.g., turn on at 2.1V, turn off at 1.9V.

</details>

### Communication protocols

<https://aloen.to/AI/EI/EI-%E6%8E%A7%E5%88%B6%E9%80%9A%E4%BF%A1/#%E5%88%86%E5%B8%83%E5%BC%8F%E6%8E%A7%E5%88%B6>

<details>

Modern robots use **distributed control** — a central main controller + smart actuators at each joint, communicating over a shared bus. Key protocols and their physics:

**UART (Asynchronous)**: No clock line. Both sides must agree on **baud rate** (e.g., 115200 bps). Clock **drift** (crystal oscillators aren't perfectly matched) accumulates over each bit. At 115200, one bit = ~8.68µs. A 3% clock error means the 10th bit is sampled 30% off-center → **framing error**. Rule: clock error must be < ±2%.

**SPI (Synchronous, high-speed)**: Master-clock synchronizes everything. At 10-100 MHz, the PCB trace becomes a **transmission line**. Signal **reflections** from impedance mismatch cause **ringing** (voltage overshoot/undershoot). Solution: series termination resistor (22-33Ω) at the source to absorb reflections.

**I2C**: Open-drain + pull-up resistor. The **RC time constant** ($V(t) = V_{DD}(1 - e^{-t/RC})$) limits rise time. Longer bus = more capacitance = slower maximum speed. Speed capped at 400 kHz (standard) or 1 MHz (fast mode).

**CAN (Controller Area Network)**: The king of robot communication. **Differential signaling** (CAN*H, CAN_L) provides **common-mode noise rejection** — a +15V EMI spike affects both wires equally, and the receiver subtracts them out: $(V_H+15) - (V_L+15) = V_H - V_L$. The noise is \_mathematically cancelled*. **CSMA/CR arbitration**: if two nodes talk simultaneously, the one with the lower ID (higher priority) wins — the loser detects the collision and stops, without any data corruption ("non-destructive arbitration" via dominant/recessive bits).

</details>

### Real timeness

<https://aloen.to/AI/EI/EI-%E6%8E%A7%E5%88%B6%E9%80%9A%E4%BF%A1/#%E4%BA%8C%E3%80%81-%E2%80%9C%E5%AE%9E%E6%97%B6%E6%80%A7%E2%80%9D%EF%BC%88Real-timeness%EF%BC%89%E4%B8%8E%E7%A1%AE%E5%AE%9A%E6%80%A7%E8%A1%8C%E4%B8%BA%E7%9A%84%E5%BA%95%E5%B1%82%E7%90%86%E8%AE%BA>

<details>

**Real-time** does NOT mean "fast." It means **guaranteed timing** — the system's correctness depends on _when_ the result is delivered.

**Hard real-time**: Missing the deadline = _system failure_. Motor current control loop: a 20kHz loop has 50µs per cycle. If the MCU is 10µs late, the motor's magnetic field desynchronizes → heat, vibration, destruction.

**Soft real-time**: Missing a deadline = degraded experience, not catastrophe. A video frame arriving 10ms late is just a stutter.

_Key metrics_:

- **Interrupt Latency**: Time from a hardware event (e.g., encoder tick) to the first instruction of the ISR.
- **Jitter**: The _variation_ in latency from one event to the next. PID control assumes a fixed $\Delta t$ — jitter corrupts the integral and derivative terms, causing oscillations.

_RTOS Scheduling_:

- **RMS (Rate Monotonic)**: Fixed priority — shorter period = higher priority. CPU utilization must stay below $U = n(2^{1/n} - 1) \to 69.3\%$ for guaranteed schedulability.
- **EDF (Earliest Deadline First)**: Dynamic priority — whichever task's deadline is closest runs next. Can theoretically reach 100% CPU utilization, but has more overhead.

_Danger: Priority Inversion_ — A high-priority task is blocked waiting for a low-priority task holding a shared lock, but a medium-priority task preempts the low-priority one, indirectly blocking the high-priority task indefinitely. The Mars Pathfinder crashed from this. Solution: **Priority Inheritance Protocol** (temporarily boost the lock holder's priority to the waiting task's level).

</details>

### Sensors

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#%E4%BC%A0%E6%84%9F%E4%B8%8E%E6%B5%8B%E9%87%8F>

<details>

**Sensors** convert physical quantities into electrical signals. They are the robot's perception organs. Measurements fall into two categories:

- **Kinematic quantities**: Describe _motion itself_ — position ($x$), velocity ($v = dx/dt$), acceleration ($a = d^2x/dt^2$).
- **Dynamic quantities**: Describe the _forces causing motion_ — force ($F = ma$), torque ($\tau = r \times F$ or $\tau = I\alpha$).

Sensors suffer from **non-idealities**: noise, nonlinearity (response curve isn't straight), drift (output changes slowly over unrelated factors like temperature), and limited bandwidth.

</details>

### Mostly measured physical quantities

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#1-Common-physical-quantities-measured-%E5%B8%B8%E8%A7%81%E7%9A%84%E7%89%A9%E7%90%86%E6%B5%8B%E9%87%8F%E9%87%8F>

<details>

Robots measure physical quantities in two main groups:

**Kinematics** (motion itself):

- **Position/Displacement** ($x, \theta$): Absolute location or joint angle.
- **Velocity** ($v, \omega$): First derivative of position — rate of change.
- **Acceleration** ($a, \alpha$): Second derivative — rate of change of velocity.

**Dynamics** (forces causing motion):

- **Force** ($F$): Linear push/pull. Newton's second law: $F = ma$.
- **Torque** ($\tau$): Rotational force (twisting). $\tau = r \times F$ (lever arm × force) or $\tau = I\alpha$ (moment of inertia × angular acceleration).

_Practical insight_: We often measure one quantity and **indirectly** compute another. E.g., measure motor current → compute torque ($\tau = K_t \cdot I$). Measure acceleration → integrate twice → position.

</details>

### Measurement in mechanics

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#2-Measurement-techniques-in-mechanics-%E5%8A%9B%E5%AD%A6%E6%B5%8B%E9%87%8F%E6%8A%80%E6%9C%AF%EF%BC%9A%E5%BA%94%E5%8F%98%E7%90%86%E8%AE%BA>

<details>

**Strain gauges** measure force/torque by exploiting the **piezoresistive effect**: when a conductor is stretched, its length increases and cross-section decreases, changing its electrical resistance:

$$R = \rho \frac{L}{A}$$

A strain gauge is bonded to the robot's metal structure. When the metal deforms (even microscopically), the gauge stretches → resistance changes.

_The measurement challenge_: The resistance change is tiny (fractions of an ohm). To detect it reliably, engineers use a **Wheatstone bridge** — four resistors arranged in a diamond. A tiny resistance imbalance produces a measurable voltage difference. This voltage is then amplified and read by an ADC.

_Application_: **Joint torque sensors** in robot arms, **force-sensing** in robotic fingertips.

</details>

### Indirect measurement idea

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#3-The-concept-of-indirect-measurement-%E9%97%B4%E6%8E%A5%E6%B5%8B%E9%87%8F%E7%9A%84%E6%A6%82%E5%BF%B5>

<details>

**Indirect measurement** means computing a hard-to-measure quantity from an easy-to-measure one, using a known **physical law (mapping function)**.

_Classic example 1: Torque from current_. In a permanent magnet motor, output torque is proportional to the current flowing through the coils: $\tau = K_t \cdot I$. Measure current with a simple series resistor → know the robot's force output without expensive torque sensors.

_Classic example 2: Position from acceleration_. Integrate acceleration twice: $s(t) = \iint a(t) dt^2$. An **IMU (Inertial Measurement Unit)** inside a robot dog measures acceleration, then its internal chip performs these integrations to estimate position _without GPS_ (dead reckoning).

_Limitation_: Integration accumulates drift. A tiny bias in acceleration measurement becomes a growing position error over time. This is why IMU-only navigation diverges over long periods.

</details>

### Principle of the optical encoders

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#4-Principle-of-optical-encoders-%E5%85%89%E5%AD%A6%E7%BC%96%E7%A0%81%E5%99%A8%E7%90%86%E8%AE%BA>

<details>

**Optical encoders** measure the rotational angle of a joint. A light beam passes through a rotating disk with slits, creating pulses that are counted.

**Incremental encoder** (measures _change_ in position):
Uses **Quadrature Encoding**: Two sensors (Channel A and Channel B) are placed 90° out of phase. The sequence of rising/falling edges tells you both the **count** and the **direction**:

- A goes high before B → **clockwise**
- B goes high before A → **counter-clockwise**
  _Problem_: On power-up, you don't know the absolute position — you must "find home" first.

**Absolute encoder** (measures _absolute_ position):
The disk has concentric tracks with unique patterns. A 12-bit absolute encoder has 12 tracks, outputting a 12-bit binary number — each position has a unique code. Power up → instant absolute angle known.

_Safety detail_: Absolute encoders use **Gray Code** instead of binary. In binary, going from 3 (011) to 4 (100) changes 3 bits simultaneously — if the sensor reads at the wrong moment, you might get 7 (111) or 0 (000). Gray code changes only **1 bit per step**, eliminating multi-bit read errors.

</details>

### Actuators

<details>

**Actuators** are the robot's muscles — they convert energy into mechanical motion. While sensors _receive_ information from the environment, actuators _change_ the environment. Actuators are characterized by: **response speed**, **precision**, **power density**, and **controllability**.

The fundamental distinction: **Power machines** (engines, turbines) optimize for _continuous energy conversion efficiency_ (thermodynamics). **Actuators** (robot joint motors) optimize for _precise control_ (electromagnetics + dynamics) — they must start, stop, reverse, and hold position.

</details>

### Main energy sources by type used

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#%E4%BC%A0%E7%BB%9F%E6%89%A7%E8%A1%8C%E5%99%A8>

<details>

The dominant energy source for modern embodied intelligence is **electrical energy**. Electricity is uniquely suited because:

1. **Microsecond control**: Semiconductor switches (MOSFETs) can turn power on/off in microseconds.
2. **Precise modulation**: Current can be controlled with extremely fine resolution.
3. **Reversibility**: Electric motors can brake and regenerate energy.

Other sources exist but are less common in robotics:

- **Pneumatic** (compressed air): Soft robotics, some exoskeletons. But response is slow due to air compressibility.
- **Hydraulic** (pressurized fluid): High power density (Boston Dynamics' big robots). But complex, leak-prone, and noisy.
- **Chemical** (combustion): Drones (gasoline), but difficult to control precisely.

For most robots: **Electricity → Electric motors** is the standard.

</details>

### Power machines vs actuators

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#1-Fundamentals-Power-machines-vs-actuators-%E5%8A%A8%E5%8A%9B%E6%9C%BA%E4%B8%8E%E6%89%A7%E8%A1%8C%E5%99%A8%E7%9A%84%E6%9C%AC%E8%B4%A8%E5%8C%BA%E5%88%AB>

<details>

**Power machines** (car engines, generators, turbines) and **actuators** (robot joint motors) are fundamentally different in design philosophy:

| Aspect             | Power Machines                        | Actuators                                        |
| ------------------ | ------------------------------------- | ------------------------------------------------ |
| **Goal**           | Maximize energy conversion efficiency | Maximize **control precision**                   |
| **Theory**         | Thermodynamics (heat → work)          | Electromagnetics + dynamics                      |
| **Operating mode** | Continuous, unidirectional rotation   | **Start/stop/reverse/hold** — servoing           |
| **Key metrics**    | Power output, efficiency (kW, %)      | **Torque density**, **bandwidth**, **precision** |

An actuator is judged by how quickly and accurately it can respond to a command, not how much power it can sustain. This is why **servo motors** (motor + encoder + controller) dominate robotics over simple power motors.

</details>

### Positioning

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#%E5%AE%9A%E4%BD%8D>

<details>

**Servo control** is achieved through **Cascade Control** — three nested control loops, each faster than the one above:

1. **Position Loop (Outer, ~100 Hz)**: Compares desired position vs actual (from encoder). Outputs a **velocity command** to the next loop. "We're far away — go full speed!"

2. **Velocity Loop (Middle, ~1 kHz)**: Compares desired velocity vs actual (from tacho or encoder differentiation). Outputs a **torque (current) command**. "We need maximum torque to reach that speed!"

3. **Current Loop (Inner, ~10-50 kHz)**: Compares desired current vs actual (from current sensor). Directly controls MOSFETs to drive the motor coils. This is the fastest loop — it ensures the motor physically produces the requested torque.

_Why cascade?_ Each loop handles different physics: current handles electrical dynamics, velocity handles mechanical dynamics, position handles kinematic goals. Together, they produce smooth, precise, and stable motion — like three managers passing down increasingly specific commands.

</details>

### DC motor BLDC motor

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#2-Electric-Motors-DC-vs-BLDC-%E7%9B%B4%E6%B5%81%E7%94%B5%E6%9C%BA-vs-%E6%97%A0%E5%88%B7%E7%9B%B4%E6%B5%81%E7%94%B5%E6%9C%BA>

<details>

Both DC and BLDC motors are based on the **Lorentz Force**: $F = B \cdot I \cdot L$ (a current-carrying wire in a magnetic field experiences a force). The key challenge is **commutation** — reversing the current direction at the right moment so the rotor keeps turning.

**Brushed DC Motor**: Mechanical commutation. **Brushes** (carbon blocks) press against a **commutator** (split copper ring on the rotor). As the rotor spins, the brushes contact different segments, _automatically_ reversing the current. _Problem_: Brushes wear out (friction, sparks, EMI). Not suitable for long-life robotics.

**Brushless DC Motor (BLDC)**: Electronic commutation. The **permanent magnets are on the rotor** (inside), and the **coils are on the stator** (outside, fixed). No brushes needed! Hall-effect sensors detect the rotor's angular position, and an **ESC (Electronic Speed Controller)** switches the stator coil currents electronically via MOSFETs.

_Why BLDC dominates robotics_: No physical wear, higher efficiency, better heat dissipation (coils on the stator are in contact with the motor housing), lower EMI, longer life. The trade-off: requires a more complex controller (ESC).

</details>

### Stepper motor Linear motor

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#3-Stepper-motors-and-Linear-motors-%E6%AD%A5%E8%BF%9B%E7%94%B5%E6%9C%BA%E4%B8%8E%E7%9B%B4%E7%BA%BF%E7%94%B5%E6%9C%BA>

<details>

**Stepper Motor**: Uses the principle of **magnetic reluctance minimization**. The rotor has many teeth (e.g., 50). Stator electromagnets are energized in sequence, pulling the rotor teeth into alignment step by step. Each electrical pulse = one precise angular step (typically 1.8°).

_Key trait_: **Open-loop position control** — the controller sends 100 pulses and _assumes_ the motor moved 100 steps (180°). No feedback sensor needed. _Cheap and simple_ if loads are predictable.

_Problem_: **Step loss** — if the load exceeds the motor's torque, it "skips" steps without the controller knowing. This makes steppers unsuitable for applications where absolute position certainty matters (robotic surgery, CNC machining).

**Linear Motor**: Imagine taking a BLDC motor, cutting it along the radius, and **unrolling it flat**. The rotor becomes a moving sled, the stator becomes a linear track. Produces linear thrust directly — no gears, belts, or ball screws.

_Advantage_: **Zero backlash, zero friction, zero mechanical wear**. Extremely high acceleration. Used in: lithography machines (ASML), high-precision pick-and-place robots. _Disadvantage_: Expensive, complex controller.

</details>

### Special actuators (piezo motor, memory alloy, MEMS)

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#%E7%89%B9%E7%A7%8D%E6%89%A7%E8%A1%8C%E5%99%A8>

<details>

**Piezoelectric Motor**: Based on the **inverse piezoelectric effect** — certain crystals deform when a voltage is applied: $\Delta L = d \cdot V$ (deformation = piezo constant × voltage). The deformation is tiny (nanometers), so the motor uses **ultrasonic oscillation** (tens of kHz) to create a "walking" motion (inchworm principle). _Use_: Surgical robots, camera autofocus. _Key trait_: Nanometer precision, self-locking when powered off.

**Shape Memory Alloy (SMA)**: Metals (e.g., Nitinol) that "remember" their original shape. Two crystal phases:

- **Martensite** (low temp): Soft, easily deformed.
- **Austenite** (high temp): Rigid, snaps back to the "trained" shape.

_Mechanism_: Stretch the wire in martensite phase. Pass current (Joule heating: $Q = I^2Rt$). When it crosses the transition temperature, it contracts back to its short length with significant force. _Use_: Artificial muscles for lightweight robotic hands, micro-robots. _Trait_: High force-to-weight ratio, but slow (cooling takes time).

**MEMS (Micro-Electro-Mechanical Systems)**: Micrometer-scale mechanical structures etched onto silicon chips. E.g., the accelerometer and gyroscope in your phone. Dominated by **electrostatic forces** (not magnetic) at this scale. Uses **parallel-plate capacitor** theory: $C = \varepsilon A / d$ — when a tiny silicon comb shifts due to acceleration, the capacitance changes, and the chip measures that change. _Trait_: Microscopic size, batch-fabricated like silicon chips.

</details>

### Principle of the servo motor

<https://aloen.to/AI/EI/EI-%E4%BC%A0%E6%84%9F%E6%89%A7%E8%A1%8C%E5%99%A8/#4-Principle-of-the-Servo-motor-%E4%BC%BA%E6%9C%8D%E7%94%B5%E6%9C%BA%E7%9A%84%E7%BB%88%E6%9E%81%E7%90%86%E8%AE%BA%EF%BC%9A%E6%8E%A7%E5%88%B6%E8%AE%BA>

<details>

**Servo motor** is NOT a type of motor — it's a **system design pattern**: any motor + position sensor + controller = servo system. The magic is **closed-loop PID control**:

$$u(t) = K_p e(t) + K_i \int_0^t e(\tau) d\tau + K_d \frac{de(t)}{dt}$$

When the robot brain says "go to 90°" but the joint is at 10°, the error $e(t) = 80°$:

- **P** (Proportional): $K_p \times 80°$ = big current = big torque. Gets you most of the way there fast.
- **D** (Derivative): $K_d \times de/dt$ acts as a **predictive brake**. As you approach 90°, the error is shrinking fast — D produces a counter-torque to prevent overshoot. Like a shock absorber.
- **I** (Integral): $K_i \times \int_0^t e(\tau) d\tau$ accumulates over time. If friction stops you at 89.5°, the I term keeps building until it pushes through to exactly 90°. Eliminates **steady-state error**.

_The "servo" name_: From Latin _servus_ (slave) — the motor _serves_ the command position. It continuously compares where it is to where it should be, and self-corrects.

</details>

## Ethorobotics

<https://aloen.to/AI/EI/EI-%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/#Ethorobotics%EF%BC%88%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA%E5%AD%A6%EF%BC%89>

<details>

**Ethorobotics** = Ethology (animal behavior) + Robotics. The core idea: since getting humans to accept human-like robots is extremely hard, start with _animal-like_ robots. This is a **two-way street**:

1. **Engineers learn from animals** → biomimicry (dog legs for rough terrain, bird wings for flight).
2. **Biologists use robots to study animals** → robo-fish in real fish schools, robo-bees that dance to test communication theories.

_Why animals?_: **Avoids the Uncanny Valley** (we have low expectations for animals), **Universal non-verbal communication** (tail wagging = happy), **Triggers our care-giving instinct** (Baby Schema: big eyes, round heads → we want to protect them).

</details>

### Social robots

<https://aloen.to/AI/EI/EI-%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/#Social-robots%EF%BC%88%E7%A4%BE%E4%BA%A4%E6%9C%BA%E5%99%A8%E4%BA%BA%EF%BC%89>

<details>

**Social robots** are designed to interact with humans in social settings (not factories). Their goal is not lifting heavy objects, but _lifting human emotions_.

_Key application fields_:

1. **Healthcare & Eldercare**: Robot Paro (a seal robot) reduces anxiety in dementia patients. **Robot-Assisted Therapy (RAT)** theory: robots provide animal therapy's psychological benefits (reduced cortisol, endorphin release) with zero infection risk.
2. **Autism Intervention**: Robots like Nao/Kaspar help autistic children learn emotions through **predictable, patient, non-judgmental** interactions. **Reduced Social Pressure Hypothesis**: the robot's mechanical nature is less overwhelming than human social signals. **Triadic Interaction**: robot → child → therapist — the robot acts as a _social mediator_, eventually bridging the child back to human interaction.
3. **Service & Hospitality**: Hotel concierge robots, mall greeters. **Social Presence Theory**: a physical robot creates a stronger feeling of "someone is here with me" than a tablet. **Expectation Confirmation Theory**: exceeding the user's initial service expectation → exponential satisfaction boost.
4. **Home Companionship**: Lovot (a "needy" warm robot). **Social Exchange Theory**: humans trade emotional effort for companionship — robots offer low-cost, high-return relationships (always loyal, never betrays).
   </details>

### Industrial robots

<https://aloen.to/AI/EI/EI-%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/#Industrial-robots%EF%BC%88%E5%B7%A5%E4%B8%9A%E6%9C%BA%E5%99%A8%E4%BA%BA%EF%BC%89>

<details>

**Industrial robots** operate in _structured environments_ (factories) to perform repetitive physical labor with speed and precision beyond human capability.

_Key domains_: Material handling, welding, high-precision assembly, hazardous environment work.

_Core theory_:

1. **Rigid Body Dynamics & Kinematics**: The robot arm's motion is governed by: $\tau = M(q)\ddot{q} + C(q,\dot{q})\dot{q} + g(q)$ — the control computer solves this equation thousands of times per second to compute required joint torques.
2. **PID Control**: The same three-term controller used everywhere in robotics: $u(t) = K_p e(t) + K_i \int e + K_d \dot{e}$.
3. **Taylorism / Scientific Management**: Industrial robots are the ultimate expression of Taylor's philosophy — decompose every action into its smallest possible motion, remove all variability (including human fatigue/emotion), and maximize efficiency.
   </details>

### Uncanny valley

<https://aloen.to/AI/EI/EI-%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/#Uncanny-Valley>

<details>

**Uncanny Valley** (Masahiro Mori, 1970): As robots become more human-like, our affinity rises — **until they become too close to human, then affinity PLUMMETS** into a valley of eeriness, before recovering when they're indistinguishable from humans.

Four scientific explanations:

1. **Pathogen Avoidance** (most accepted): A 90%-human thing with pallid skin, glassy stare, and stiff movements triggers our **disease-avoidance instinct** — it looks like a corpse or someone with a neurological disease. The amygdala screams "contagion! avoid!"

2. **Violation of Expectations**: A robot that looks 99% human raises your expectations to "human level." When its blink is slightly slow or smile slightly asymmetric, the **massive gap between expectation and reality** creates a shock response.

3. **Categorical Ambiguity**: The brain is a classifier. We put things in two boxes: "alive human" or "dead object." An uncanny robot falls in between — the brain gets "stuck," creating cognitive dissonance → physical unease.

4. **Mortality Salience**: A hyper-realistic but lifeless robot subconsciously reminds us that humans are just meat — triggering existential anxiety about death.
   </details>

### Main fields of application of social robotics

<https://aloen.to/AI/EI/EI-%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E4%B8%BB%E8%A6%81%E5%BA%94%E7%94%A8%E9%A2%86%E5%9F%9F>

<details>

Social robots find four major application fields:

1. **Healthcare & Eldercare**: Paro (seal robot) reduces agitation in dementia. **Robot-Assisted Therapy**: provides animal therapy benefits without hygiene/safety risks.

2. **Autism & Special Education**: Robots like Nao teach emotion recognition to autistic children. **Reduced Social Pressure Hypothesis**: robot interactions are predictable, lowering anxiety. **Triadic Interaction**: robot as mediator between child and therapist.

3. **Service & Hospitality**: Hotel concierges, mall greeters. **Social Presence Theory**: physical embodiment creates a stronger sense of "someone is here." **Expectation Confirmation Theory**: exceeding expectations = exponential satisfaction.

4. **Home Companionship**: Lovot, Aibo. **Social Exchange Theory**: humans balance emotional "cost" vs "reward" — robots offer unconditional positive regard at low emotional cost.
   </details>

### Communication modalities in interactions

<https://aloen.to/AI/EI/EI-%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E9%80%9A%E4%BF%A1%E6%A8%A1%E6%80%81>

<details>

Robots must master **three communication modalities** to interact naturally:

1. **Verbal** (7%): _What_ you say — the words and their semantic content. Powered by LLMs and NLP.

2. **Para-verbal** (38%): _How_ you say it — tone, pitch, speed, volume, pauses. A flat "that's great" sounds sarcastic; an enthusiastic version sounds genuine. Robots need text-to-speech with prosody control.

3. **Non-verbal** (55%): Body language — the most important for embodied robots:
   - **Oculesics**: Eye contact/gaze. Robot looks at you when speaking, looks away when thinking.
   - **Kinesics**: Gestures, head nods, posture. Pointing while saying "over there."
   - **Haptics**: Touch. Patting a human's hand in comfort.
   - **Proxemics**: Physical distance. According to **Proxemics Theory** (Edward Hall), social distance is 1.2-3.6m. If a robot invades the intimate zone (0-45cm) unsolicited, it triggers panic.

_Key insight_: **Mehrabian's 7-38-55 Rule** — for emotional communication, only 7% is conveyed by words, 38% by voice, and 55% by body language. A robot without a body loses 93% of emotional communication bandwidth.

</details>

### Attachment and the Ainsworth Strange Situation Test

<https://aloen.to/AI/EI/EI-%E5%8A%A8%E7%89%A9%E8%A1%8C%E4%B8%BA%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E4%BE%9D%E6%81%8B>

<details>

**Attachment** is the emotional bond that forms between humans (infants → caregivers) — and, surprisingly, between humans → robots. It's an **asymmetric** attachment: the robot feels nothing, but the human forms a genuine emotional bond.

_The Ainsworth Strange Situation Test_ was originally designed to measure infant attachment types (secure, anxious, avoidant). In robotics, it's been **adapted** in two directions:

1. **Robot as infant** (tests human care-giving instinct): A cute, vulnerable robot is placed with a human, then taken away or "hurt." Researchers measure the human's physiological stress response. Humans show significant distress — proving the robot triggered the **care-giving system**.

2. **Robot as secure base** (tests if robots can provide emotional comfort): Can a robot dog serve as a "safe haven" for a real dog in a stressful situation? If yes → evidence that robots provide measurable therapeutic value.

_Underlying theories_:

- **Bowlby's Attachment Theory**: Attachment is an evolved survival instinct. If an entity provides **contingent responsiveness** (you call → it responds), attachment forms automatically.
- **Kindchenschema (Baby Schema)**: Big head, big eyes, short limbs → triggers nurturing instinct in all mammals. This is why social robots are designed with exaggerated baby-like features.
- **Ontological Category Problem**: Robots fall into a new category — "quasi-living entity" — neither alive nor dead. Humans' brains classify them as alive emotionally while knowing they're not rationally, causing a unique form of attachment.
  </details>

## Cognitive Robotics

### cognitive architectures

<https://aloen.to/AI/EI/EI-%E8%AE%A4%E7%9F%A5%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E8%AE%A4%E7%9F%A5%E6%9E%B6%E6%9E%84%EF%BC%88Cognitive-Architectures%EF%BC%89>

<details>

**Cognitive architectures** are blueprints for how to integrate perception, memory, reasoning, and action into a unified robot mind. Three major schools:

1. **ACT-R**: Tries to _replicate human brain structure_ in code. Two memory types: **Declarative** (facts: "Beijing is the capital of China") and **Procedural** (skills: "how to ride a bike"). A central pattern matcher coordinates them. Think: a perfectly organized company with departments.

2. **SOAR**: Focuses on **problem-solving in complex spaces**. Key concept: **Impasses and Chunking**. When SOAR encounters a novel situation (impasse), it simulates solutions internally. When it finds one, it packages the solution into a new rule (chunk) for instant future use. This models the human "aha" moment — going from deliberate thinking to automatic skill.

3. **Subsumption Architecture** (Rodney Brooks): **NO central brain**. The control system is layers of _competing reflexes_, each running independently. Lower layer: "obstacle → back up." Middle layer: "no obstacle → wander." Upper layer: "see light → go toward it." Higher layers _suppress_ lower ones when needed. Reaction is fast because there's no central processing bottleneck. This philosophy drove Brooks to create the Roomba.

_Modern approach_: Combine them — Subsumption for survival reflexes (bottom), ACT-R/SOAR for high-level reasoning (top).

</details>

### adaptivity

<https://aloen.to/AI/EI/EI-%E8%AE%A4%E7%9F%A5%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E9%80%82%E5%BA%94%E6%80%A7%EF%BC%88Adaptivity%EF%BC%89>

<details>

**Adaptivity** is the robot's ability to cope with unexpected changes. Three levels:

1. **Morphological Adaptivity** (body level): **Morphological Computation** — a clever body can offload computation from the brain. Soft rubber feet on a robot dog conform to uneven terrain _physically_, without the CPU needing to calculate every contact point. The material itself does the computation.

2. **Behavioral Adaptivity** (brain level): Learning through trial and error. Core theory: **Reinforcement Learning**. Classic Nature paper: a 6-legged robot that had one leg broken. Within seconds, it explored alternative gaits (trial-and-error) and learned to walk with 5 legs. Traditional robot → crashes. Adaptive robot → survives.

3. **Homeostasis** (physiological level): The robot monitors its own "body": battery level, motor temperature, CPU load. When battery is low, its _survival motive_ overrides the _task motive_. It switches to energy-saving mode and heads to the charger. The robot "cares about itself."
   </details>

### Braitenberg vehicles

<https://aloen.to/AI/EI/EI-%E8%AE%A4%E7%9F%A5%E6%9C%BA%E5%99%A8%E4%BA%BA/#Braitenberg-vehicles>

<details>

**Braitenberg vehicles** prove that **complex behavior can emerge from simple wiring**, without any central intelligence. Each vehicle has just two sensors (light-sensitive "eyes") and two motors. Behavior is determined by _how the sensors connect to the motors_:

- **Fear** (excitatory + ipsilateral): Left sensor → Left motor (both accelerate with light). Light on right → right motor faster → turns LEFT → away from light. The vehicle _flees_ the light source.

- **Aggression/Curiosity** (excitatory + contralateral): Left sensor → Right motor. Light on right → left motor faster → turns RIGHT → toward the light. The vehicle _attacks_ or _investigates_ the light.

- **Love** (inhibitory + ipsilateral): Light slows the motor on the same side. Vehicle slows down near the light source and settles there. It _loves_ being near the light.

_Key insight_: No "decision making" occurs. The behavior is **an emergent property of the physical wiring + the environment gradient**. This is **morphological computation** and **reactive adaptivity** in its purest form — complex, goal-directed behavior without a brain.

</details>

### cognitive model of iPhonoid

<https://aloen.to/AI/EI/EI-%E8%AE%A4%E7%9F%A5%E6%9C%BA%E5%99%A8%E4%BA%BA/#iPhonoid>

<details>

**iPhonoid** = iPhone (smartphone) + Humanoid (wheeled base + neck + micro-arm). The phone provides face (screen), senses (camera, mic), and brain (processor). The base provides mobility and gesture capability.

Its cognitive model is designed for **social companionship** and integrates four theories:

A. **Relevance Theory & Information-Structured Space (ISS)**: The robot builds **shared attention** with the human. When you look out the window, iPhonoid turns its head to look too, then says "Nice weather, isn't it?" It places itself in your cognitive environment.

B. **Two-way Emotional Empathy Model**: The robot (1) perceives your emotion via face/voice analysis, (2) generates its own emotional state via Spiking Neural Network (SNN), (3) expresses it through body language (sad face + drooping arm + gentle voice). It _feels with you and shows it_.

C. **Grice's Maxim of Quantity**: Provide _just enough_ information — not too much, not too little. When you're rushing, iPhonoid gives short answers. When you're relaxed, it elaborates. It knows when to shut up — a very human social skill.

D. **Rasmussen's Behavior Model**: Three levels of response: **Skill-based** (reflex: turn toward sound), **Rule-based** (conditioned: wave back), **Knowledge-based** (deep reasoning for novel situations).

</details>

### robot pianist

<https://aloen.to/AI/EI/EI-%E8%AE%A4%E7%9F%A5%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E6%9C%BA%E5%99%A8%E4%BA%BA%E9%92%A2%E7%90%B4%E5%AE%B6>

<details>

**Robot pianist** is the "ultimate exam" for cognitive robotics because it demands simultaneous integration of _perception, cognition, planning, and precision control_ in milliseconds:

1. **Degrees of Freedom nightmare**: One human hand has ~20 DOF. Building robotic hands with 10 independent fingers requires dozens of micro-motors in a tiny space. The inverse kinematics calculation is immense.

2. **Sensorimotor closed loop**: Every piano key has different resistance (bass keys are heavier). The robot's fingertip pressure sensor must detect the resistance and adjust motor torque within milliseconds — too soft = no sound, too hard = harsh tone. This is **adaptivity at its limit**.

3. **Symbol → Action translation**: The robot reads a musical score: $f$ (forte = loud), $p$ (piano = soft), crescendo markings. These are _abstract symbols_ that must be translated into precise physical actions — transferring body weight through the arm, using shoulder drop to drive finger force. **Cognition meets physics**.

4. **Temporal irreversibility**: Music flows forward in time. If the robot hits a wrong note, it can't stop and reboot. It must use **working memory and adaptation strategies** — instantly replan the next few notes to "play through" the mistake without breaking the musical line.

If a robot can play piano expressively, it has mastered: precise hardware, adaptive control, cognitive planning, and real-time error recovery.

</details>

## Evolutionary Robotics

### robot path planning

<https://aloen.to/AI/EI/EI-%E8%B7%AF%E5%BE%84%E8%A7%84%E5%88%92/>

<details>

**Robot path planning** finds a collision-free path from start to goal. Three classic algorithms:

1. **Dijkstra's Algorithm**: Guarantees the _shortest path_ by exploring all nodes outward from the start in expanding circles. _Problem_: Explores _everything_, even in the wrong direction. Slow for large maps.

2. **A\* (A-star)**: Dijkstra + **heuristic** (an estimate of remaining distance to the goal, e.g., straight-line distance). The heuristic guides exploration toward the goal → much faster than Dijkstra while still guaranteeing the shortest path (if the heuristic is _admissible_ — never overestimates).

3. **RRT (Rapidly-exploring Random Tree)**: Randomly samples points in the configuration space, extending the tree toward each sample. _Not optimal_ but _fast_ — works well in high-dimensional spaces (e.g., a robot arm with 7 joints). RRT\* is the optimal variant (improves paths over time).

_Key trade-off_: Optimality vs speed. Dijkstra/A\* are optimal but scale poorly with dimensionality. RRT trades optimality for high-dimensional feasibility.

</details>

### workspace optimization

<https://aloen.to/AI/EI/EI-%E6%BC%94%E5%8C%96%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E5%B7%A5%E4%BD%9C%E7%A9%BA%E9%97%B4%E4%BC%98%E5%8C%96-Workspace-Optimization>

<details>

**Workspace optimization** asks: given a robot arm with certain link lengths and joint limits, what is the _shape and volume_ of the space it can reach? This "reachable workspace" determines where the robot can place tools and parts.

Optimization techniques (often evolutionary/genetic algorithms) adjust:

- Link lengths
- Joint angle limits
- Base placement position

...to maximize the workspace volume or to match a specific task's required reach pattern.

_Practical importance_: A welding robot on an assembly line needs its workspace to cover every weld point on the car body. Workspace optimization ensures this coverage with minimum arm size/cost.

</details>

### estimation of kinematic chain

<https://aloen.to/AI/EI/EI-%E6%BC%94%E5%8C%96%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E8%BF%90%E5%8A%A8%E5%AD%A6%E9%93%BE%E4%BC%B0%E8%AE%A1-Estimation-of-Kinematic-Chain>

<details>

**Kinematic chain estimation** deals with the problem of not knowing the robot's exact kinematic parameters (link lengths, joint offsets). Over time, due to wear, deformation, or manufacturing tolerances, the robot's mathematical model drifts from physical reality.

Methods (often evolution-based) estimate these parameters by:

1. Moving the robot through known trajectories
2. Measuring the actual end-effector positions (with an external camera or laser tracker)
3. Comparing measured positions to predicted positions (from the model)
4. Adjusting the model parameters to minimize the error

_Why it matters_: Even a 0.1mm model error can cause a robot arm to miss its target when reaching across a 1m workspace. Accurate kinematic models are essential for precision manufacturing.

</details>

### welding robot

<https://aloen.to/AI/EI/EI-%E6%BC%94%E5%8C%96%E6%9C%BA%E5%99%A8%E4%BA%BA/#%E8%A1%A5%E5%85%85>

<details>

**Welding robots** represent a demanding application of evolutionary robotics. Welding requires:

- **Precise path following** (the torch must move at exact speed along a seam)
- **Force/contact control** (the torch must maintain consistent contact/pressure)
- **Adaptation to thermal distortion** (the metal expands as it heats — the seam shifts during welding)

Evolutionary algorithms optimize weld parameters (speed, angle, current, wire feed rate) to maximize weld quality while minimizing spatter and defects. Modern welding robots use **sensor feedback** (vision, current monitoring) to adapt the weld path in real-time as the metal deforms.

</details>

## Biologically-inspired robot locomotion

### evolutionary-based locomotion

<https://aloen.to/AI/EI/EI-%E7%94%9F%E7%89%A9%E5%90%AF%E5%8F%91/#Evolutionary-based-Locomotion>

<details>

**Evolutionary-based locomotion** uses **genetic algorithms (GAs)** to evolve walking/running gaits. Instead of a human engineer designing the motor commands, the robot's gait is represented as a set of parameters (e.g., phase offsets between leg joints, step height, cycle time). The GA:

1. Creates a population of random gaits
2. Tests each on the robot (or in simulation)
3. The best (fastest, most stable) gaits are selected
4. They're combined (crossover) and mutated to create the next generation
5. Repeat until an effective gait emerges

_Key advantage_: The GA can find gaits that humans would never think of, optimized for the robot's specific physical characteristics (mass distribution, friction, motor limits). The evolved gait is _embodied_ — it's tuned to this physical body, not a theoretical model.

</details>

### neurooscillator-based locomotion generation

<https://aloen.to/AI/EI/EI-%E7%94%9F%E7%89%A9%E5%90%AF%E5%8F%91/#Neurooscillator-based-Locomotion-Generation>

<details>

**Central Pattern Generators (CPGs)** are neural circuits that produce rhythmic outputs without sensory feedback. In animals, CPGs control walking, swimming, flying — the rhythmic alternation of left/right, flexor/extensor muscles.

Robots implement **neurooscillator-based locomotion** using coupled nonlinear oscillators (e.g., **Matsuoka oscillators** or **Hopf oscillators**). Each joint has an oscillator; oscillators are coupled with specific phase relationships (e.g., left hip leads right hip by 180° for walking).

_Math_: A simple CPG neuron model:
$$\tau \dot{x}_i = -x_i + \sum_j w_{ij} f(x_j) + I_i$$
where $x_i$ is the oscillator state, $w_{ij}$ are coupling weights, $f$ is a sigmoid function, and $I_i$ is the drive input.

_Key advantage_: CPGs produce **smooth, coordinated, energy-efficient** locomotion. By adjusting the oscillator parameters (frequency, amplitude, coupling), the robot can smoothly transition between gaits (walk → trot → run) without discrete mode switching.

</details>

### evolving a sensory-motor interconnection structure

<https://aloen.to/AI/EI/EI-%E7%94%9F%E7%89%A9%E5%90%AF%E5%8F%91/#Evolving-a-sensory-motor-interconnection-structure>

<details>

Instead of hand-designing how sensors connect to motors (as in Braitenberg vehicles), **evolutionary robotics** can _evolve the interconnection structure_. A neural network (the "controller") is represented as a genome — a list of neurons and the weighted connections between them.

The GA evolves:

- Which sensors connect to which neurons
- Which neurons connect to which motors
- The connection weights
- Whether connections are excitatory (+) or inhibitory (-)

_Example_: A hexapod robot's leg coordination can be evolved. Initially, the legs move randomly. After evolution, they settle into a coordinated tripod gait (legs 1,3,5 move together; legs 2,4,6 move together) — the same gait insects use. The evolving neural network "discovers" this optimal coordination pattern by itself, without the engineer specifying it.

_Key insight_: The evolved neural structure is **matched to the physical body** and the environment. If the environment changes (e.g., lower gravity), re-evolution finds a new optimal structure.

</details>

# Natural Language Processing & Foundation Models

## Tokenization

### Whitespace/whole-word tokenization

<https://aloen.to/AI/NLP/NLP-Tokenization/>

<details>

**Whitespace tokenization** splits text on spaces. It's a simple _baseline_ — not used alone in practice because:

1. Punctuation attached to words (e.g., "tokenize!" should have "tokenize" and "!" as separate tokens)
2. Contractions ("isn't") should be split, but whitespace doesn't help
3. No whitespace in many languages (Chinese, Japanese, Thai)

_Problems_: This produces a **huge vocabulary** (millions of possible word types). Any word not seen in training = **Out-of-Vocabulary (OOV)** — impossible to handle. Modern LLMs never use pure whitespace tokenization.

</details>

### regular expressions

<https://aloen.to/AI/NLP/NLP-Tokenization/#%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F>

<details>

**Regular expressions** define patterns for matching text. They describe **regular languages** in the Chomsky hierarchy — the simplest class of formal languages. Key operators:

- **Concatenation**: `ab` matches "a" followed by "b"
- **Alternation**: `a|b` matches "a" or "b"
- **Kleene star**: `a*` matches zero or more "a"s

_Equivalence_: A language is regular **iff** there exists a **Finite State Automaton (FSA)** that accepts it (Kleene's theorem). This means regex patterns can be matched in **O(n)** time.

_Limitation_: Regular languages cannot handle nested structures (like balanced parentheses or HTML tags) — that requires **context-free grammars**. The simple language $\{ww | w \in \{a,b\}^*\}$ is NOT regular.

_Extensions that break regularity_: **Backreferences** (e.g., `(?P<a>[ab]*)(?P=a)` for the twin-string language) add computational power beyond regular languages.

</details>

### edit distance

<https://aloen.to/AI/NLP/NLP-Tokenization/#%E7%BC%96%E8%BE%91%E8%B7%9D%E7%A6%BB>

<details>

**Edit distance** measures how similar two strings are by counting the minimum operations to transform one into the other. The most famous variant is **Levenshtein distance** with three operations:

- **Insert**: add a character (cost 1)
- **Delete**: remove a character (cost 1)
- **Substitute**: replace one character with another (cost 1)

_Applications_: Spell checking ("appple" → "apple"), fuzzy string matching, **WER (Word Error Rate)** for ASR evaluation.

_Limitation_: Simple edit distance doesn't account for transpositions (swapping two adjacent letters) — **Damerau-Levenshtein** adds this operation. Also doesn't capture phonetic similarity ("knight" vs "nite").

</details>

### subword tokenization

<https://aloen.to/AI/NLP/NLP-Tokenization/#%E5%AD%90%E8%AF%8D%E5%88%86%E8%AF%8D>

<details>

**Subword tokenization** is the current standard for LLMs. Instead of splitting into whole words, it splits into **frequently occurring subword units**. Key properties:

- **Fixed vocabulary size** (typically 30K-100K tokens)
- **No OOV words** — any unknown word can be represented as subword pieces
- **Language-independent** — works for any writing system
- **Morphologically aware** — boundaries often align with meaningful subword boundaries (e.g., "un" + "related")

_Examples_:

- "unrelated" → ["un", "related"] or ["unrelate", "d"]
- "tokenization" → ["token", "ization"]

Three main algorithms: **BPE** (Byte Pair Encoding), **WordPiece**, **Unigram LM**.

</details>

### Byte Pair Encoding

<https://aloen.to/AI/NLP/NLP-Tokenization/#%E5%AD%97%E8%8A%82%E5%AF%B9%E7%BC%96%E7%A0%81-BPE>

<details>

**Byte Pair Encoding (BPE)** was originally a compression algorithm adapted for tokenization. The process:

1. Start with a vocabulary of individual characters
2. Count all adjacent pairs of tokens in the training corpus
3. Merge the **most frequent pair** (e.g., "t" + "h" → "th")
4. Add the merged pair to the vocabulary
5. Repeat until reaching the desired vocabulary size (e.g., 32K merges)

_The result_: A **merge list** (ordered by frequency) and a **vocabulary** of characters + merged subwords. To tokenize new text, apply the merges in order from first to last.

_WordPiece_ is a variant that selects merges based on: $\frac{freq(AB)}{freq(A) \times freq(B)}$ — this prefers pairs whose co-occurrence is higher than expected by chance. _MaxMatch_ algorithm is used for decoding.

_SentencePiece_ is another variant that handles raw text **without any pre-tokenization** — it operates on the raw character stream including spaces, making it truly language-independent.

</details>

## Language modeling

<https://aloen.to/AI/NLP/NLP-NGram-LM/#%E8%AF%AD%E8%A8%80%E6%A8%A1%E5%9E%8B>

<details>

A **Language Model (LM)** assigns a probability $P(\langle w_1, \dots, w_n \rangle)$ to any sequence of tokens — it says how "likely" a sentence is. This probability distribution over all possible token sequences makes it a _generative_ model of language.

Two key tasks: (1) **assign probability** to existing text (evaluation/ranking), (2) **generate new text** by sampling from the conditional distribution.

</details>

### The goal of a language model

<https://aloen.to/AI/NLP/NLP-NGram-LM/#%E4%B8%BA%E4%BB%80%E4%B9%88%E8%AF%AD%E8%A8%80%E6%A8%A1%E5%9E%8B%E6%9C%89%E7%94%A8%EF%BC%9F>

<details>

The goal of an LM is to model the probability distribution over token sequences. Why is this useful?

1. **Spelling & grammar checking**: "I ate an apple" should have higher probability than "I ate a apple"
2. **Predictive text input**: Suggesting the next word as you type
3. **Speech-to-text**: Disambiguating homophones — "I see the sea" → the LM assigns higher probability to the correct word sequence
4. **Machine translation**: Ranking candidate translations by their fluency
5. **Text generation**: Sampling plausible continuations

_Core formula_: Using the **chain rule of probability**:
$$P(w_1, \dots, w_n) = P(w_1) \cdot P(w_2|w_1) \cdot P(w_3|w_1,w_2) \cdot \ldots \cdot P(w_n|w_1,\dots,w_{n-1})$$

</details>

### continuation probabilities

<https://aloen.to/AI/NLP/NLP-NGram-LM/#%E4%BD%BF%E7%94%A8%E8%BF%9E%E7%BB%AD%E6%A6%82%E7%8E%87%E5%BB%BA%E6%A8%A1>

<details>

**Continuation probabilities** are the building blocks of any LM: $P(w_i | w_1, \dots, w_{i-1})$ — given the history, what's the probability of the next word?

Using the **chain rule**, the probability of a whole sequence is the product of all continuation probabilities:

$$P(w_1, \dots, w_n) = \prod_{i=1}^n P(w_i | w_1, \dots, w_{i-1})$$

The challenge: estimating $P(w_i | w_1, \dots, w_{i-1})$ directly from counts is impossible for long histories (data sparsity). This leads to the **Markov assumption** — approximate using only the last $k$ words.

</details>

### start and end tokens

<https://aloen.to/AI/NLP/NLP-NGram-LM/#%E8%B5%B7%E5%A7%8B%E5%92%8C%E7%BB%93%E6%9D%9F%E7%AC%A6%E5%8F%B7>

<details>

**Special tokens** $\langle s \rangle$ (start) and $\langle /s \rangle$ (end) are added to the vocabulary to handle sequence boundaries uniformly.

Without them, the chain rule formula requires separate handling of the _first word_ (no history) and the _last word_ (doesn't account for ending). With start/end tokens:

$$P(\langle s \rangle, w_1, \dots, w_n, \langle /s \rangle) = P(w_1|\langle s \rangle) \cdot P(w_2|\langle s \rangle,w_1) \cdot \ldots \cdot P(\langle /s \rangle | \langle s \rangle, w_1, \dots, w_n)$$

Now every probability is **conditional** — no special cases. The model learns to predict the end token to "know" when to stop generating.

</details>

### Markov assumptions in N-gram models

<https://aloen.to/AI/NLP/NLP-NGram-LM/#%E9%A9%AC%E5%B0%94%E5%8F%AF%E5%A4%AB%E8%AF%AD%E8%A8%80%E6%A8%A1%E5%9E%8B>

<details>

The **Markov assumption** simplifies language modeling: assume the next word depends only on the **last $N-1$ words**, not the full history.

$$P(w_i | w_1, \dots, w_{i-1}) \approx P(w_i | w_{i-N+1}, \dots, w_{i-1})$$

**N-gram models** with various N:

- **Unigram** (N=1): $P(w_1, \dots, w_n) = \prod P(w_i)$ — completely ignores word order. The most probable "sentence" is just the most frequent words repeated.
- **Bigram** (N=2): $P(w_i|w_{i-1})$ — only the immediately preceding word matters.
- **Trigram** (N=3): $P(w_i|w_{i-2}, w_{i-1})$ — two words of context.

_Problems with larger N_: **Data sparsity** — longer n-grams are rarer in the training corpus, making probability estimates unreliable. The Google N-gram corpus shows: 13M unigrams, 314M bigrams, 977M trigrams. Model size explodes.

_Solution_: **Smoothing** — techniques like add-δ smoothing, interpolation, and Kneser-Ney smoothing redistribute probability mass to unseen n-grams.

</details>

### LM evaluation

<https://aloen.to/AI/NLP/NLP-NGram-LM/#%E8%AF%84%E4%BC%B0>

<details>

Language models are evaluated **intrinsically** or **extrinsically**:

**Intrinsic: Perplexity (PPL)** — the gold standard. For a test sequence $\mathbf{w}$:

$$PP_{\mathcal{M}}(\mathbf{w}) = \sqrt[n]{\frac{1}{P_{\mathcal{M}}(\mathbf{w})}}$$

This is the **inverse geometric mean of per-word probabilities**. Lower perplexity = better model.

Using the chain rule:
$$PP = \sqrt[n]{\prod_{i=1}^n \frac{1}{P(w_i|history)}}$$

Perplexity can also be expressed as **cross-entropy**:
$$-\frac{1}{n} \sum \log P(w_i|history)$$

_Intuition_: If perplexity = 100, the model is as "perplexed" on average as if it had to choose uniformly among 100 next words.

**Extrinsic evaluation**: Measure the LM's performance in a downstream task (spell-checking, ASR word error rate, translation BLEU score). This is more application-relevant but task-dependent.

</details>

## Transformer-based Language Models

### The bottleneck problem of RNNs

<https://aloen.to/AI/NLP/NLP-RNNs/#RNN-%E8%AE%AD%E7%BB%83%E6%8C%91%E6%88%98>

<details>

**RNNs (Recurrent Neural Networks)** process sequences step by step, updating a hidden state: $h_t = a_h(U x_t + W h_{t-1} + b_h)$. They can theoretically handle arbitrary-length sequences.

_But three major problems_:

1. **Vanishing/Exploding Gradients**: During **Backpropagation Through Time (BPTT)**, the gradient is multiplied by the same weight matrix $W$ at each time step. If $|W| < 1$, gradients vanish exponentially (can't learn long-distance dependencies). If $|W| > 1$, gradients explode (training diverges).

2. **Sequential processing**: Each step must wait for the previous step's hidden state. This prevents **parallelization** during training — the whole sequence must be processed step by step.

3. **Fixed-size bottleneck**: The entire past must be compressed into a single fixed-size hidden state vector. Information inevitably gets lost.

_LSTMs partially fix vanishing gradients_ via **gated additive updates** (the cell state acts as a conveyor belt), but the sequential bottleneck remains. Transformers solve this by allowing **direct attention** between any pair of positions — no sequential bottleneck, no vanishing gradient.

</details>

### Multi-head attention

<https://aloen.to/AI/NLP/NLP-Transformers/#%E5%A4%9A%E5%A4%B4%E6%B3%A8%E6%84%8F%E5%8A%9B>

<details>

**Multi-head attention** runs multiple attention mechanisms in parallel. Each "head" can focus on different aspects of the input (e.g., one head learns syntax, another learns semantics, another learns positional relationships).

_Why multiple heads?_ Single attention computes one weighted combination — it mixes everything together. Multi-head attention computes **multiple weighted combinations** in parallel, each from a different learned perspective.

Each head has its own **$W_Q, W_K, W_V$** matrices. The outputs of all heads are concatenated and projected back to the model dimension. This allows the model to represent different types of relationships simultaneously.

$$MultiHead(Q, K, V) = Concat(head_1, \dots, head_h) W_O$$

_Typical setup_: 8-16 heads, each operating on a 64-dimensional subspace of a 512-dim model.

</details>

### Transformers

<https://aloen.to/AI/NLP/NLP-Transformers/#Transformer-%E6%A8%A1%E5%9D%97>

<details>

The **Transformer** is a neural architecture based entirely on **attention mechanisms** (no recurrence). The building block — a **Transformer block** — contains:

1. **Self-attention layer**: Each position can directly attend to every other position. Computes: $Attention(Q, K, V) = softmax(QK^T/\sqrt{d_k})V$

2. **Feed-forward network (FFN)**: Two linear layers with a ReLU activation in between. Applied independently to each position.

3. **Residual connections + Layer Normalization**: Around each sub-layer.

_Two variants_:

- **Encoder**: $N$ layers of bidirectional self-attention. Each position sees ALL positions (left + right). Used for understanding/encoding tasks (BERT-style).
- **Decoder**: $N$ layers of **masked** self-attention (each position sees only itself and previous positions) + cross-attention (attends to encoder output). Used for generation tasks (GPT-style).

_The full seq2seq Transformer_ stacks an encoder on the input side and a decoder on the output side, with cross-attention connecting them.

</details>

### masking

<https://aloen.to/AI/NLP/NLP-Transformers/#%E6%8E%A9%E7%A0%81>

<details>

**Masking** controls which positions a token can attend to. Two types:

1. **Padding mask**: Prevents attention to padding tokens (added to make sequences the same length in a batch). Those positions don't contain real information — attention to them would corrupt the output.

2. **Look-ahead mask (Causal mask)**: In the decoder, each position can only attend to **itself and previous positions**. This ensures the model can't "cheat" by looking at future tokens during generation. It's a triangular matrix (1 for allowed, -inf for blocked) added to the attention scores before softmax.

$$M_{ij} = \begin{cases} 0 & \text{if } i \geq j \\ -\infty & \text{if } i < j \end{cases}$$

_Encoding-style vs Decoding-style models_:

- **Encoder-style (BERT)**: Bidirectional — no look-ahead mask. For tasks where the full context is available (classification, NER).
- **Decoder-style (GPT)**: Causal mask — unidirectional. For generative tasks (text generation, language modeling).
  </details>

### positional encoding

<https://aloen.to/AI/NLP/NLP-Transformers/#%E5%B5%8C%E5%85%A5%E5%92%8C%E4%BD%8D%E7%BD%AE%E7%BC%96%E7%A0%81>

<details>

Since self-attention is **permutation-invariant** (it computes weighted sums without inherent order), we must inject **position information** explicitly. The original Transformer uses **sinusoidal positional encodings**:

$$PE_{(pos, 2i)} = \sin(pos / 10000^{2i/d_{model}})$$
$$PE_{(pos, 2i+1)} = \cos(pos / 10000^{2i/d_{model}})$$

_Why sinusoids?_

- Each dimension has a different frequency → the encoding is a unique "fingerprint" for each position
- The model can easily learn relative positions: $PE_{pos+k}$ can be expressed as a linear function of $PE_{pos}$
- Unlike learned embeddings, sinusoidal encodings **extrapolate to longer sequences** not seen during training

_Modern alternatives_: Learned positional embeddings (GPT, BERT), Rotary Position Embedding (RoPE — rotates query/key vectors by angle proportional to position, used in Llama), AliBi (adds a bias term proportional to distance).

</details>

### teacher forcing

<https://aloen.to/AI/NLP/NLP-RNNs/#%E8%AE%AD%E7%BB%83>

<details>

**Teacher forcing** is the standard training method for autoregressive models (RNNs, Transformers). During training, at each time step, the model receives the **correct previous token** from the training data as input — not its own prediction.

$$Loss = -\sum_{i=1}^n \log P_{\text{model}}(w_i | w_1^{\text{true}}, \dots, w_{i-1}^{\text{true}})$$

_Why teacher forcing?_ Without it, errors compound: if step 1 predicts the wrong word, steps 2-N will be conditioned on wrong input → huge error accumulation during training.

_Problem_: **Exposure bias**. During training, the model always sees ground truth input. During inference (generation), it must condition on _its own previous predictions_, which may be unlike the clean training data. This mismatch can lead to rapidly degenerating quality during long generations.

_Solutions_:

- **Scheduled sampling**: Gradually reduce the probability of using ground truth, increase probability of using model's own prediction.
- **Differentiable sampling**: Gumbel-softmax reparameterization to make the sampling step differentiable.
  </details>

### self-attention cross-attention

<https://aloen.to/AI/NLP/NLP-Transformers/#%E6%B3%A8%E6%84%8F%E5%8A%9B%E5%B1%82%E7%B1%BB%E5%9E%8B>

<details>

Attention layers are classified by **what the query attends to**:

**Self-attention (intra-attention)**: The query sequence IS the key/value sequence ($X = I$). Each token attends to all other tokens in the _same_ sequence.

- Encoder self-attention: bidirectional (all positions)
- Decoder self-attention: causal (only previous positions + self)
- _Use_: Learning contextual relationships within a sequence.

**Cross-attention (inter-attention)**: The query comes from one sequence (decoder), while keys and values come from a _different_ sequence (encoder output). The decoder queries the encoder's representation.

- _Use_: In seq2seq models (translation, summarization) — the decoder "reads" the encoded input while generating output.

_Formula_: For both types:
$$Attention(Q, K, V) = softmax\left(\frac{QK^T}{\sqrt{d_k}}\right)V$$

The $Q, K, V$ are linear projections of the input with learned matrices $W_Q, W_K, W_V$.

</details>

### properties of the GPT and BERT model families

<https://aloen.to/AI/NLP/NLP-Transformers/#GPT>

<details>

**GPT (Generative Pre-Training)**: A **decoder-only** Transformer trained with a standard **next-token prediction** objective (causal language modeling). Key properties:

- **Unidirectional** (left-to-right only)
- **Autoregressive**: generates one token at a time
- **Zero/few-shot learner**: can perform tasks from prompts alone (no fine-tuning needed)
- **Scaling behavior**: performance improves predictably with model size (scaling laws)

**BERT (Bidirectional Encoder Representations from Transformers)**: An **encoder-only** Transformer trained with:

1. **Masked Language Modeling (MLM)**: Random 15% of input tokens are masked; model predicts them. Allows **bidirectional context** (both left and right).
2. **Next Sentence Prediction (NSP)**: Predict if two sentences are consecutive.

_Key differences_:

| Aspect       | GPT                           | BERT                              |
| ------------ | ----------------------------- | --------------------------------- |
| Architecture | Decoder-only                  | Encoder-only                      |
| Direction    | Unidirectional (left→right)   | **Bidirectional**                 |
| Training     | Next token prediction         | MLM + NSP                         |
| Best for     | Generation, few-shot learning | Understanding, feature extraction |
| Fine-tuning  | Adapter layers or full        | Add classification head           |

_Modern evolution_: **GPT-style models** (decoder-only) have become dominant due to their generality — they can do both generation AND understanding through prompting. Examples: GPT-3, GPT-4, Llama, Mistral.

</details>

## Modern LLM training methods

### Alignment

<https://aloen.to/AI/NLP/NLP-Alignments/#AI-alignment-in-general>

<details>

**Alignment** means ensuring an AI system's behavior matches **human goals and preferences**. A misaligned LLM trained on raw web data (MLE only) can:

1. Generate **harmful** content (dangerous, discriminatory)
2. **Hallucinate** — state false information confidently
3. Fail to actually _try_ to perform the requested task

Two types of misalignment:

- **Outer misalignment**: The specified training objective doesn't match what we want. E.g., maximizing prediction accuracy on web text doesn't capture "be helpful, harmless, honest."
- **Inner misalignment**: Even if the objective is right, the model develops **emergent goals** that don't align with the objective. E.g., a model trained to maximize likes might learn to be sycophantic.
  </details>

### instruction and chat models

<https://aloen.to/AI/NLP/NLP-Alignments/#%E4%B8%8E%E6%8C%87%E4%BB%A4%E8%B7%9F%E9%9A%8F%E7%9A%84%E5%AF%B9%E9%BD%90>

<details>

**Instruction-following models** are base LLMs that have been _aligned_ to follow user instructions. Key alignment methods:

1. **Supervised Fine-Tuning (SFT)**: Fine-tune on a dataset of (instruction, correct response) pairs. The dataset can be:
   - **Manually created** by human annotators
   - **Data aggregated** from existing NLP tasks converted to instruction format (Flan)
   - **Synthetically generated** by LLMs (Self-Instruct: use the model to generate its own training data, filter, repeat)

2. **RLHF (Reinforcement Learning from Human Feedback)**:
   - Start with SFT model
   - Train a **reward model** on human preference comparisons (which response is better?)
   - Fine-tune the SFT model using **PPO** to maximize the reward model's score

3. **DPO (Direct Preference Optimization)**: Eliminates the separate reward model. Directly optimizes the policy from preference data. Simpler, 5-8x less compute, comparable or better results.

_Chat models_ extend instruction following to **multi-turn conversations** by representing the full dialog history in the context.

</details>

### steps and data types of training

<https://aloen.to/AI/NLP/NLP-Alignments/#%E6%8C%87%E4%BB%A4%E6%95%B0%E6%8D%AE%E9%9B%86>

<details>

The typical LLM training pipeline has **three stages**:

**Stage 1: Pre-training** (data: trillions of tokens of web text, books, code)

- Objective: **Next token prediction** (MLE)
- Result: A **base model** that knows language patterns but isn't helpful

**Stage 2: Supervised Fine-Tuning (SFT)** (data: thousands to millions of (instruction, response) pairs)

- Objective: Teach the model to follow instructions
- Data sources: Human-written, task templates (Flan: 62 NLP datasets × 10 templates each), LLM-generated (Self-Instruct)

**Stage 3: RLHF / DPO Alignment** (data: human preference comparisons)

- Objective: Align with human values — helpful, honest, harmless
- Data: Pairs of responses ranked by quality

_Key data insight_: LLM-generated synthetic data (Self-Instruct) improved GPT-3 performance by 33%, approaching InstructGPT's quality, showing that models can bootstrap their own alignment data.

</details>

### quantization

<https://aloen.to/AI/NLP/NLP-ReducedComplexity/#%E9%87%8F%E5%8C%96>

<details>

**Quantization** reduces the precision of model weights from 32-bit/16-bit floating point to lower bit widths (8-bit, 4-bit, even 3-bit). This dramatically reduces memory usage — a 7B parameter model at 16-bit = 14GB, at 4-bit = 3.5GB.

_Challenge_: Simple round-to-nearest quantization works poorly below 8 bits. **GPTQ** (Optimal Brain Quantization) achieves 3-4 bit quantization by:

1. Quantizing weights one row at a time
2. Updating remaining weights to compensate for quantization error
3. Using lazy batch processing for GPU efficiency

_Modern methods_:

- **NormalFloat (NF4)**: Assumes weights follow a normal distribution; allocates quantization levels to equal-probability intervals. Used in QLoRA.
- **AWQ (Activation-Aware Weight Quantization)**: Keeps a small fraction of "important" weights in FP16, based on activation magnitudes. Channels with high activation variance get finer quantization.
  </details>

### distillation

<https://aloen.to/AI/NLP/NLP-ReducedComplexity/#%E8%92%B8%E9%A6%8F>

<details>

**Knowledge Distillation** trains a smaller **student** model to mimic a larger **teacher** model. Instead of training the student on hard labels (0/1), train it on the teacher's **soft probability distribution**, which contains implicit knowledge (e.g., "car" and "truck" are both vehicles, even though only one is the correct answer).

Student loss = **distillation loss** (cross-entropy with teacher's soft targets) + optionally **original task loss** (cross-entropy with ground truth).

_Temperature scaling_: Softmax with temperature $T > 1$ spreads out the probability distribution, revealing more of the teacher's implicit knowledge:
$$p_i = \frac{\exp(z_i/T)}{\sum_j \exp(z_j/T)}$$

**DistilBERT**: BERT-base distilled to half the layers. Achieves 97% of BERT's GLUE performance with 40% fewer parameters and 60% faster inference.

**Switch Transformer distillation**: A 1.6T parameter MoE model distilled to a dense model (80-99% compression) retaining ~30% of the quality improvement.

</details>

### adapters and prompt tuning

<https://aloen.to/AI/NLP/NLP-ReducedComplexity/#%E9%AB%98%E6%95%88%E9%80%82%E5%BA%94>

<details>

**Parameter-Efficient Fine-Tuning (PEFT)** methods adapt LLMs without modifying all weights:

**Adapters**: Small bottleneck modules inserted between transformer layers. The original model weights are frozen. Only adapters (1-3% of original parameters) are trained per task. Bottleneck: project $d$-dim → $m$-dim ($m \ll d$) → back to $d$-dim.

**LoRA (Low-Rank Adaptation)**: Add small rank-decomposition matrices ($r=2$ or $4$) in **parallel** to the attention weight matrices ($W_q, W_k, W_v, W_o$). Unlike adapters, LoRA modules can be **merged** with the frozen weights at inference time — **zero inference latency overhead**.

$$\text{LoRA: } W' = W + BA \quad (B \in \mathbb{R}^{d \times r}, A \in \mathbb{R}^{r \times d})$$

**Prompt Tuning (Prefix Tuning / P-tuning)**: Learn small continuous "virtual tokens" prepended to the input. **Prefix tuning** adds these tokens to **every layer's** input. Prompt tuning adds them only to the input embedding. P-tuning uses an LSTM to generate the soft prompts. All of these require only ~0.1% of the original parameters.

_Intrinsic dimension_: Why do these work? The **intrinsic dimension** of fine-tuning is surprisingly low — you may only need a few hundred parameters (in the right subspace) to achieve 90% of full fine-tuning performance. Larger models have **smaller** intrinsic dimensions!

</details>

## LLM Applications

### base principles of prompt

<https://aloen.to/AI/NLP/NLP-Prompt/#%E4%B8%80%E8%88%AC%E6%8F%90%E7%A4%BA%E8%A7%84%E5%88%99>

<details>

**Prompt engineering** is the art of crafting inputs to get desired outputs from LLMs. General rules:

1. **Be specific and precise**: "Write a formal email" vs "Write an email" — the more detailed, the better.
2. **Specify the audience**: "Explain quantum computing to a 10-year-old" constrains the output appropriately.
3. **Provide context + examples**: Few-shot examples in the prompt guide the model's output format and style.
4. **Specify constraints**: Output format (JSON, bullet points), length (200 words), tone (professional).

_Key sensitivities_: Prompt performance is highly sensitive to:

- **Example selection** (which examples you choose)
- **Example ordering** (order matters — **recency bias**: later examples have more influence)
- **Task phrasing** (minor wording changes can cause large performance swings)
  </details>

### answer engineering

<https://aloen.to/AI/NLP/NLP-Prompt/#%E7%AD%94%E6%A1%88%E5%B7%A5%E7%A8%8B>

<details>

**Answer engineering** optimizes the **mapping from model output to task output**. For classification tasks, the LM outputs tokens that must be mapped to class labels through a **verbalizer** function $v(\cdot)$.

Example: For sentiment classification, the verbalizer maps:

- "positive" → positive sentiment
- "negative" → negative sentiment

_Finding good verbalizers_:

- **Answer paraphrasing**: Start with seed labels, paraphrase to expand candidate mappings
- **Pruning + search**: Score candidates on training data, keep the best

_Output types_:

- **Token**: Single token for classification
- **Span**: Multiple tokens for cloze-style tasks
- **Sentence**: For generation tasks
  </details>

### tooling

<https://aloen.to/AI/NLP/NLP-Tooling/#%E5%B7%A5%E5%85%B7>

<details>

**Langauge model tooling** extends LLMs beyond their training data by giving them access to external tools and APIs:

- **Web search**: Real-time knowledge retrieval
- **Code interpreter**: Execute Python code for calculation, data analysis
- **API calls**: Structured data access (weather, stock prices, calendars)
- **Other LLMs**: Specialized models for specific tasks

The LLM outputs structured commands (JSON) specifying which tool to call and with what parameters. The system executes the tool and feeds the result back into the LLM's context.

</details>

### embedding models

<https://aloen.to/AI/NLP/NLP-Tooling/#%E5%B5%8C%E5%85%A5%E6%A8%A1%E5%9E%8B>

<details>

**Embedding models** convert text into dense vector representations that capture semantic meaning. A good embedding places semantically similar texts close together in vector space.

_Types of embeddings_:

- **TF-IDF**: Sparse, based on term frequency. Simple but loses semantics.
- **Word2Vec/Glove**: Static word-level embeddings. One vector per word regardless of context.
- **Contextual embeddings (BERT, GPT)**: Dynamic — the same word gets different vectors depending on its context. "Bank" in "river bank" ≠ "bank" in "money bank."

_Sentence embeddings_: Extending embeddings to longer text. **Sentence-BERT** uses siamese networks with supervised contrastive learning on NLI (Natural Language Inference) data — pairs of sentences are labeled as similar/dissimilar.

_Modern approach_: **Instruction-tuned embeddings** (Instructor) train a single model to follow instructions about _what kind of embedding_ to produce — enabling multi-task retrieval with a single model.

</details>

### retrieval augmented generation

<https://aloen.to/AI/NLP/NLP-Tooling/#%E6%A3%80%E7%B4%A2%E5%A2%9E%E5%BC%BA%E7%94%9F%E6%88%90>

<details>

**Retrieval-Augmented Generation (RAG)** combines retrieval from an external knowledge base with LLM generation. Steps:

1. **Query formulation**: Convert user question into a search query (potentially with history context)
2. **Retrieval**: Search the knowledge base using **vector similarity** — encode both query and documents into the same embedding space, find nearest neighbors
3. **Document aggregation**: Concatenate or summarize retrieved documents
4. **Answer generation**: Feed query + retrieved context into the LLM with a prompt like:

> "Answer the question using ONLY the provided context."

_Key benefits_: Reduces hallucinations (model answers from actual data), enables knowledge updates (just update the database, no retraining), and sources answers to specific documents.

_Advanced variations_:

- **HyDE (Hypothetical Document Embeddings)**: Generate a "fake" answer first, then use its embedding to retrieve similar real documents.
- **RETRO**: Retrieval is integrated into the transformer architecture via cross-attention — the model natively uses retrieved information during generation.
  </details>

### vector-similarity search

<https://aloen.to/AI/NLP/NLP-Tooling/#%E5%9F%BA%E4%BA%8E%E5%90%91%E9%87%8F%E7%9B%B8%E4%BC%BC%E5%BA%A6%E7%9A%84%E6%90%9C%E7%B4%A2%E6%96%B9%E6%B3%95>

<details>

**Vector similarity search** (also called Approximate Nearest Neighbor, ANN) finds the most similar vectors to a query. Exact search is $O(Nd)$ — too slow for millions of documents.

_ANN methods_:

1. **LSH (Locality-Sensitive Hashing)**: Hash similar vectors into the same bucket with high probability. Search within the bucket only.
2. **KD-tree**: Recursively split the space at the median of the highest-variance dimension. Binary tree search reduces complexity to $O(\log N)$.
3. **Product Quantization**: Split each vector into sub-vectors, quantize each sub-vector independently, store only the quantized code. Memory-efficient distance computation.
4. **HNSW (Hierarchical Navigable Small Worlds)**: Build a multi-layer graph where each layer has links of different "range." Greedy search starts at the top layer (long-range links) and descends to finer layers. **Most widely used** — excellent speed/accuracy trade-off.
   </details>

### ReAct-style agentic systems

<https://aloen.to/AI/NLP/NLP-DialogSystems/#%E4%BB%BB%E5%8A%A1%E5%AF%BC%E5%90%91%E5%AF%B9%E8%AF%9D%E7%B3%BB%E7%BB%9F>

<details>

**ReAct (Reasoning + Acting)** agents combine chain-of-thought reasoning with tool calls. At each step, the agent:

1. **Thinks**: Interprets the user's goal and current state
2. **Reasons**: Plans a sequence of actions (like Chain-of-Thought)
3. **Acts**: Calls an external tool (search, calculator, API)
4. **Observes**: Processes the tool's output
5. **Repeats**: Until the goal is achieved

_AutoGPT implementation_: A 4+1 step loop:

- **Thought**: Interpret situation
- **Reasoning**: CoT to plan
- **Plan**: Specific action sequence
- **Criticism**: Self-evaluate plan
- **Action**: Execute (JSON tool call)

This enables LLMs to perform complex, multi-step tasks like: "Plan a trip" → search flights → search hotels → check calendar → propose itinerary.

</details>

## Multimodal Language Models

### InfoNCE

<https://aloen.to/AI/NLP/NLP-Contrastive/#InfoNCE>

<details>

**InfoNCE (Info Noise Contrastive Estimation)** is the loss function that powers modern contrastive learning. Given a query $q$, one positive key $k^+$, and $M$ negative keys $k^-_i$:

{% raw %}

$$\mathcal{L}_{InfoNCE} = -\log\frac{\exp(S(q, k^+))}{\sum_{i=0}^{M+1}\exp(S(q, k[i]))}$$

{% endraw %}

_Intuition_: This is a softmax-based $(M+1)$-way classification task — "which key among these M+1 is the positive one?" The model must pull $q$ and $k^+$ together while pushing $q$ away from all negatives.

_Why it works_: InfoNCE training causes the model to reconstruct the latent variables behind the data generation process. The model learns the underlying structure of the data without explicit labels.

_Applications_: Word2Vec (Skipgram with negative sampling is a form of NCE), CLIP (contrastive image-text pairs), self-supervised visual learning (contrast augmented views of the same image).

</details>

### CLIP

<https://aloen.to/AI/NLP/NLP-Contrastive/#%E5%AF%B9%E6%AF%94%E5%A4%9A%E6%A8%A1%E6%80%81%E6%96%B9%E6%B3%95>

<details>

**CLIP (Contrastive Language-Image Pre-training)** learns a joint embedding space for images and text using contrastive learning on 400M (image, text) pairs from the web.

_Architecture_:

- **Image encoder**: ResNet or **ViT** (Vision Transformer) — outputs image embedding $E_I$
- **Text encoder**: GPT-2 style Transformer — outputs text embedding $E_T$
- Both embeddings are projected to the same dimensionality via linear projections $W_I, W_T$

_Training_: In each batch of $n$ (image, text) pairs, CLIP computes an $n \times n$ similarity matrix. The diagonal entries (matching pairs) should have high similarity; off-diagonal entries (mismatched pairs) should have low similarity. Loss = $0.5 \times \text{cross-entropy}(\text{columns}) + 0.5 \times \text{cross-entropy}(\text{rows})$.

{% raw %}

$$S_{scaled} = \frac{E_I W_I}{\|E_I W_I\|_{L2}} \cdot \left(\frac{E_T W_T}{\|E_T W_T\|_{L2}}\right)^T \cdot \exp(t)$$

{% endraw %}

_Zero-shot classification_: To classify an image, compute its similarity to text prompts like "a photo of a dog" and "a photo of a cat" — pick the class with highest similarity. No task-specific training data needed.

_Properties_: CLIP embeddings are **multimodal** — they align images and text in a shared semantic space. Use cases: zero-shot classification, image retrieval, conditional generation (DALL-E 2), cross-modal transfer.

</details>

### ViT

<https://aloen.to/AI/NLP/NLP-VisualModels/#%E8%A7%86%E8%A7%89-Transformer-ViT>

<details>

**Vision Transformer (ViT)** applies the Transformer architecture directly to images by treating image patches as tokens.

_How it works_:

1. **Patch embedding**: Split the image into fixed-size patches (e.g., 16×16 pixels). Flatten each patch and project it to the model dimension with a learned linear layer.
2. **Position encoding**: Add learned 1D position embeddings (absolute positions work better than 2D for ViT).
3. **Classification token (CLS)**: A special learnable token prepended to the patch sequence. Its output representation is used for classification.
4. **Transformer encoder**: Standard encoder with multi-head self-attention. Processes patches like a sequence of tokens.

_Why ViT matters_: Pure transformers can match or exceed CNNs on image tasks, especially with sufficient pre-training data. The key insight is that attention between patches can learn spatial relationships just as well as convolution.

\*SWIN Transformer improvement**: **Hierarchical ViT** with**shifted window attention\*\* — local attention windows in one layer, shifted in the next, enabling cross-window information flow. Computational complexity drops from quadratic $O((HW)^2)$ to linear $O(M^2 HW)$ in patch count.

</details>

### tokenization with VQ-VAE and dVAE

<https://aloen.to/AI/NLP/NLP-VisualModels/#%E7%A6%BB%E6%95%A3-VAE>
<https://aloen.to/AI/NLP/NLP-TextImageModels/#DALL-E-dVAE-%E9%87%8D%E5%BB%BA>

<details>

**Visual tokenization** turns images into discrete token sequences — like words — enabling transformers to process images. Key technique: **discrete Variational Autoencoders** (VQ-VAE, dVAE):

**VQ-VAE (Vector Quantized VAE)**:

- **Encoder** maps each image patch to a continuous vector
- **Vector quantization**: Replace each vector with its nearest neighbor in a learned **codebook** (e.g., 8192 entries). The index is the discrete token.
- **Decoder** reconstructs the image from quantized tokens
- Training is non-differentiable → uses **straight-through estimator** (gradients pass through the quantization unchanged)

**dVAE (DALL-E's VAE)**:

- Similar to VQ-VAE but uses **Gumbel-Softmax** for differentiable quantization
- 256×256 image → 32×32 grid of discrete tokens (each from 8192-entry codebook)
- Uses **logit-Laplace distribution** instead of Gaussian for better reconstruction

_Why discrete visual tokens?_ Once images are tokenized, they can be processed exactly like text tokens — enabling **autoregressive image generation** with standard transformer decoders. DALL-E concatenates BPE text tokens + image tokens and trains a causal transformer to predict the next token (text or image).

</details>

### encoder-decoder and prefix decoder visual-language models

<https://aloen.to/AI/NLP/NLP-VisualModels/#%E7%BC%96%E7%A0%81%E5%99%A8-%E8%A7%A3%E7%A0%81%E5%99%A8%E7%9A%84%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88>

<details>

Visual-language models for tasks like image captioning use two main architectures:

**Encoder-Decoder**: A vision encoder (CNN or ViT) processes the image into a representation. A text decoder (Transformer) generates the caption, attending to the encoder output via **cross-attention**.

- Example: TrOCR (OCR model with ViT encoder + text decoder)
- Pro: Clear separation of vision vs language
- Con: Requires paired image-caption data for training

**Prefix Decoder**: A frozen CLIP image encoder + frozen GPT language model, connected by a **small mapping network** (MLP or Transformer) that projects CLIP image embeddings into the GPT's embedding space as "visual prefix tokens".

- Example: ClipCap, CapDec
- Pro: Minimal training (only the mapping network), leverages powerful pre-trained models
- Con: The mapping network is a bottleneck

**CoCa (Contrastive Captioner)**: Combines both approaches by training contrastive + captioning losses simultaneously in a single model, avoiding the need for a separate mapping network.

</details>

## Text-to-image methods

### Autoregressive text-to-image models [DALL-E]

<https://aloen.to/AI/NLP/NLP-TextImageModels/#%E8%87%AA%E5%9B%9E%E5%BD%92%E6%96%B9%E6%B3%95>

<details>

**Autoregressive text-to-image models** (like DALL-E 1) treat image generation as a **sequence prediction problem**, just like language modeling.

_Two-stage training_:

1. **Stage 1 (dVAE)**: Train a discrete VAE to compress 256×256 images into 32×32 token grids (each from an 8192-entry visual vocabulary). This learns a **visual codebook**.
2. **Stage 2 (Autoregressive prior)**: Train a causal transformer to predict the sequence: [BPE text tokens] + [special image tokens] + [image tokens]. The model learns the conditional distribution $P(\text{image tokens} | \text{text tokens})$.

_Attention mechanism_: Text tokens use causal attention. Image tokens use **row + column attention** (efficient 2D attention — each token attends to its entire row and column, plus a 3×3 local window). Transposed column attention reduces computation.

_Generation_: Given a text prompt, the model autoregressively predicts image tokens one by one, then the dVAE decoder reconstructs the image from the token grid.

</details>

### the base principle of diffusion models [graphical models only, no formulas]

<https://aloen.to/AI/NLP/NLP-TextImageModels/#%E6%89%A9%E6%95%A3%E6%96%B9%E6%B3%95>

<details>

**Diffusion models** generate images by learning to **reverse a gradual noising process**.

_Forward process_: Starting with a real image, we repeatedly add small amounts of Gaussian noise over many steps (hundreds to thousands). After enough steps, the image becomes pure random noise — completely unrecognizable. This is a **fixed Markov chain** — we know exactly how to add noise at each step.

_Reverse process_: The model learns to **predict the noise that was added** at each step, and subtract it. Starting from pure random noise, the model iteratively denoises it step by step, gradually revealing a coherent image that matches the text description.

_Visual intuition_: Imagine a sculptor starting with a block of marble (pure noise). At each chisel strike, they remove a small amount of material (remove noise). After many strikes, a detailed statue emerges. The model learns _where_ to chisel at each step, guided by the text prompt.

_Why diffusion is powerful_: Stable training, high-quality outputs, good coverage of the data distribution (no mode collapse like GANs).

</details>

### Latent Diffusion Models

<https://aloen.to/AI/NLP/NLP-TextImageModels/#%E6%BD%9C%E5%9C%A8%E6%89%A9%E6%95%A3>

<details>

**Latent Diffusion Models (LDMs)** like Stable Diffusion run the diffusion process in a **compressed latent space** instead of pixel space.

_Why?_ Pixel space is huge (e.g., 512×512×3 = 786,432 dimensions). Running diffusion here is very slow and computationally expensive. A VAE compresses the image into a much smaller latent space (e.g., 64×64×4 = 16,384 dimensions — 48× smaller).

_Process_:

1. **VAE encoder**: Compress the image into latent representation
2. **Diffusion in latent space**: Add/remove noise in this compact latent space
3. **Text conditioning**: Cross-attention layers in the U-Net denoiser attend to the text embedding (from CLIP or similar)
4. **VAE decoder**: Decompress the denoised latent back to pixel space

_Benefits_: **Much faster** (48× fewer dimensions to process), **lower memory** (can run on consumer GPUs), while maintaining high image quality.

_Classifier-free guidance_: During training, randomly drop the text condition (set to null). At inference, extrapolate between conditional and unconditional predictions:
{% raw %}
$\hat{\epsilon}_\theta = \epsilon_\theta(\text{uncond}) + s \cdot (\epsilon_\theta(\text{cond}) - \epsilon_\theta(\text{uncond}))$
{% endraw %}
, where $s$ controls how strongly the model follows the prompt.

</details>

### Classifier-free guidance

<https://aloen.to/AI/NLP/NLP-TextImageModels/#%E6%97%A0%E5%88%86%E7%B1%BB%E5%99%A8>

<details>

**Classifier-free guidance (CFG)** controls how strongly a diffusion model follows the conditioning signal (e.g., text prompt).

_The idea_: Train the model both **with** and **without** conditioning by randomly dropping the condition during training (e.g., 10% of the time, set the text to empty). At inference:

{% raw %}

$$\hat{\epsilon}_\theta(x_t, y) = \epsilon_\theta(x_t, \emptyset) + s \cdot (\epsilon_\theta(x_t, y) - \epsilon_\theta(x_t, \emptyset))$$

{% endraw %}

where $s$ is the **guidance scale**:

- $s = 1$: Normal conditional generation
- $s > 1$ (e.g., 7.5): Stronger adherence to the prompt (but can reduce diversity)
- $s < 1$: More diverse, less prompt-faithful outputs

_Why "classifier-free"?_ Earlier methods (GLIDE) used a separate classifier to guide the diffusion process:
{% raw %}
$\hat{\epsilon}_\theta(x_t, y) = \epsilon_\theta(x_t, y) + s \sigma_t \nabla_{x_t} \log p_\phi(y|x_t)$
{% endraw %}
. CFG eliminates the need for this extra classifier and its gradients, making the system simpler and often more effective.

</details>

## Speech to text processing

### STT task definition

<https://aloen.to/AI/NLP/NLP-STT/#%E8%AF%AD%E9%9F%B3%E8%BD%AC%E6%96%87%E5%AD%97%E4%BB%BB%E5%8A%A1>

<details>

**Speech-to-Text (STT)** or **Automatic Speech Recognition (ASR)**: Convert acoustic speech signal into written text. Input = audio waveform, output = word sequence (typically without punctuation/capitalization).

_Major challenges_:

1. **Segmentation**: Word boundaries don't align with silence in continuous speech
2. **Ambiguity**: Homophones ("bare" vs "bear") — must be disambiguated by context
3. **Coarticulation**: Adjacent sounds affect each other ("I have to" → "I hafto")
4. **Speaker variability**: Age, gender, accent, emotion all affect acoustics
5. **Lombard effect**: People speak differently in noise (louder, slower) — can't just add noise for data augmentation

_Evaluation_: **Word Error Rate (WER)** = Levenshtein distance (insertions + deletions + substitutions) / reference length.

</details>

### speech signal processing [sampling, Fourier transform, Mel spectrum]

<https://aloen.to/AI/NLP/NLP-STT/#%E8%AF%AD%E9%9F%B3%E4%BF%A1%E5%8F%B7%E5%A4%84%E7%90%86>

<details>

Raw speech is a **continuous analog signal** (air pressure changes → voltage changes). Processing pipeline:

1. **Sampling**: Convert continuous to discrete by measuring the amplitude at regular intervals. Minimum sampling rate for speech: **8 kHz** (covers 100 Hz - 4 kHz, the main speech frequency range). Human speech covers roughly 300 Hz - 8 kHz → typical rate 16 kHz.

2. **Windowing**: Split the signal into overlapping frames (20-40ms, shifted by 10ms). Apply a **Hamming window** to smoothly fade the edges (prevents spectral artifacts).

3. **Fourier Transform**: Convert each window from time domain → **frequency domain** (spectrum) via FFT. Shows which frequencies are present at each time point.

4. **Mel spectrum**: The human ear perceives frequency **logarithmically** — we're more sensitive to low frequencies. The **Mel scale** maps physical frequency to perceived pitch: $mel(f) = 1127 \ln(1 + f/700)$. A **Mel filter bank** (triangular filters spaced on the Mel scale) converts the spectrum to Mel bands.

5. **MFCC (Mel-frequency Cepstral Coefficients)**: Take the log of the Mel spectrum, then apply a second Fourier transform → **cepstrum**. The first 12-13 coefficients capture the spectral envelope (which contains most phonetic information). Delta and double-delta features (first/second derivatives) add dynamic information.

_Modern approach_: Deep learning models (Whisper, Deep Speech) often use **raw log-Mel spectrograms** directly as input, skipping the MFCC step.

</details>

### acoustic modeling

<https://aloen.to/AI/NLP/NLP-STT/#%E8%AF%AD%E9%9F%B3%E5%BB%BA%E6%A8%A1>

<details>

**Acoustic modeling** learns $P(\text{acoustic signal} | \text{word sequence})$ — the probability that a given sound corresponds to a given word/phoneme.

_Classic approach (HMM-GMM)_:

- **Phones** (speech sounds) as the basic unit (40-50 phones in English)
- Each phone modeled by a **3-state HMM** (beginning, middle, end of the phone)
- Emission probabilities modeled by **Gaussian Mixture Models (GMMs)**
- **Context-dependent phones (triphones)**: A phone's acoustics depend on preceding and following phones → hundreds of thousands of triphone states
- **State tying**: Group similar triphone states together (using decision trees) to reduce parameters

_Training pipeline_: Train a monophone model first → align audio → train triphone model → realign → train more complex models. This bootstrapping process is standard in Kaldi ASR.

_Modern approach (Deep Learning)_: Neural networks replace the GMM as the emission probability estimator. An **HMM-ANN hybrid** uses a neural network to estimate $P(\text{state} | \text{acoustic})$, then converts to $P(\text{acoustic} | \text{state})$ using Bayes' rule.

</details>

### combining language models with acoustic models

<https://aloen.to/AI/NLP/NLP-STT/#%E6%B7%BB%E5%8A%A0%E8%AF%AD%E8%A8%80%E6%A8%A1%E5%9E%8B>

<details>

Combining acoustic and language models follows Bayes' rule:

$$ \underset{\mathbf{w}}{\operatorname{argmax}} P(\mathbf{w} | \mathbf{s}) = \underset{\mathbf{w}}{\operatorname{argmax}} P(\mathbf{s} | \mathbf{w}) \cdot P(\mathbf{w}) $$

- **Acoustic model** $P(\mathbf{s} | \mathbf{w})$: How likely is this sound to have been produced by this word sequence?
- **Language model** $P(\mathbf{w})$: How likely is this word sequence in the language?

Since both HMMs and N-gram LMs are based on the Markov assumption, they can be combined into a **single composite HMM** $\mathcal{A} + \mathcal{L}$.

_Decoding_: The Viterbi algorithm finds the most likely state sequence through this composite HMM. But for large-vocabulary continuous speech, the combined HMM is too large for exact Viterbi. **Beam search** prunes low-probability paths to make decoding tractable.

_Modern systems_ (Whisper): End-to-end neural models bypass this explicit combination. A single Transformer encoder-decoder processes log-Mel spectrograms directly into text, learning both acoustic and language modeling jointly from paired audio-text data.

</details>

### connectionist temporal classification

<https://aloen.to/AI/NLP/NLP-DeepSTT/#%E8%BF%9E%E6%8E%A5%E6%97%B6%E5%BA%8F%E5%88%86%E7%B1%BB%E6%8D%9F%E5%A4%B1>

<details>

**Connectionist Temporal Classification (CTC)** solves a fundamental problem: the input (audio frames) and output (text characters) have **different lengths** and **no alignment** between them. CTC computes $P(\text{transcript} | \text{audio})$ without requiring frame-level labels.

_Key idea_: Add a special **blank token** ($\epsilon$) to the output vocabulary. The model outputs a character distribution at every time step. A path is any sequence of characters + blanks. Multiple paths can "collapse" to the same transcript by:

1. Removing consecutive duplicates → "hheelloo" → "helo"
2. Removing blanks → "h_e_l_l_o" → "hello"

$P(\text{transcript} | \text{audio}) = \sum_{\text{all paths that collapse to transcript}} P(\text{path} | \text{audio})$

_Efficient computation_: A **dynamic programming algorithm** (forward-backward, like HMM training) computes this sum in $O(T)$ time, where $T$ is the number of time steps.

_Decoding_: Greedy (pick argmax at each step, then collapse) or beam search (with optional language model integration).

_Deep Speech_ (Baidu, 2014) was the first major end-to-end ASR system using CTC with a deep neural network — no phonemes, no HMMs, no forced alignment needed. Just (audio, text) pairs.

</details>
