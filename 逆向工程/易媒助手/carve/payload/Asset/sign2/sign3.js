function get_arr(t, a) {
    var reg = {
        "chunk": [],
        "reg": [1937774191, 1226093241, 388252375, 3666478592, 2842636476, 372324522, 3817729613, 2969243214],
        "size": 0,
        "write": function(e) {
            var f = "string" == typeof e ? function(e) {
                var a = encodeURIComponent(e)["replace"](/%([0-9A-F]{2})/g, (function(e, r) {
                        return String["fromCharCode"]("0x" + r)
                    }
                ));
                n = new Array(a.length);
                return Array["prototype"]["forEach"]["call"](a, (function(e, r) {
                        n[r] = e["charCodeAt"](0)
                    }
                )),n;
            }(e) : e

            this["size"] += f.length;
            var i = 64 - this["chunk"]["length"];
            if (f.length < i) {
                this["chunk"] = this["chunk"]["concat"](f);
            } else {
                for (this["chunk"] = this["chunk"]["concat"](f["slice"](0, i)); this["chunk"]["length"] >= 64; ) {
                    this["_compress"](this["chunk"]);
                    i < f.length ? this["chunk"] = f["slice"](i, Math.min(i + 64, f["length"])) : this["chunk"] = [],
                        i += 64

                }
            }

        },
        "_compress": function(r) {
            if (r < 64) {
                console["error"]("compress error: not enough data")
            } else {
                for (var a = function(e) {
                    for (var r = new Array(132), t = 0; t < 16; t++) {
                        r[t] = e[4 * t] << 24;
                        r[t] |= e[4 * t + 1] << 16;
                        r[t] |= e[4 * t + 2] << 8;
                        r[t] |= e[4 * t + 3];
                        r[t] >>>= 0;
                    }

                    for (var a = 16; a < 68; a++) {
                        var n = r[a - 16] ^ r[a - 9] ^ le(r[a - 3], 15);
                        n = n ^ le(n, 15) ^ le(n, 23);
                        r[a] = (n ^ le(r[a - 13], 7) ^ r[a - 6]) >>> 0;
                    }

                    for (a = 0; a < 64; a++)
                        r[a + 68] = (r[a] ^ r[a + 4]) >>> 0;

                    return r;
                }(r), n = this.reg["slice"](0), f = 0; f < 64; f++) {
                    var i = le(n[0], 12) + n[4] + le(de(f), f);
                    var o = ((i = le(i = (4294967295 & i) >>> 0, 7)) ^ le(n[0], 12)) >>> 0;
                    var c = pe(f, n[0], n[1], n[2]);
                    c = (4294967295 & (c = c + n[3] + o + a[f + 68])) >>> 0;
                    var s = he(f, n[4], n[5], n[6]);
                    s = (4294967295 & (s = s + n[7] + i + a[f])) >>> 0;
                    n[3] = n[2];
                    n[2] = le(n[1], 9);
                    n[1] = n[0];
                    n[0] = c;
                    n[7] = n[6];
                    n[6] = le(n[5], 19);
                    n[5] = n[4];
                    n[4] = (s ^ le(s, 9) ^ le(s, 17)) >>> 0;
                }

                for (var u = 0; u < 8; u++)
                    this["reg"][u] = (this.reg[u] ^ n[u]) >>> 0;
            }
        },

        "_fill": function() {

            var n = 8 * this.size
                , f = this.chunk["push"](128) % 64;
            for (64 - f < 8 && (f -= 64); f < 56; f++)
                this["chunk"]["push"](0);
            for (var i = 0; i < 4; i++) {
                var o = Math.floor(n / 4294967296);
                this["chunk"].push(o >>> 8 * (3 - i) & 255)
            }
            for (i = 0; i < 4; i++)
                this["chunk"]["push"](n >>> 8 * (3 - i) & 255)
        }

    }

    function le(e, r) {
        return (e << (r %= 32) | e >>> 32 - r) >>> 0;
    }
    function de(e) {
        return 0 <= e && e < 16 ? 2043430169 : 16 <= e && e < 64 ? 2055708042 : void console.error("invalid j for constant Tj")
    }
    function pe(e, r, t, a) {
        return 0 <= e && e < 16 ? (r ^ t ^ a) >>> 0 : 16 <= e && e < 64 ? (r & t | r & a | t & a) >>> 0 : (console["error"]("invalid j for bool function FF"),
            0)
    }
    function he(e, r, t, a) {
        return 0 <= e && e < 16 ? (r ^ t ^ a) >>> 0 : 16 <= e && e < 64 ? (r & t | ~r & a) >>> 0 : (console["error"]("invalid j for bool function GG"),
            0)
    }



    reg.write(t);
    reg._fill();

    for (var i = 0; i < reg["chunk"]["length"]; i += 64) {
        reg["_compress"](reg["chunk"]["slice"](i, i + 64));
    }

    var o = null;
    if (a == "hex") {
        o = "";
        for (i = 0; i < 8; i++)
            o += oe(reg["reg"][i]["toString"](16), 8, "0")
    } else {
        for (o = new Array(32),
                 i = 0; i < 8; i++) {
            var c = reg.reg[i];
            o[4 * i + 3] = (255 & c) >>> 0,
                c >>>= 8,
                o[4 * i + 2] = (255 & c) >>> 0,
                c >>>= 8,
                o[4 * i + 1] = (255 & c) >>> 0,
                c >>>= 8,
                o[4 * i] = (255 & c) >>> 0
        }
    }
    return o;
}


