#set document(
  title: "Tips y Errores Comunes - Arquitectura",
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
      페이지 #counter(page).display() / #counter(page).final().first()
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
  #text(size: 24pt, weight: "bold")[Arquitectura de Computadoras]
  #v(0.5em)
  #text(size: 18pt)[Tips y Errores Comunes]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    Guia \
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

= What is a Mainframe
A mainframe is a large, high-performance computer used by large 
organizations for critical tasks like processing massive amounts of data
and running business applications

#doubt[
  Mainframes are "Quantum-safe"
  How dificult/expensive is to implement this Quantum-safety in non-mainframe 
  modern systems?
  Are you developing this for other systems within IBM?
][

]

= How Memory is managed in zOS

- Address space: Available for users and applications (1Exabyte). Basically you are telling the user to use as much memory as he wants

- zOS checks periodically if memory can or should be migrated

- Slots and Frames: Maintained by the operating system

= Virtualization

#importante[
  LPAR: Logical Partition is the term in which "subsystems" inside
  Mainframes are called. 

  Mainframes $->$ "Big computers" $->$ Many subsystems with diferent 
  characteristics
]

- CP: Central Procesor

- SAP: System Assist Procesor. (Helps the CP)
- IFL: Integrated Facility for Linux. (More effective for running 
  linux)
- zIIP: IBM z Systems Integrated Information Processor for Linxu.
  Stuff like Java runs on zIIPs, so that the main procesor runs the
  bussines stuff

- IO Adapters - CHIPIDS: Channel Path Identifiers

- Subsystems: LPAR connected to IO Devices


== z/VM partitioning

Manages the virtualization, this is why you can run multiples operating systems inside a Mainframe

= Operating System
Is a collection of programs that manages the resources of the computer

#importante[
  Functions of an OS:
  1. Process Management
  2. Security Management
  3. File Management
  4. Communications Management
  5. Resource Management
  6. Memory Management
]

== Process Management

Possible states of a process:

- New
- Ready
- Running
- Waiting
- Terminated

== Operating Systems running on Mainframes

1. z/OS
2. z/TPF: Transaction Processing Facility (Focused on transactions and 
   logistics)
3. z/VM: It is a type 1 hypervisor, so instead of running it on top of 
   another OS, you can running byitself
4. z/VSE
5. Linux on IBM z: Its Linux for Mainframes
6. KVM on Z: Kernel base Virtual Machine, it is another type 1 
   hypervisor

== z/OS

=== What it offers?

- *High security*
- *Stability*

=== Job

Its a program with a specific set of input and output
Jobs are run in JCL (Job Control Language)

- JES:
  - Recieves Jobs into the operating system
  - Schedules them for processing by z/OS
  - Controls their output

- JCL: Scripting language to instruct how to run jobs once JES is ready


= Sysplex

Its a way of making multiple systems work together

#importante[
  - STP: Server Time Protocol. This is important for syncronization
  - GRS: Global Resource Serialization. For concurrent access
  - XCF: Cross Coupling Facility. Allows the sysplex communicate as a 
    hole
  - Coupling Links: Connect LPARS to processors. Allows direct memory 
    access communicate between sysplex memory and memory of an attached
    system
  - CDS: Contains information related to the parallel sysplex system
]


== Sysplex configurations

Three main ways

1. Monoplex: Used for testing
2. Base Sysplex: Every system has a connection to every other system
3. Parallel Sysplex: Coupling Facility who handles everything


= z/OS Security

For a good security model you need:

- Confidentiality
- Availability
- Integrity


== Transaction Level Security


- Public Key Cryptography

The encryption is made with the Public key and the only key who can
decrypt a message encrypted with that public key is your private key



