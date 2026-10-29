# Ghidra Python script: decompile key wyhkm.dll functions
# @category Analysis
from ghidra.app.decompiler import DecompInterface
from ghidra.util.task import ConsoleTaskMonitor

monitor = ConsoleTaskMonitor()
decomp = DecompInterface()
decomp.openProgram(currentProgram)

fm = currentProgram.getFunctionManager()
out = open(r"e:\AI-Station\逆向工程\work\wyhkm_decompiled.c", "w")

# 核心函数清单
TARGETS = [
    "HKMOpen", "HKMOpen2", "HKMClose", "HKMSearchDevice", "HKMSearchDevice2",
    "HKMSearchDeviceAll", "HKMMoveTo", "HKMMoveR", "HKMMoveR2",
    "HKMLeftClick", "HKMRightClick", "HKMKeyPress", "HKMKeyDown", "HKMKeyUp",
    "HKMOutputString", "HKMSetKeyInterval", "HKMSetMouseSpeed",
    "HKMSetMouseInterval", "HKMMouseWheel", "HKMGetSerialNumber",
    "HKMVerifyUserData", "HKMVerifyUserData2", "HKMDelayRnd",
    "HKMSetLightMode", "HKMReleaseKeyboard", "HKMReleaseMouse",
    "HKMGetDevInfo", "HKMGetError", "HKMIsOpen",
]

for func in fm.getFunctions(True):
    name = func.getName()
    if name in TARGETS:
        result = decomp.decompileFunction(func, 60, monitor)
        if result.decompileCompleted():
            code = result.getDecompiledFunction().getC()
            out.write(f"\n/* ===== {name} ===== */\n{code}\n")
            print(f"Decompiled: {name}")
        else:
            out.write(f"\n/* ===== {name} (FAILED) ===== */\n")
            print(f"FAILED: {name}")

out.close()
print("Done. Output: e:\\AI-Station\\逆向工程\\work\\wyhkm_decompiled.c")
