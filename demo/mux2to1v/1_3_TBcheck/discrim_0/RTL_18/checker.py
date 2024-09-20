class GoldenDUT:
    def __init__(self):
        # No inner states are necessarily kept for this simple function
        pass

    def load(self, signal_vector):
        # Extract input signals from the signal vector
        a = signal_vector['a']
        b = signal_vector['b']
        sel = signal_vector['sel']
        
        # Compute the expected output based on the selector `sel`
        return self._compute_expected_output(a, b, sel)

    def check(self, signal_vector):
        # Get the expected output by loading the current input signal vector
        expected_out = self.load(signal_vector)
        
        # Compare with DUT output
        actual_out = signal_vector['out']
        
        # Return True if the outputs match; otherwise, False
        return expected_out == actual_out

    def _compute_expected_output(self, a, b, sel):
        # Ensure inputs 'a' and 'b' are each 100 bits long
        assert 0 <= a < (1 << 100), "Input 'a' must be a 100-bit integer."
        assert 0 <= b < (1 << 100), "Input 'b' must be a 100-bit integer."
        assert sel in [0, 1], "Input 'sel' must be either 0 or 1."

        # Return 'a' if sel is 0, 'b' if sel is 1
        if sel == 0:
            return a
        else:
            return b

def check_dut(vectors_in):
    golden_dut = GoldenDUT()
    failed_scenarios = []
    for vector in vectors_in:
        check_pass = golden_dut.check(vector)
        if check_pass:
            print(f"Passed; vector: {vector}")
        else:
            print(f"Failed; vector: {vector}")
            failed_scenarios.append(vector["scenario"])
    return failed_scenarios

def SignalTxt_to_dictlist(txt:str):
    lines = txt.strip().split("\n")
    signals = []
    for line in lines:
        signal = {}
        line = line.strip().split(", ")
        for item in line:
            if "scenario" in item:
                item = item.split(": ")
                signal["scenario"] = item[1]
            else:
                item = item.split(" = ")
                key = item[0]
                value = item[1]
                if "x" not in value and "z" not in value:
                    signal[key] = int(value)
                else:
                    signal[key] = value 
        signals.append(signal)
    return signals
with open("TBout.txt", "r") as f:
    txt = f.read()
vectors_in = SignalTxt_to_dictlist(txt)
tb_pass = check_dut(vectors_in)
print(tb_pass)
