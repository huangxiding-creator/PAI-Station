# Decrypt imahelper license.enc (AESGCM, PBKDF2 key from machine code)
import subprocess, hashlib, json, sys, os
try:
    from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.ciphers.aead import AESGCM
except ImportError:
    sys.exit("need cryptography package")

LIC = r"E:\AI-Station\逆向工程\IMA下载助手\localstate\license.enc"

def get_machine_code():
    import winreg
    try:
        with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Cryptography") as k:
            guid, _ = winreg.QueryValueEx(k, "MachineGuid")
    except Exception:
        guid = "UNKNOWN_GUID"
    try:
        si = subprocess.STARTUPINFO()
        si.dwFlags |= subprocess.STARTF_USESHOWWINDOW
        out = subprocess.run(["wmic", "baseboard", "get", "serialnumber"],
                             capture_output=True, text=True, timeout=5,
                             startupinfo=si, creationflags=subprocess.CREATE_NO_WINDOW).stdout
        lines = [l.strip() for l in out.split("\n") if l.strip()]
        mb = lines[1] if len(lines) > 1 else "UNKNOWN_MB"
    except Exception:
        mb = "UNKNOWN_MB"
    import platform
    raw = f"{guid}|{mb}|{platform.machine()}"
    print("machine-raw =", raw)
    return hashlib.sha256(raw.encode()).hexdigest()

def main():
    mc = get_machine_code()
    print("machine_code =", mc)
    kdf = PBKDF2HMAC(algorithm=hashes.SHA256(), length=32, salt=b"ima_local_salt", iterations=100000)
    key = kdf.derive(mc.encode())
    blob = open(LIC, "rb").read()
    nonce, ct = blob[:12], blob[12:]
    plain = AESGCM(key).decrypt(nonce, ct, None)
    data = json.loads(plain.decode("utf-8"))
    out = r"E:\AI-Station\逆向工程\IMA下载助手\localstate\license_decrypted.json"
    with open(out, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print("decrypted ->", out)
    print(json.dumps(data, ensure_ascii=False, indent=2)[:3000])

if __name__ == "__main__":
    main()
