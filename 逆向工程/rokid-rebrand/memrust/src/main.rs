// memdex: 零注入 dex 内存扫描器（Rust 静态 musl 版，直读 /proc/<pid>/mem）
use std::fs::{self, File, OpenOptions};
use std::io::{Read, Seek, SeekFrom, Write};

fn ptrace_attach(pid: i32) -> bool {
    // PTRACE_ATTACH=16, PTRACE_DETACH=17
    unsafe {
        let r = libc_ptrace(16, pid as u64, 0, 0);
        if r != 0 { return false; }
        // waitpid(pid, 0, 0) via syscall 61
        let w = syscall3(61, pid as u64, 0, 0);
        w >= 0
    }
}
fn ptrace_detach(pid: i32) {
    unsafe { libc_ptrace(17, pid as u64, 0, 0); }
}
#[inline(always)]
unsafe fn libc_ptrace(req: u64, pid: u64, addr: u64, data: u64) -> i64 {
    let ret: i64;
    std::arch::asm!(
        "syscall",
        inlateout("rax") 101i64 => ret,
        in("rdi") req,
        in("rsi") pid,
        in("rdx") addr,
        in("r10") data,
        out("rcx") _, out("r11") _,
    );
    ret
}
#[inline(always)]
unsafe fn syscall3(nr: u64, a: u64, b: u64, c: u64) -> i64 {
    let ret: i64;
    std::arch::asm!(
        "syscall",
        inlateout("rax") nr as i64 => ret,
        in("rdi") a, in("rsi") b, in("rdx") c,
        out("rcx") _, out("r11") _,
    );
    ret
}

#[repr(C)]
struct IoVec { base: u64, len: u64 }
fn read_vm(pid: u32, addr: u64, buf: &mut [u8]) -> i64 {
    unsafe {
        let local = IoVec { base: buf.as_mut_ptr() as u64, len: buf.len() as u64 };
        let remote = IoVec { base: addr, len: buf.len() as u64 };
        syscall6(310, pid as u64, &local as *const IoVec as u64, 1,
                 &remote as *const IoVec as u64, 1, 0)
    }
}
#[inline(always)]
unsafe fn syscall6(nr: u64, a: u64, b: u64, c: u64, d: u64, e: u64, f: u64) -> i64 {
    let ret: i64;
    std::arch::asm!(
        "syscall",
        inlateout("rax") nr as i64 => ret,
        in("rdi") a, in("rsi") b, in("rdx") c, in("r10") d, in("r8") e, in("r9") f,
        out("rcx") _, out("r11") _,
    );
    ret
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        eprintln!("usage: memdex <pid>");
        std::process::exit(1);
    }
    let pid = &args[1];
    let maps = fs::read_to_string(format!("/proc/{}/maps", pid)).expect("read maps");
    let pidn: i32 = pid.parse().unwrap();
    if !ptrace_attach(pidn) { println!("PTRACE-ATTACH failed"); }
    else { println!("PTRACE-ATTACHED — 内存已解锁"); }
    let mut mem = File::open(format!("/proc/{}/mem", pid)).expect("open mem");
    let mut hits = 0usize;
    let mut fail = 0usize;
    let mut rok = 0usize;
    let mut okr = 0usize;
    let mut tot = 0u64;
    let mut saved = 0usize;
    let _ = fs::create_dir_all("/data/local/tmp/dex_out");
    for line in maps.lines() {
        let mut it = line.split_whitespace();
        let range = match it.next() { Some(r) => r, None => continue };
        let perms = match it.next() { Some(p) => p, None => continue };
        if !perms.starts_with('r') { continue; }
        let (lo_s, hi_s) = range.split_once('-').unwrap();
        let lo = u64::from_str_radix(lo_s, 16).unwrap();
        let hi = u64::from_str_radix(hi_s, 16).unwrap();
        let size = hi - lo;
        if size < 0x1000 { continue; }
        // 桥段读 8MB 一段
        let mut off = lo;
        while off < hi {
            let chunk = std::cmp::min(0x800000, hi - off);
            let mut buf = vec![0u8; chunk as usize];
            let n = match read_vm(pidn as u32, off, &mut buf) { n if n > 0 => n as usize, _ => { fail += 1; off += chunk; continue; } };
            if n < 8 { off += chunk; continue; }
            okr += 1; tot += n as u64;
            // 扫 dex 魔数
            let mut i = 0usize;
            while i + 0x70 <= n {
                let endian = &buf[i+0x28..i+0x2c] == &[0x78u8, 0x56, 0x34, 0x12];
                let magic = &buf[i..i+4] == b"dex\n" && buf[i+4] >= b'0' && buf[i+4] <= b'9';
                if magic || endian {
                    let fsize = u32::from_le_bytes([buf[i+0x20], buf[i+0x21], buf[i+0x22], buf[i+0x23]]) as usize;
                    let sis = u32::from_le_bytes([buf[i+0x38], buf[i+0x39], buf[i+0x3a], buf[i+0x3b]]) as usize;
                    let hsz = u32::from_le_bytes([buf[i+0x24], buf[i+0x25], buf[i+0x26], buf[i+0x27]]) as usize;
                    if sis > 0 && sis < 2_000_000 && fsize >= 0x70 && fsize < 0x8000000 && hsz == 0x70 {
                        let addr = off + i as u64;
                        println!("HIT {:#x} size={}", addr, fsize);
                        hits += 1;
                        // 从原缓冲直接写（若整段在 buf 内）
                        if i + fsize <= n && fsize > 0 {
                            let path = format!("/data/local/tmp/dex_out/dex_{:x}.dex", addr);
                            if let Ok(mut f) = OpenOptions::new().write(true).create(true).truncate(true).open(&path) {
                                if f.write_all(&buf[i..i+fsize]).is_ok() {
                                    println!("  saved {}", path);
                                    saved += 1;
                                }
                            }
                        } else {
                            // 跨段：重新 pread
                            let mut dbuf = vec![0u8; fsize];
                            if read_vm(pidn as u32, addr, &mut dbuf) == fsize as i64 {
                                let path = format!("/data/local/tmp/dex_out/dex_{:x}.dex", addr);
                                if let Ok(mut f) = OpenOptions::new().write(true).create(true).truncate(true).open(&path) {
                                    if f.write_all(&dbuf).is_ok() {
                                        println!("  saved(x) {}", path);
                                        saved += 1;
                                    }
                                }
                            }
                        }
                        i += fsize.saturating_sub(1);
                    }
                }
                if &buf[i..i.min(i+10)] == b"Lcom/rokid" { rok += 1; }
                i += 1;
            }
            off += chunk;
        }
    }
    ptrace_detach(pidn);
    println!("DONE hits={} saved={} readfail={} rokid_str={} okreads={} bytes={}", hits, saved, fail, rok, okr, tot);
}