function _0x46fa4c(a, c) {
    let e, b = [], d = 0, f = "";
    for (let a = 0; a < 256; a++) {
        b[a] = a;
    }
    for (let c = 0; c < 256; c++) {
        d = (d + b[c] + a.charCodeAt(c % a.length)) % 256,
            e = b[c],
            b[c] = b[d],
            b[d] = e;
    }
    let t = 0;
    d = 0;
    for (let a = 0; a < c.length; a++) {
        t = (t + 1) % 256,
            d = (d + b[t]) % 256,
            e = b[t],
            b[t] = b[d],
            b[d] = e,
            f += String.fromCharCode(c.charCodeAt(a) ^ b[(b[t] + b[d]) % 256]);
    }
    return f;
}

function _0x583250(a) {
    return String.fromCharCode(a);
}

function _0x2b6720(a, c, e) {
    return _0x583250(a) + _0x583250(c) + e;
}

function getABogus(url,data,userAgent){

    var params = url.slice(url.indexOf("?") + 1) + "bds";
    data += "bds";
    var garbledString = getGarbledString(params,data,userAgent);
    //var garbledString = "#CH\u0016¡X<\u0017\u0010\u0004,UPmÛvH=\r¡Æç\u0010x/\nlEÙ)";
    var short_str = "Dkdpgh2ZmsQB80/MfvV36XI1R45-WUAlEixNLwoqYTOPuzKFjJnry79HbGcaStCe"
    var ABogus = "";

    for (var i = 0; i <= 30; i += 3) {
        var charCodeAtNum0 = garbledString.charCodeAt(i);
        var charCodeAtNum1 = garbledString.charCodeAt(i + 1);
        var charCodeAtNum2 = garbledString.charCodeAt(i + 2);
        var baseNum = charCodeAtNum2 | charCodeAtNum1 << 8 | charCodeAtNum0 << 16;

        var str1 = short_str[(baseNum & 16515072) >> 18];
        var str2 = short_str[(baseNum & 258048) >> 12];
        var str3 = short_str[(baseNum & 4032) >> 6];
        var str4 = short_str[baseNum & 63];
        ABogus += str1 + str2 + str3 + str4;
    }
    /*
    console.log(ABogus);
    return url + "&a_bogus=" + ABogus;
     */
    return ABogus
}

function getGarbledString(params,data,userAgent){
    var timestamp1 = Date.now(),timestamp2 = timestamp1 - Math.floor(Math.random() * 1000),timestamp3 = timestamp1 + Math.floor(Math.random() * 30000);
    var arr29 = get_arr29(timestamp1,timestamp2,params,data,userAgent);
    var arr4 = get_arr4(timestamp3,arr29);
    var a = String.fromCharCode.apply(String,arr4);
    var b = _0x46fa4c.apply(null,['\x83',String.fromCharCode.apply(null,arr29)]);
    return a + b;
}

