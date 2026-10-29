# Decrypt license.enc using the app's own get_machine_code code object executed verbatim
import marshal, sys, types, json

PYZ = r"E:\AI-Station\逆向工程\IMA下载助手\extracted\_pyz"
LIC = r"E:\AI-Station\逆向工程\IMA下载助手\localstate\license.enc"

def find_code(code, name):
    for c in code.co_consts:
        if hasattr(c, "co_code"):
            if c.co_name == name:
                return c
            r = find_code(c, name)
            if r is not None:
                return r
    return None

def run_func(code_obj, args=()):
    g = {"__builtins__": __builtins__}
    fn = types.FunctionType(code_obj, g)
    return fn(*args)

def main():
    with open(PYZ + r"\core\auth.pyc", "rb") as f:
        f.read(16)
        top = marshal.loads(f.read())
    mc_code = find_code(top, "get_machine_code")
    key_code = find_code(top, "get_local_aes_key")
    assert mc_code and key_code

    # execute get_local_aes_key verbatim (it internally calls get_machine_code via LOAD_GLOBAL)
    g = {"__builtins__": __builtins__}
    # provide the nested global names it needs by injecting our verbatim machine-code fn
    import platform, subprocess, winreg, hashlib
    mc_fn = types.FunctionType(mc_code, {"__builtins__": __builtins__,
                                         "platform": platform, "subprocess": subprocess,
                                         "winreg": winreg, "hashlib": hashlib})
    print("machine_code (verbatim exec) =", mc_fn())
    g["get_machine_code"] = mc_fn
    # PBKDF2 imports
    from cryptography.hazmat.backends import default_backend
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
    from cryptography.hazmat.primitives.ciphers.aead import AESGCM
    g.update(PBKDF2HMAC=PBKDF2HMAC, hashes=hashes, default_backend=default_backend)
    key_fn = types.FunctionType(key_code, g)
    key = key_fn()
    print("aes key =", key.hex())

    blob = open(LIC, "rb").read()
    for tag, nonce, ct in [
        ("writer(nonce||ct)", blob[:12], blob[12:]),
        ("loader(ct||nonce)", blob[12:], blob[:12]),
    ]:
        try:
            pt = AESGCM(key).decrypt(nonce, ct, None)
            print("SUCCESS with", tag)
            data = json.loads(pt.decode("utf-8"))
            out = r"E:\AI-Station\逆向工程\IMA下载助手\localstate\license_decrypted.json"
            json.dump(data, open(out, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
            print(json.dumps(data, ensure_ascii=False, indent=2)[:3000])
            return
        except Exception as ex:
            print("fail", tag, type(ex).__name__)
    print("ALL FAILED")

if __name__ == "__main__":
    main()
