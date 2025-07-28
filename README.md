# Design and Simulation of a 4-CLB Reconfigurable FPGA Fabric

This project implements a simplified FPGA core architecture consisting of **4 Configurable Logic Blocks (CLBs)** interconnected via a **Switch Matrix**. Each CLB features a 4-input Lookup Table (LUT), a D Flip-Flop (DFF), and a 2:1 MUX to switch between combinational and sequential output. The Switch Matrix enables dynamic selection of CLB outputs based on control signals.

---

## 🧠 Project Structure


---

## ⚙️ Module Overview

### 🔸 `CLB.v`
A Configurable Logic Block containing:
- `LUT.v` – 4-input Look-Up Table
- `DFF.v` – D Flip-Flop for sequential output
- `MUX2x1.v` – Selects between LUT and DFF output via `Sel_dat`

### 🔸 `Switch.v`
Takes output from all 4 CLBs and selects one of them using a 2-bit selector (`Sel_CLB`). Acts as a routing matrix.

### 🔸 `FPGA.v`
Top-level module instantiating 4 CLBs and a `Switch.v` instance to route and aggregate CLB outputs.

---

## 🔍 How It Works

- Each CLB takes 4-bit input and a 16-bit LUT configuration.
- Output of the LUT is optionally passed through a DFF.
- The `Sel_dat` signal selects whether to use the LUT or DFF output.
- The `Switch.v` module selects one of the 4 CLB outputs based on `Sel_CLB` signal.

---

## 📐 Simulation

You can simulate the design using **ModelSim**, **Vivado**, or any Verilog simulation tool.

### Steps:
1. Compile all `.v` files.
2. Run `testbench.v`.
3. Observe waveform or console output to validate switching and CLB logic.

---

## ✅ Features

- 4 Configurable Logic Blocks with:
  - Custom LUT initialization
  - Optional DFF (for sequential logic)
  - MUX to select output type
- Switch Matrix to route any CLB output
- Modular and scalable Verilog design

---

## 📁 Example Testbench Output

- Apply different `Sel_dat` and `Sel_CLB` values.
- Observe LUT and DFF transitions.
- Validate switching behavior via waveform viewer.

---

## 🚀 Future Enhancements

- Add parameterized N-CLB design
- Implement routing between CLBs (instead of just output selection)
- Support more complex logic functions or carry chains
- GUI-based LUT configurator or Verilog test input generator

---

## 🧑‍💻 Author

**J Jithendra Gopal**

📧 [LinkedIn](https://www.linkedin.com/in/j-jithendra-gopal-00527918b/)
[Portfolio :-](https://jithendragopal.github.io/portfolio)
🎓 Electronics and Communication Engineer | FPGA Enthusiast | Embedded Systems Developer

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).
