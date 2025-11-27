#set document(
  title: "JCL, JES",
  author: "Juan Ignacio Raggio",
)

#set page(
  paper: "a4",
  margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 2cm,
    right: 2cm,
  ),
  numbering: "1",
  number-align: bottom + right,

  header: [
    #set text(size: 9pt, fill: gray)
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [Juan Ignacio Raggio],
      [],
      [#datetime.today().display("[day]/[month]/[year]")]
    )
    #line(length: 100%, stroke: 0.5pt + gray)
  ],

  footer: context [
    #set text(size: 9pt, fill: gray)
    #line(length: 100%, stroke: 0.5pt + gray)
    #v(0.2em)
    #align(center)[
      Pagina #counter(page).display() / #counter(page).final().first()
    ]
  ]
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "es",
  hyphenate: true,
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 0em,
  spacing: 1.2em,
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")

#show heading: it => {
  v(0.5em)
  it
  v(0.3em)
}

#set list(indent: 1em, marker: ("•", "◦", "▪"))
#set enum(indent: 1em, numbering: "1.a.")

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

#show link: underline
// ====================================
// PORTADA
// ====================================

#align(center)[
  #v(1em)
  #text(size: 24pt, weight: "bold")[IBMzOS]
  #v(0.5em)
  #text(size: 18pt)[System programing for Mainframes]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    Note taking file \
    #datetime.today().display("[day]/[month]/[year]")
  ]
  #v(1em)
]

#line(length: 100%, stroke: 1pt)
#v(1em)

// ====================================
// FUNCIONES UTILES
// ====================================

// Funcion para crear una caja de nota/observacion
#let nota(contenido) = {
  block(
    fill: rgb("#E3F2FD"),
    stroke: rgb("#1976D2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1976D2"))[Nota:] #contenido
  ]
}

// Funcion para crear una caja de advertencia
#let importante(contenido) = {
  block(
    fill: rgb("#FFF3E0"),
    stroke: rgb("#F57C00") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#F57C00"))[Importante:] #contenido
  ]
}

// Funcion para crear una caja de error comun
#let error(contenido) = {
  block(
    fill: rgb("#FFEBEE"),
    stroke: rgb("#D32F2F") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#D32F2F"))[Error Comun:] #contenido
  ]
}

// Funcion para crear una caja de tip
#let tip(contenido) = {
  block(
    fill: rgb("#E8F5E9"),
    stroke: rgb("#388E3C") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#388E3C"))[Tip:] #contenido
  ]
}

// Funcion para crear una caja de duda con pregunta y respuesta
#let doubt(pregunta, respuesta) = {
  block(
    fill: rgb("#F3E5F5"),
    stroke: rgb("#7B1FA2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#7B1FA2"), size: 11pt)[Pregunta:]
    #v(0.3em)
    #pregunta
    #v(0.5em)
    #line(length: 100%, stroke: 0.5pt + rgb("#7B1FA2"))
    #v(0.5em)
    #text(weight: "bold", fill: rgb("#7B1FA2"), size: 11pt)[Respuesta:]
    #v(0.3em)
    #respuesta
  ]
}

#nota[
What is a Job?

  A *Job* in z/OS is simply “something you ask the system to do”.  
  Common examples:
  - Compile a COBOL, PL/I, Java, Assembler, or C program
  - Run a production program (a load module)
  - Copy or back up datasets
  - Run DFSMS utilities, IDCAMS, SORT, DB2 loads, etc.
  - Generate daily/weekly/monthly reports
 _In short: one job = one unit of work._
]


= The three things you always deal with

== JCL – Job Control Language

This is the script you write. It tells z/OS exactly:
- What program to run (or which cataloged PROC to use)
- Where the input and output files (datasets) are – these are the DD statements
- How much memory, CPU time, which job class, priority, etc.
- What should happen if a step fails (COND codes, IF/THEN/ELSE)

_Example JCL code:_
```
//PAYJOB   JOB (123456),'MONTHLY PAYROLL',CLASS=A,
//         MSGCLASS=X,NOTIFY=&SYSUID,TIME=1440
//STEP1    EXEC PGM=PAYROLL
//STEPLIB  DD DSN=PROD.LOADLIB,DISP=SHR
//INPUT    DD DSN=PROD.PAYROLL.INPUT,DISP=SHR
//REPORT   DD DSN=PROD.PAYROLL.REPORT(+1),
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(CYL,(50,20),RLSE),
//             DCB=(RECFM=FB,LRECL=133,BLKSIZE=0)
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
```

== JES – Job Entry Subsystem (JES2 or JES3)

JES is the traffic controller. It does three critical things:

+ Accepts every job you submit (from ISPF, TSO, FTP, z/OSMF, NJE, etc.)
+ Stores jobs in internal queues (INPUT → CONVERSION → EXECUTION → OUTPUT → PURGE)
+ Decides when a job runs (based on class, priority, and Workload Manager)
+ Collects and manages all printed output (SYSOUT) on the JES spool

No JES = no jobs as we know them.

== z/OS + Initiators
When JES says “it’s your turn”:
- A WLM-controlled initiator grabs the job from the execution queue
- z/OS creates a new address space
- Executes each STEP defined in your JCL
- Returns the final condition code to JES when the job ends

= Real end-to-end flow

You SUBMIT JCL →  
JES puts it in INPUT queue → conversion → EXECUTION queue →  
Initiator starts it → z/OS runs the steps →  
Job ends → JES collects all SYSOUT → OUTPUT / HARDCOPY queues →  
SYSOUT is displayed, printed, emailed, or purged (depends on MSGCLASS)

= One-line diagram

$ "You submit JCL" -> "JES (receives, queues, schedules)" -> "z/OS (executes)" -> "JES (stores output)" $

