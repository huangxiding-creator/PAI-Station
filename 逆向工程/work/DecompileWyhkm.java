import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;
import ghidra.util.task.ConsoleTaskMonitor;
import java.io.FileWriter;
import java.util.Arrays;
import java.util.List;

public class DecompileWyhkm extends GhidraScript {
    @Override
    public void run() throws Exception {
        DecompInterface decomp = new DecompInterface();
        decomp.openProgram(currentProgram);
        ConsoleTaskMonitor monitor = new ConsoleTaskMonitor();

        List<String> targets = Arrays.asList(
            "HKMOpen", "HKMOpen2", "HKMClose", "HKMSearchDevice",
            "HKMSearchDevice2", "HKMSearchDeviceAll",
            "HKMMoveTo", "HKMMoveR", "HKMMoveR2",
            "HKMLeftClick", "HKMRightClick", "HKMKeyPress", "HKMKeyDown",
            "HKMKeyUp", "HKMOutputString", "HKMSetKeyInterval",
            "HKMSetMouseSpeed", "HKMSetMouseInterval", "HKMMouseWheel",
            "HKMGetSerialNumber", "HKMVerifyUserData", "HKMVerifyUserData2",
            "HKMDelayRnd", "HKMSetLightMode", "HKMReleaseKeyboard",
            "HKMReleaseMouse", "HKMGetDevInfo", "HKMGetError", "HKMIsOpen"
        );

        FileWriter out = new FileWriter(
            "e:\\AI-Station\\逆向工程\\work\\wyhkm_decompiled.c");
        FunctionIterator it = currentProgram.getFunctionManager()
            .getFunctions(true);
        while (it.hasNext()) {
            Function func = it.next();
            String name = func.getName();
            if (targets.contains(name)) {
                DecompileResults result = decomp.decompileFunction(
                    func, 60, monitor);
                if (result.decompileCompleted()) {
                    String code = result.getDecompiledFunction().getC();
                    out.write("\n/* ===== " + name + " ===== */\n" + code + "\n");
                    println("Decompiled: " + name);
                } else {
                    out.write("\n/* ===== " + name + " (FAILED) ===== */\n");
                    println("FAILED: " + name);
                }
            }
        }
        out.close();
        println("Done. Output written.");
    }
}
