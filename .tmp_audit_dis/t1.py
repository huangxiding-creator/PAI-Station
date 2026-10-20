import dis, sys
print(sys.version)

def f(e):
    nonce, ciphertext = e[:12], e[12:]
    return nonce, ciphertext

dis.dis(f)
print("f result:", f(b'0123456789abcdef'))

def g(t):
    machine_guid, _ = t
    return machine_guid

dis.dis(g)
print("g result:", g(('GUID_VALUE', 'ignored')))