function encrypt_browser(ua){
    if(ua.length != 29){
        var gg = [0, 218, 17, 20, 25, 23, 95, 116, 236, 14, 146, 5, 3, 151, 128, 186, 32, 114, 244, 80, 4, 46, 36, 85, 213, 108, 174, 201, 63, 129, 47, 99, 38, 81, 150, 242, 69, 60, 72, 55, 192, 52, 10, 77, 96, 141, 59, 62, 165, 204, 67, 120, 90, 240, 200, 94, 164, 221, 229, 98, 37, 145, 57, 230, 8, 232, 169, 212, 132, 115, 209, 54, 110, 170, 39, 91, 167, 225, 207, 31, 210, 182, 152, 83, 144, 195, 211, 161, 65, 29, 147, 183, 42, 97, 153, 50, 223, 43, 188, 79, 158, 187, 166, 179, 68, 121, 44, 155, 75, 173, 252, 249, 11, 159, 27, 133, 58, 124, 243, 198, 239, 45, 241, 217, 1, 74, 162, 103, 136, 226, 112, 199, 191, 21, 180, 163, 196, 157, 71, 56, 143, 234, 33, 205, 233, 34, 181, 139, 119, 64, 193, 102, 76, 61, 15, 109, 160, 222, 111, 247, 202, 104, 70, 84, 178, 171, 86, 140, 53, 238, 88, 255, 228, 175, 22, 118, 177, 197, 105, 82, 7, 154, 92, 190, 248, 246, 214, 203, 135, 126, 123, 78, 18, 30, 35, 245, 12, 168, 51, 100, 227, 251, 235, 93, 49, 122, 208, 206, 219, 142, 101, 176, 215, 130, 66, 117, 40, 134, 2, 253, 216, 189, 156, 125, 24, 16, 26, 41, 220, 137, 106, 250, 172, 138, 237, 127, 19, 107, 148, 194, 89, 48, 254, 113, 231, 185, 28, 224, 87, 73, 184, 9, 6, 13, 131, 149]
    }
    else{
        var gg = [0,7,140,235,54,24,170,17,222,123,210,20,206,127,179,162,78,199,21,227,37,77,171,5,224,26,3,114,176,89,151,57,220,100,69,70,28,254,60,58,113,92,73,18,186,98,228,152,75,255,64,23,232,244,109,81,84,79,65,49,190,126,63,148,195,88,14,96,10,30,99,201,245,193,39,108,51,4,103,132,239,182,139,97,226,229,212,102,48,144,125,216,107,15,207,1,74,247,130,143,184,61,217,189,149,225,211,204,253,145,241,194,214,202,236,47,121,164,157,93,8,196,67,34,118,25,59,72,44,158,146,166,243,208,87,111,155,90,46,32,105,147,173,11,246,153,141,163,104,234,124,122,35,150,110,238,38,160,167,174,115,112,66,169,95,117,36,221,252,68,53,131,156,133,213,198,161,101,83,159,76,116,142,91,9,12,178,205,55,209,137,183,120,197,19,180,172,71,181,135,22,231,233,86,27,154,80,192,175,56,31,177,2,242,203,251,106,168,119,42,248,165,185,187,33,129,237,138,230,191,250,29,40,41,45,240,52,136,6,94,43,134,16,200,215,82,13,249,85,188,0,50,219,128,218,223]
    }
    var oo = ""
    arr0 = [];
    arr1 = [];
    for (i = 1; i < (ua.length + 1); i++) {
        gg[0] = gg[0] + gg[i];
        xx = gg[i];
        if (gg[0] <= 255) {
            arr0.push(gg[0]);
            x1 = gg[gg[0]];
            arr1.push(x1 + xx)
            gg[i] = x1;
            gg[gg[0]] = xx
            if ((x1 + xx) > 255) {
                oo = oo + String.fromCharCode(ua.charCodeAt(i - 1) ^ gg[(x1 + xx) ^ 256])
            }
            else {
                oo = oo + String.fromCharCode(ua.charCodeAt(i - 1) ^ gg[x1 + xx])
            }
        }
        else {
            gg[0] = gg[0] ^ 256;   //24
            arr0.push(gg[0]);
            x1 = gg[gg[0]];
            arr1.push(x1 + xx)
            gg[i] = x1
            gg[gg[0]] = xx
            if ((x1 + xx) > 255) {
                oo = oo + String.fromCharCode(ua.charCodeAt(i - 1) ^ gg[(x1 + xx) ^ 256])
            }
            else {
                oo = oo + String.fromCharCode(ua.charCodeAt(i - 1) ^ gg[x1 + xx])
            }
        }
    };
    if(ua.length != 29){
        str0 = "ckdp1h4ZKsUB80/Mfvw36XIgR25+WQAlEi7NLboqYTOPuzmFjJnryx9HVGDaStCe"
        oo2 = ""
        for (j = 0; j < oo.length; j += 3) {
            var big_num = (((oo.charCodeAt(j)) << 16) | ((oo.charCodeAt(j + 1)) << 8)) | ((oo.charCodeAt(j + 2)) << 0)
            oo2 = oo2 + str0[((big_num & 16515072) >> 18)] + str0[((big_num & 258048) >> 12)] + str0[((big_num & 4032) >> 6)] + str0[((big_num & 63) >> 0)]
        }
        if ((ua.length % 3) != 0) {
            oo2 = oo2.slice(0, -1) + "="
        }
    }
    return oo2;
}

