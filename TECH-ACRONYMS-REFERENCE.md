# Tech Acronyms & Terms - Complete Reference

**Purpose:** Master reference for software development terminology
**Audience:** Developers transitioning to professional level
**Usage:** Keep this open while coding, review weekly

---

## Table of Contents

1. [Web Development](#web-development)
2. [Backend & APIs](#backend--apis)
3. [Databases](#databases)
4. [DevOps & Infrastructure](#devops--infrastructure)
5. [Version Control](#version-control)
6. [Cloud Platforms](#cloud-platforms)
7. [AI & Machine Learning](#ai--machine-learning)
8. [Programming Concepts](#programming-concepts)
9. [Security](#security)
10. [Business & Product](#business--product)
11. [Tools & Services](#tools--services)
12. [File Types & Formats](#file-types--formats)

---

## Web Development

### Frontend

| Term | Full Name | Meaning |
|------|-----------|---------|
| **HTML** | HyperText Markup Language | Structure of web pages |
| **CSS** | Cascading Style Sheets | Styling of web pages |
| **JS** | JavaScript | Programming language for web |
| **TS** | TypeScript | JavaScript with type safety |
| **JSX** | JavaScript XML | JavaScript syntax extension (React) |
| **TSX** | TypeScript XML | TypeScript with JSX |
| **DOM** | Document Object Model | Tree structure of HTML |
| **SPA** | Single Page Application | Web app that loads once, updates dynamically |
| **SSR** | Server-Side Rendering | HTML generated on server |
| **CSR** | Client-Side Rendering | HTML generated in browser |
| **SSG** | Static Site Generation | HTML pre-built at build time |
| **ISR** | Incremental Static Regeneration | Rebuild static pages on-demand |
| **PWA** | Progressive Web App | Web app that works offline |
| **UI** | User Interface | Visual elements users interact with |
| **UX** | User Experience | Overall experience using product |
| **A11Y** | Accessibility | Making apps usable for everyone (11 letters between A and Y) |
| **I18N** | Internationalization | Supporting multiple languages (18 letters) |
| **L10N** | Localization | Adapting for specific regions (10 letters) |
| **SEO** | Search Engine Optimization | Making sites rank well in Google |
| **CMS** | Content Management System | System to manage website content |
| **CTA** | Call To Action | Button/link prompting user action |
| **AJAX** | Asynchronous JavaScript and XML | Update page without reload |
| **CORS** | Cross-Origin Resource Sharing | Allow requests from different domains |
| **CRUD** | Create, Read, Update, Delete | Basic database operations |
| **DX** | Developer Experience | How pleasant it is to develop |
| **HMR** | Hot Module Replacement | Update code without page reload |

### Frameworks & Libraries

| Term | Meaning |
|------|---------|
| **React** | JavaScript library for building UIs (Facebook) |
| **Vue** | Progressive JavaScript framework |
| **Angular** | Full-featured framework (Google) |
| **Svelte** | Compiler-based framework |
| **Next.js** | React framework with SSR/SSG (Vercel) |
| **Nuxt** | Vue framework with SSR/SSG |
| **Remix** | Full-stack React framework |
| **Gatsby** | Static site generator (React) |
| **Astro** | Multi-framework static site builder |
| **jQuery** | JavaScript library (legacy, avoid) |
| **Tailwind CSS** | Utility-first CSS framework |
| **Bootstrap** | CSS component library |
| **Material UI** | React UI library (Google design) |
| **shadcn/ui** | Copy-paste UI components |
| **Chakra UI** | Modular component library |

---

## Backend & APIs

### General

| Term | Full Name | Meaning |
|------|-----------|---------|
| **API** | Application Programming Interface | Way for programs to communicate |
| **REST** | Representational State Transfer | API architecture style (HTTP methods) |
| **GraphQL** | Graph Query Language | Query language for APIs (Facebook) |
| **RPC** | Remote Procedure Call | Execute functions on remote servers |
| **gRPC** | Google Remote Procedure Call | High-performance RPC framework |
| **tRPC** | TypeScript RPC | End-to-end typesafe APIs |
| **SDK** | Software Development Kit | Tools to build for a platform |
| **CLI** | Command Line Interface | Text-based program interface |
| **GUI** | Graphical User Interface | Visual program interface |
| **REPL** | Read-Eval-Print Loop | Interactive programming environment |
| **CRUD** | Create, Read, Update, Delete | Basic data operations |
| **MVC** | Model-View-Controller | Software architecture pattern |
| **ORM** | Object-Relational Mapping | Database abstraction layer |
| **JWT** | JSON Web Token | Compact way to transmit data securely |
| **OAuth** | Open Authorization | Authorization framework |
| **SAML** | Security Assertion Markup Language | Enterprise authentication standard |
| **SSO** | Single Sign-On | One login for multiple apps |
| **2FA** | Two-Factor Authentication | Extra security layer |
| **MFA** | Multi-Factor Authentication | Multiple verification methods |
| **RBAC** | Role-Based Access Control | Permissions based on roles |
| **ACL** | Access Control List | List of permissions |
| **CORS** | Cross-Origin Resource Sharing | Cross-domain API requests |
| **CSRF** | Cross-Site Request Forgery | Security attack type |
| **XSS** | Cross-Site Scripting | Inject malicious scripts |
| **SQL** | Structured Query Language | Database query language |
| **NoSQL** | Not Only SQL | Non-relational databases |

### HTTP

| Term | Meaning |
|------|---------|
| **HTTP** | Protocol for web communication |
| **HTTPS** | Secure HTTP (encrypted) |
| **GET** | Retrieve data |
| **POST** | Send data |
| **PUT** | Update/replace data |
| **PATCH** | Partially update data |
| **DELETE** | Remove data |
| **HEAD** | GET without body |
| **OPTIONS** | Check available methods |
| **200** | OK - Success |
| **201** | Created |
| **204** | No Content |
| **400** | Bad Request |
| **401** | Unauthorized |
| **403** | Forbidden |
| **404** | Not Found |
| **500** | Internal Server Error |
| **502** | Bad Gateway |
| **503** | Service Unavailable |

### Backend Frameworks

| Term | Language | Use Case |
|------|----------|----------|
| **Express** | Node.js | Most popular Node framework |
| **Fastify** | Node.js | Faster Express alternative |
| **NestJS** | Node.js/TS | Enterprise-grade framework |
| **FastAPI** | Python | Modern async Python framework |
| **Django** | Python | Full-featured web framework |
| **Flask** | Python | Lightweight Python framework |
| **Rails** | Ruby | Full-stack framework |
| **Laravel** | PHP | Modern PHP framework |
| **Fiber** | Go | Express-inspired Go framework |
| **Gin** | Go | Fast Go web framework |
| **Spring Boot** | Java | Enterprise Java framework |

---

## Databases

### Types

| Term | Full Name | Type | Use Case |
|------|-----------|------|----------|
| **SQL** | Structured Query Language | Relational | Structured data, transactions |
| **NoSQL** | Not Only SQL | Various | Flexible schemas, scale |
| **RDBMS** | Relational Database Management System | Relational | Traditional databases |
| **Document DB** | Document Database | NoSQL | JSON-like documents |
| **Key-Value** | Key-Value Store | NoSQL | Simple lookups |
| **Graph DB** | Graph Database | NoSQL | Relationships |
| **Time Series** | Time Series Database | Specialized | Time-stamped data |
| **Vector DB** | Vector Database | Specialized | AI embeddings |

### Specific Databases

| Database | Type | Best For |
|----------|------|----------|
| **PostgreSQL** | SQL | General purpose, most powerful |
| **MySQL** | SQL | Web apps, WordPress |
| **SQLite** | SQL | Embedded, local storage |
| **MongoDB** | NoSQL (Document) | Flexible schemas |
| **Redis** | NoSQL (Key-Value) | Caching, sessions |
| **Cassandra** | NoSQL (Wide-column) | Massive scale |
| **DynamoDB** | NoSQL (Key-Value) | AWS serverless |
| **Firestore** | NoSQL (Document) | Firebase real-time |
| **Supabase** | SQL (PostgreSQL) | Open-source Firebase alternative |
| **PlanetScale** | SQL (MySQL) | Serverless MySQL |
| **Neon** | SQL (PostgreSQL) | Serverless Postgres |
| **Pinecone** | Vector | AI similarity search |
| **Weaviate** | Vector | AI knowledge graphs |

### Database Terms

| Term | Meaning |
|------|---------|
| **Table** | Collection of rows (SQL) |
| **Collection** | Collection of documents (NoSQL) |
| **Row** | Single record (SQL) |
| **Document** | Single record (NoSQL) |
| **Column** | Field in a table |
| **Field** | Property in a document |
| **Primary Key** | Unique identifier for row |
| **Foreign Key** | Reference to another table |
| **Index** | Speed up queries |
| **Schema** | Database structure definition |
| **Migration** | Database structure change |
| **Transaction** | Group of operations (all or nothing) |
| **ACID** | Atomicity, Consistency, Isolation, Durability |
| **Normalization** | Organize data to reduce redundancy |
| **Denormalization** | Duplicate data for performance |
| **Sharding** | Split database across servers |
| **Replication** | Copy database for redundancy |
| **Backup** | Copy of database |
| **Restore** | Recover from backup |

---

## DevOps & Infrastructure

### Core Concepts

| Term | Full Name | Meaning |
|------|-----------|---------|
| **DevOps** | Development + Operations | Culture of dev/ops collaboration |
| **CI** | Continuous Integration | Automatically test code changes |
| **CD** | Continuous Deployment | Automatically deploy code |
| **CI/CD** | Continuous Integration/Deployment | Automated pipeline |
| **IaC** | Infrastructure as Code | Manage infrastructure via code |
| **GitOps** | Git Operations | Manage infrastructure via Git |
| **VM** | Virtual Machine | Emulated computer |
| **Container** | Containerization | Isolated application environment |
| **Docker** | - | Container platform |
| **K8s** | Kubernetes | Container orchestration |
| **Pod** | - | Smallest deployable K8s unit |
| **Cluster** | - | Group of connected computers |
| **Node** | - | Single machine in cluster |
| **Load Balancer** | - | Distribute traffic across servers |
| **Reverse Proxy** | - | Server in front of other servers |
| **CDN** | Content Delivery Network | Distribute content globally |
| **DNS** | Domain Name System | Convert domains to IPs |
| **SSL** | Secure Sockets Layer | Encryption (deprecated, use TLS) |
| **TLS** | Transport Layer Security | Modern encryption |
| **VPN** | Virtual Private Network | Secure network connection |
| **VPC** | Virtual Private Cloud | Isolated cloud network |
| **Subnet** | Subnetwork | Portion of a network |
| **Firewall** | - | Network traffic filter |
| **DDoS** | Distributed Denial of Service | Overwhelm with traffic |
| **WAF** | Web Application Firewall | Protect web apps |

### Deployment

| Term | Meaning |
|------|---------|
| **Build** | Compile/package code |
| **Deploy** | Release code to servers |
| **Rollback** | Revert to previous version |
| **Blue-Green** | Deploy to duplicate environment |
| **Canary** | Gradual rollout to users |
| **A/B Testing** | Test two versions |
| **Hot Fix** | Urgent bug fix |
| **Staging** | Pre-production environment |
| **Production** | Live environment |
| **Environment** | Where code runs (dev/staging/prod) |
| **Artifact** | Built output (compiled code) |
| **Registry** | Storage for artifacts |
| **Orchestration** | Automated container management |
| **Scaling** | Add/remove resources |
| **Horizontal Scaling** | Add more servers |
| **Vertical Scaling** | Make server bigger |
| **Auto-scaling** | Automatic resource adjustment |
| **Serverless** | Run code without managing servers |
| **FaaS** | Function as a Service (serverless) |
| **PaaS** | Platform as a Service |
| **IaaS** | Infrastructure as a Service |
| **SaaS** | Software as a Service |

### Monitoring

| Term | Full Name | Meaning |
|------|-----------|---------|
| **APM** | Application Performance Monitoring | Track app performance |
| **Logging** | - | Record application events |
| **Metrics** | - | Numerical measurements |
| **Traces** | - | Request path through system |
| **Alerts** | - | Notifications for issues |
| **Dashboard** | - | Visual data display |
| **Uptime** | - | Time service is available |
| **Downtime** | - | Time service is unavailable |
| **SLA** | Service Level Agreement | Guaranteed uptime |
| **SLO** | Service Level Objective | Target reliability |
| **SLI** | Service Level Indicator | Actual measurements |
| **MTBF** | Mean Time Between Failures | Average working time |
| **MTTR** | Mean Time To Recovery | Average fix time |
| **RCA** | Root Cause Analysis | Find core problem |
| **Incident** | - | Service disruption |
| **Postmortem** | - | Analysis after incident |

---

## Version Control

### Git Basics

| Term | Meaning |
|------|---------|
| **Git** | Distributed version control system |
| **GitHub** | Git hosting platform (Microsoft) |
| **GitLab** | Git hosting platform (DevOps focused) |
| **Bitbucket** | Git hosting platform (Atlassian) |
| **Repository (Repo)** | Project folder tracked by Git |
| **Clone** | Copy repository to your machine |
| **Fork** | Copy someone else's repo to your account |
| **Commit** | Save changes with message |
| **Push** | Send commits to remote |
| **Pull** | Get commits from remote |
| **Fetch** | Download commits without merging |
| **Branch** | Separate line of development |
| **Merge** | Combine branches |
| **Rebase** | Reapply commits on top of another branch |
| **Cherry-pick** | Apply specific commit to branch |
| **Stash** | Temporarily save uncommitted changes |
| **Tag** | Mark specific commit (usually version) |
| **Remote** | Repository on server |
| **Origin** | Default remote name |
| **Upstream** | Original repo (when forked) |
| **HEAD** | Current commit pointer |
| **Master/Main** | Primary branch |
| **Conflict** | Competing changes to same code |
| **Diff** | Differences between commits |

### GitHub/GitLab

| Term | Meaning |
|------|---------|
| **PR** | Pull Request (propose changes) |
| **MR** | Merge Request (GitLab term for PR) |
| **Issue** | Bug report or feature request |
| **Milestone** | Group of issues/PRs |
| **Label** | Tag for issues/PRs |
| **Assignee** | Person responsible |
| **Reviewer** | Person who reviews code |
| **CI/CD** | Automated testing/deployment |
| **Actions** | GitHub's CI/CD |
| **Workflow** | Automated process |
| **Runner** | Machine that runs CI/CD |
| **Artifact** | File produced by CI/CD |
| **Secret** | Encrypted environment variable |
| **Gist** | Code snippet sharing |
| **Wiki** | Documentation |
| **Pages** | Static site hosting |
| **Release** | Version distribution |

---

## Cloud Platforms

### AWS (Amazon Web Services)

| Service | Purpose |
|---------|---------|
| **EC2** | Virtual servers |
| **S3** | Object storage |
| **RDS** | Managed databases |
| **Lambda** | Serverless functions |
| **CloudFront** | CDN |
| **Route 53** | DNS |
| **VPC** | Virtual network |
| **ECS** | Container service |
| **EKS** | Kubernetes service |
| **IAM** | Identity management |
| **CloudWatch** | Monitoring |
| **SQS** | Message queue |
| **SNS** | Notifications |
| **SES** | Email service |
| **Cognito** | User authentication |
| **DynamoDB** | NoSQL database |
| **ElastiCache** | Redis/Memcached |
| **Secrets Manager** | Store secrets |

### GCP (Google Cloud Platform)

| Service | AWS Equivalent |
|---------|----------------|
| **Compute Engine** | EC2 |
| **Cloud Storage** | S3 |
| **Cloud SQL** | RDS |
| **Cloud Functions** | Lambda |
| **Cloud CDN** | CloudFront |
| **Cloud DNS** | Route 53 |
| **GKE** | EKS |
| **Cloud Run** | Fargate |
| **Firestore** | DynamoDB |
| **Pub/Sub** | SNS/SQS |

### Azure (Microsoft)

| Service | AWS Equivalent |
|---------|----------------|
| **Virtual Machines** | EC2 |
| **Blob Storage** | S3 |
| **Azure SQL** | RDS |
| **Functions** | Lambda |
| **CDN** | CloudFront |
| **AKS** | EKS |
| **Cosmos DB** | DynamoDB |

### Other Platforms

| Platform | Focus |
|----------|-------|
| **Vercel** | Frontend hosting (Next.js) |
| **Netlify** | Static site hosting |
| **Railway** | Full-stack deployment |
| **Render** | Simple cloud platform |
| **Fly.io** | Edge deployment |
| **Cloudflare** | CDN, DNS, security |
| **DigitalOcean** | Simple cloud (droplets) |
| **Linode** | VPS hosting |
| **Heroku** | Easy app deployment (legacy) |

---

## AI & Machine Learning

### General

| Term | Full Name | Meaning |
|------|-----------|---------|
| **AI** | Artificial Intelligence | Machines mimicking human intelligence |
| **ML** | Machine Learning | AI that learns from data |
| **DL** | Deep Learning | ML with neural networks |
| **NN** | Neural Network | Computing system inspired by brain |
| **LLM** | Large Language Model | AI trained on text (GPT, Claude) |
| **GPT** | Generative Pre-trained Transformer | Type of LLM (OpenAI) |
| **NLP** | Natural Language Processing | AI for human language |
| **CV** | Computer Vision | AI for images/video |
| **AGI** | Artificial General Intelligence | Human-level AI (future) |
| **RL** | Reinforcement Learning | Learning by trial and error |
| **Supervised** | - | Learning from labeled data |
| **Unsupervised** | - | Learning from unlabeled data |
| **Training** | - | Teaching AI from data |
| **Inference** | - | Using trained AI |
| **Fine-tuning** | - | Adapt pre-trained model |
| **Prompt** | - | Input to AI model |
| **Token** | - | Piece of text (word/subword) |
| **Embedding** | - | Numerical representation |
| **Vector** | - | Array of numbers |
| **Weights** | - | Model parameters |
| **Bias** | - | Offset in calculations |
| **Epoch** | - | One pass through training data |
| **Batch** | - | Group of training examples |
| **Loss** | - | Measure of error |
| **Gradient** | - | Direction to improve |
| **Backpropagation** | - | Update weights |
| **Overfitting** | - | Memorize instead of learn |
| **Underfitting** | - | Too simple to learn |

### Image Generation

| Term | Meaning |
|------|---------|
| **SD** | Stable Diffusion (AI image model) |
| **SDXL** | Stable Diffusion XL (bigger version) |
| **LoRA** | Low-Rank Adaptation (efficient fine-tuning) |
| **ControlNet** | Control image generation (pose, edges, etc.) |
| **VAE** | Variational Autoencoder (improves quality) |
| **Checkpoint** | Saved model weights |
| **Safetensors** | Safe model file format |
| **Prompt** | Text description |
| **Negative Prompt** | What to avoid |
| **CFG Scale** | How closely to follow prompt |
| **Steps** | Iterations of generation |
| **Sampler** | Algorithm for generation |
| **Seed** | Random number for reproducibility |
| **Upscale** | Increase resolution |
| **Inpainting** | Edit part of image |
| **Outpainting** | Extend image |
| **Img2Img** | Image to image |
| **Txt2Img** | Text to image |

### Platforms & Tools

| Tool | Purpose |
|------|---------|
| **ComfyUI** | Node-based SD workflow |
| **Automatic1111** | SD web UI |
| **Kohya_ss** | LoRA training |
| **Dreambooth** | Personalization technique |
| **Textual Inversion** | Custom concepts |
| **HuggingFace** | AI model repository |
| **Replicate** | AI API platform |
| **Modal** | Serverless GPU compute |
| **RunPod** | GPU cloud platform |
| **Lambda Labs** | GPU instances |

---

## Programming Concepts

### Paradigms

| Term | Meaning |
|------|---------|
| **OOP** | Object-Oriented Programming (classes, objects) |
| **FP** | Functional Programming (pure functions) |
| **Declarative** | What to do (not how) |
| **Imperative** | Step-by-step instructions |
| **Async** | Non-blocking operations |
| **Sync** | Blocking operations |
| **Concurrent** | Multiple tasks at once |
| **Parallel** | Truly simultaneous execution |
| **Reactive** | React to events/data changes |

### Design Patterns

| Pattern | Purpose |
|---------|---------|
| **Singleton** | Only one instance |
| **Factory** | Create objects |
| **Observer** | Subscribe to events |
| **Decorator** | Add functionality |
| **Strategy** | Interchangeable algorithms |
| **MVC** | Model-View-Controller |
| **Repository** | Data access abstraction |
| **Dependency Injection** | Provide dependencies |

### Code Quality

| Term | Full Name | Meaning |
|------|-----------|---------|
| **DRY** | Don't Repeat Yourself | Avoid duplication |
| **KISS** | Keep It Simple, Stupid | Simplicity wins |
| **YAGNI** | You Aren't Gonna Need It | Don't over-engineer |
| **SOLID** | Five OOP principles | Design principles |
| **TDD** | Test-Driven Development | Write tests first |
| **BDD** | Behavior-Driven Development | Tests describe behavior |
| **Refactoring** | - | Improve code structure |
| **Code Smell** | - | Sign of problems |
| **Tech Debt** | Technical Debt | Shortcuts that cost later |
| **Linter** | - | Check code style |
| **Formatter** | - | Auto-format code |
| **Type Safety** | - | Catch type errors |
| **Code Review** | - | Peer review code |

---

## Security

### Authentication & Authorization

| Term | Meaning |
|------|---------|
| **Auth** | Authentication + Authorization |
| **Authentication** | Verify identity (login) |
| **Authorization** | Verify permissions (access) |
| **Session** | Temporary auth state |
| **Cookie** | Small data stored in browser |
| **Token** | Proof of authentication |
| **JWT** | JSON Web Token |
| **OAuth** | Third-party login (Google, etc.) |
| **OIDC** | OpenID Connect (OAuth extension) |
| **SSO** | Single Sign-On |
| **MFA** | Multi-Factor Authentication |
| **TOTP** | Time-based One-Time Password |
| **API Key** | Secret for API access |
| **Bearer Token** | Token in Authorization header |

### Security Concepts

| Term | Full Name | Meaning |
|------|-----------|---------|
| **HTTPS** | HTTP Secure | Encrypted HTTP |
| **SSL/TLS** | - | Encryption protocols |
| **Certificate** | - | Proof of identity (HTTPS) |
| **CORS** | Cross-Origin Resource Sharing | Allow cross-domain requests |
| **CSRF** | Cross-Site Request Forgery | Trick user into action |
| **XSS** | Cross-Site Scripting | Inject malicious code |
| **SQL Injection** | - | Inject malicious SQL |
| **Sanitization** | - | Clean user input |
| **Validation** | - | Check input correctness |
| **Encryption** | - | Scramble data |
| **Hashing** | - | One-way transformation |
| **Salt** | - | Random data for hashing |
| **Rate Limiting** | - | Limit request frequency |
| **DDoS** | Distributed Denial of Service | Overwhelm with traffic |
| **Zero Trust** | - | Never trust, always verify |
| **Penetration Testing** | - | Ethical hacking |
| **Vulnerability** | - | Security weakness |
| **CVE** | Common Vulnerabilities and Exposures | Known vulnerability ID |
| **OWASP** | Open Web Application Security Project | Security standards |

---

## Business & Product

### Metrics

| Term | Full Name | Meaning |
|------|-----------|---------|
| **KPI** | Key Performance Indicator | Important metric |
| **MRR** | Monthly Recurring Revenue | Predictable monthly income |
| **ARR** | Annual Recurring Revenue | Yearly MRR |
| **CAC** | Customer Acquisition Cost | Cost to get customer |
| **LTV** | Lifetime Value | Revenue per customer |
| **Churn** | - | Customers who leave |
| **Retention** | - | Customers who stay |
| **NPS** | Net Promoter Score | Customer satisfaction |
| **DAU** | Daily Active Users | Users per day |
| **MAU** | Monthly Active Users | Users per month |
| **Conversion Rate** | - | % who take action |
| **CTR** | Click-Through Rate | % who click |
| **CPC** | Cost Per Click | Ad pricing model |
| **CPM** | Cost Per Mille (thousand) | Ad pricing (per 1000 views) |
| **ROI** | Return On Investment | Profit vs cost |
| **ROAS** | Return On Ad Spend | Ad profit vs cost |
| **GMV** | Gross Merchandise Value | Total transaction value |
| **Burn Rate** | - | Money spent per month |
| **Runway** | - | Months until money runs out |

### Development

| Term | Full Name | Meaning |
|------|-----------|---------|
| **MVP** | Minimum Viable Product | Simplest version |
| **POC** | Proof of Concept | Feasibility test |
| **Prototype** | - | Early model |
| **Beta** | - | Pre-release testing |
| **Alpha** | - | Very early testing |
| **GA** | General Availability | Public release |
| **Release** | - | Version launch |
| **Sprint** | - | Time-boxed work period |
| **Backlog** | - | List of tasks |
| **Roadmap** | - | Future plans |
| **Tech Stack** | Technology Stack | Technologies used |
| **Monorepo** | Monolithic Repository | One repo for all code |
| **Microservices** | - | Small independent services |
| **Monolith** | - | One big application |

### Roles

| Role | Responsibilities |
|------|------------------|
| **CEO** | Chief Executive Officer - Overall strategy |
| **CTO** | Chief Technology Officer - Tech strategy |
| **CPO** | Chief Product Officer - Product strategy |
| **CFO** | Chief Financial Officer - Finance |
| **CMO** | Chief Marketing Officer - Marketing |
| **COO** | Chief Operating Officer - Operations |
| **PM** | Product Manager - Product features |
| **TPM** | Technical Product Manager - Tech + product |
| **EM** | Engineering Manager - Manage engineers |
| **TL** | Tech Lead - Lead engineers technically |
| **IC** | Individual Contributor - Non-manager |
| **SWE** | Software Engineer - Write code |
| **SRE** | Site Reliability Engineer - Keep systems running |
| **DevOps** | Development Operations - Bridge dev and ops |
| **QA** | Quality Assurance - Test software |
| **UX** | User Experience Designer - Design experience |
| **UI** | User Interface Designer - Design interface |

---

## Tools & Services

### Development Tools

| Tool | Purpose |
|------|---------|
| **IDE** | Integrated Development Environment (VS Code, IntelliJ) |
| **Text Editor** | Simple code editor (Sublime, Vim) |
| **Terminal** | Command-line interface |
| **Shell** | Command interpreter (bash, zsh) |
| **Debugger** | Find and fix bugs |
| **Profiler** | Measure performance |
| **Package Manager** | Install dependencies (npm, pip) |
| **Bundler** | Combine files (webpack, vite) |
| **Transpiler** | Convert code (TypeScript → JavaScript) |
| **Compiler** | Convert to machine code |
| **Interpreter** | Execute code directly |
| **Linter** | Check code style (ESLint, Pylint) |
| **Formatter** | Auto-format code (Prettier) |

### Communication

| Tool | Purpose |
|------|---------|
| **Slack** | Team messaging |
| **Discord** | Community/team chat |
| **Zoom** | Video calls |
| **Meet** | Google video calls |
| **Teams** | Microsoft collaboration |
| **Notion** | Documentation/notes |
| **Confluence** | Enterprise wiki |
| **Jira** | Project management |
| **Linear** | Modern project management |
| **Asana** | Task management |
| **Trello** | Kanban boards |
| **Figma** | Design tool |
| **Miro** | Virtual whiteboard |

### Analytics

| Tool | Purpose |
|------|---------|
| **Google Analytics** | Web analytics |
| **PostHog** | Product analytics |
| **Mixpanel** | User analytics |
| **Amplitude** | Product intelligence |
| **Segment** | Data pipeline |
| **Sentry** | Error tracking |
| **Datadog** | Monitoring |
| **New Relic** | APM |
| **Grafana** | Dashboards |
| **Prometheus** | Metrics |

---

## File Types & Formats

### Code

| Extension | Language/Type |
|-----------|---------------|
| **.js** | JavaScript |
| **.ts** | TypeScript |
| **.jsx** | JavaScript + JSX |
| **.tsx** | TypeScript + JSX |
| **.py** | Python |
| **.go** | Go |
| **.rs** | Rust |
| **.java** | Java |
| **.rb** | Ruby |
| **.php** | PHP |
| **.c** | C |
| **.cpp** | C++ |
| **.cs** | C# |
| **.swift** | Swift |
| **.kt** | Kotlin |
| **.sh** | Shell script |

### Config

| Extension | Purpose |
|-----------|---------|
| **.json** | JSON data |
| **.yaml/.yml** | YAML config |
| **.toml** | TOML config |
| **.env** | Environment variables |
| **.gitignore** | Git ignore rules |
| **.dockerignore** | Docker ignore rules |
| **.editorconfig** | Editor settings |
| **.prettierrc** | Prettier config |
| **.eslintrc** | ESLint config |

### Data

| Extension | Format |
|-----------|--------|
| **.csv** | Comma-separated values |
| **.xml** | eXtensible Markup Language |
| **.sql** | SQL database |
| **.db/.sqlite** | SQLite database |
| **.parquet** | Columnar storage |
| **.arrow** | Apache Arrow |
| **.pkl/.pickle** | Python pickle |

### AI/ML

| Extension | Purpose |
|-----------|---------|
| **.safetensors** | AI model (safe format) |
| **.ckpt** | Checkpoint |
| **.pt/.pth** | PyTorch model |
| **.h5/.hdf5** | Keras model |
| **.onnx** | ONNX model |
| **.pb** | TensorFlow model |
| **.bin** | Binary model |

### Web

| Extension | Purpose |
|-----------|---------|
| **.html** | Web page |
| **.css** | Stylesheet |
| **.scss/.sass** | CSS preprocessor |
| **.less** | CSS preprocessor |
| **.woff/.woff2** | Web fonts |
| **.svg** | Vector graphic |

### Documents

| Extension | Type |
|-----------|------|
| **.md** | Markdown |
| **.txt** | Plain text |
| **.pdf** | Portable Document Format |
| **.doc/.docx** | Microsoft Word |
| **.xls/.xlsx** | Microsoft Excel |
| **.ppt/.pptx** | Microsoft PowerPoint |

---

## Common Phrases & Slang

| Phrase | Meaning |
|--------|---------|
| **Ship it** | Deploy to production |
| **Yak shaving** | Doing many small tasks before main task |
| **Rubber ducking** | Explain problem to solve it |
| **Bikeshedding** | Waste time on trivial decisions |
| **LGTM** | Looks Good To Me (code review) |
| **RTFM** | Read The F***ing Manual |
| **TL;DR** | Too Long; Didn't Read (summary) |
| **IIRC** | If I Recall Correctly |
| **AFAIK** | As Far As I Know |
| **IMO/IMHO** | In My (Humble) Opinion |
| **FYI** | For Your Information |
| **WIP** | Work In Progress |
| **ETA** | Estimated Time of Arrival |
| **EOD** | End of Day |
| **OOO** | Out of Office |
| **ASAP** | As Soon As Possible |
| **Breaking change** | Change that breaks existing code |
| **Hotfix** | Urgent bug fix |
| **Edge case** | Rare scenario |
| **Footgun** | Feature that's easy to misuse |
| **Boilerplate** | Repetitive code |
| **Magic number** | Unexplained constant |
| **Spaghetti code** | Messy code |
| **Code smell** | Bad code indicator |
| **Technical debt** | Shortcuts that cost later |
| **Greenfield** | New project from scratch |
| **Brownfield** | Existing project to maintain |
| **Proof of concept** | Feasibility demo |
| **Minimum viable product** | Simplest version |
| **Dog fooding** | Use your own product |
| **Production** | Live environment |
| **Staging** | Test environment |
| **Sandbox** | Isolated test environment |

---

## How to Use This Guide

**Daily:**
- Keep this open while coding
- Look up unfamiliar terms
- Reference during meetings

**Weekly:**
- Read one section thoroughly
- Practice using terms in conversation
- Update your own notes

**Monthly:**
- Review entire document
- Add terms you encounter
- Remove terms you've mastered

---

## Pro Tips

1. **Don't memorize everything** - Reference as needed
2. **Learn by context** - Use terms in real situations
3. **Ask for clarification** - When someone uses unknown term
4. **Use correctly** - Better to say "I don't know" than misuse
5. **Stay current** - Tech terms evolve

---

**Last Updated:** 2025-11-14
**Maintained By:** Claude Code
**License:** MIT (Share freely!)

---

**Next Steps:**
1. Print the "Common Phrases" section
2. Read one section per day
3. Practice using 5 new terms daily
4. Build your own cheat sheet of terms you use most

Good luck becoming a pro! 🚀
