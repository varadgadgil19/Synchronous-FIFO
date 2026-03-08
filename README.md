# FIFO Design in Verilog

## Overview

This project implements a **parameterized synchronous FIFO (First-In First-Out) memory** using Verilog/SystemVerilog.
The FIFO stores data sequentially and outputs it in the same order it was written. It supports configurable **data width** and **depth**, making the design reusable for different applications.

## Features

* Parameterized **FIFO depth**
* Parameterized **data width**
* **Synchronous read and write operations**
* **Full and Empty status flags**
* Pointer-based circular buffer implementation
* Uses `$clog2()` for automatic pointer width calculation

## Parameters

| Parameter | Description               | Default |
| --------- | ------------------------- | ------- |
| `DEPTH`   | Number of entries in FIFO | 8       |
| `WIDTH`   | Width of each data entry  | 8 bits  |

## Ports

| Port       | Direction | Description             |
| ---------- | --------- | ----------------------- |
| `clk`      | Input     | System clock            |
| `rst`      | Input     | Reset signal            |
| `wr_en`    | Input     | Write enable            |
| `rd_en`    | Input     | Read enable             |
| `data_in`  | Input     | Input data to FIFO      |
| `data_out` | Output    | Data read from FIFO     |
| `full`     | Output    | Indicates FIFO is full  |
| `empty`    | Output    | Indicates FIFO is empty |

## Working Principle

* The FIFO uses two pointers:

  * **Write Pointer (WPTR)** → indicates where new data is written.
  * **Read Pointer (RPTR)** → indicates where data is read from.
* Data is written into memory when `wr_en` is high and FIFO is not full.
* Data is read when `rd_en` is high and FIFO is not empty.
* A **wrap bit** is used to differentiate between full and empty conditions.

## Full Condition

FIFO becomes full when:

```
wrap = WPTR[PTR_WIDTH] ^ RPTR[PTR_WIDTH]
WPTR lower bits == RPTR lower bits
```

## Empty Condition

FIFO becomes empty when:

```
WPTR == RPTR
```

## Tools Used

* **Verilog/SystemVerilog**
* **Icarus Verilog**
* **EDA Playground / Local Simulation**

## Applications

* Data buffering
* Clock domain data transfer
* Communication systems
* Processor pipelines
* Digital signal processing systems

## Author

FIFO RTL design created for learning and RTL design practice.