function get_arr4(timestamp,arr29){
    let p = arr29.slice();
    p[0] = timestamp;
    p[1] = null;
    p[2] = [3,66];
    var b = [[[3,66]],[3,66],170,85,timestamp];
    p[1] = 255;
    p[0] = p[0] & p[1];
    b.push(p[0]);
    p[0] = b[4];
    p[1] = 8;
    p[0] = p[0] >> p[1]
    p[1] = 255;
    p[0] = p[0] & p[1];
    b.push(p[0]);
    p[0] = b[5];
    p[1] = b[2];
    p[0] = p[0] & p[1];
    p[1] = b[1];
    p[2] = 0;
    p[1] = p[1][0];
    p[2] = b[3];
    p[1] = p[1] & p[2];
    p[0] = p[0] | p[1];
    b.push(p[0]);
    p[0] = b[5];
    p[1] = b[3];
    p[0] = p[0] & p[1];
    p[1] = b[1];
    p[2] = 0;
    p[1] = p[1][0];
    p[2] = b[2];
    p[1] = p[1] & p[2];
    p[0] = p[0] | p[1]
    b.push(p[0]);
    p[0] = b[6];
    p[1] = b[2];
    p[0] = p[0] & p[1];
    p[1] = b[1];
    p[2] = 1;
    p[1] = p[1][1];
    p[2] = b[3];
    p[1] = p[1] & p[2];
    p[0] = p[0] | p[1]
    b.push(p[0]);
    p[0] = b[6];
    p[1] = b[3];
    p[0] = p[0] & p[1];
    p[1] = b[1];
    p[2] = 1;
    p[1] = p[1][1];
    p[2] = b[2];
    p[1] = p[1] & p[2];
    p[0] = p[0] | p[1];
    b.push(p[0]);
    return b.slice(7);
}

function get_arr29(timestamp1,timestamp2,params,data,userAgent){
    var arr = [];
    var params_arr = get_arr(get_arr(params))
    var data_arr = get_arr(get_arr(data))
    var browser_arr = get_arr(encrypt_browser(userAgent));
    arr[0] = 65;
    arr[1] = timestamp1 >> 24 & 255;
    arr[2] = 0;
    arr[3] = 0;
    arr[4] = 0;
    arr[5] = params_arr[21];
    arr[6] = data_arr[21];
    arr[7] = browser_arr[23];
    arr[8] = timestamp1 >> 16 & 255;
    arr[9] = 0;
    arr[10] = 1;
    arr[11] = 0;
    arr[12] = params_arr[22];
    arr[13] = data_arr[22];
    arr[14] = browser_arr[24];
    arr[15] = timestamp1 >> 8 & 255;
    arr[16] = 0;
    arr[17] = 0;
    arr[18] = 0;
    arr[19] = timestamp1 >> 0 & 255;
    arr[20] = 0;
    arr[21] = 0;
    arr[22] = 14;
    arr[23] = timestamp2 >> 24 & 255;
    arr[24] = timestamp2 >> 16 & 255;
    arr[25] = timestamp2 >> 8 & 255;
    arr[26] = timestamp2 >> 0 & 255;
    arr[27] = 3;
    const xorResult = arr.slice(0, 28).reduce((acc, curr) => acc ^ curr, 0);
    arr[28] = xorResult;
    return arr;
}

/*
url = "source=mp&type=articlebaid=12318msToken=iswb8PstEBiU5li52BA_WJNJqr5uYebwzimnN2AGuFrtS-rLPc0hMLuuZEIML1cmw5-O6p-VTdq1dGZ6Bw7NM_cAHy3leINW_6z2rhPkR5xEZ-CU-iIpBtIom90A6A=="
userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36';
console.log(getABogus(url,'',userAgent))
*/