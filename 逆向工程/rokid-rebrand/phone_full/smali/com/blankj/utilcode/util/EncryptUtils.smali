.class public final Lcom/blankj/utilcode/util/EncryptUtils;
.super Ljava/lang/Object;
.source "EncryptUtils.java"


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static decrypt3DES([B[BLjava/lang/String;[B)[B
    .locals 6
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 817
    const-string v2, "DESede"

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/EncryptUtils;->symmetricTemplate([B[BLjava/lang/String;Ljava/lang/String;[BZ)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptAES([B[BLjava/lang/String;[B)[B
    .locals 6
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 923
    const-string v2, "AES"

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/EncryptUtils;->symmetricTemplate([B[BLjava/lang/String;Ljava/lang/String;[BZ)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptBase64AES([B[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 889
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Decode([B)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decryptAES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptBase64DES([B[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 677
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Decode([B)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decryptDES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptBase64RSA([B[BILjava/lang/String;)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "privateKey"    # [B
    .param p2, "keySize"    # I
    .param p3, "transformation"    # Ljava/lang/String;

    .line 1031
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Decode([B)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decryptRSA([B[BILjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptBase64_3DES([B[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 783
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Decode([B)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decrypt3DES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptDES([B[BLjava/lang/String;[B)[B
    .locals 6
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 711
    const-string v2, "DES"

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/EncryptUtils;->symmetricTemplate([B[BLjava/lang/String;Ljava/lang/String;[BZ)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptHexString3DES(Ljava/lang/String;[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 800
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->hexString2Bytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decrypt3DES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptHexStringAES(Ljava/lang/String;[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 906
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->hexString2Bytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decryptAES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptHexStringDES(Ljava/lang/String;[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 694
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->hexString2Bytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decryptDES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptHexStringRSA(Ljava/lang/String;[BILjava/lang/String;)[B
    .locals 1
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "privateKey"    # [B
    .param p2, "keySize"    # I
    .param p3, "transformation"    # Ljava/lang/String;

    .line 1047
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->hexString2Bytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->decryptRSA([B[BILjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static decryptRSA([B[BILjava/lang/String;)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "privateKey"    # [B
    .param p2, "keySize"    # I
    .param p3, "transformation"    # Ljava/lang/String;

    .line 1063
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, p3, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->rsaTemplate([B[BILjava/lang/String;Z)[B

    move-result-object v0

    return-object v0
.end method

.method public static encrypt3DES([B[BLjava/lang/String;[B)[B
    .locals 6
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 766
    const-string v2, "DESede"

    const/4 v5, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/EncryptUtils;->symmetricTemplate([B[BLjava/lang/String;Ljava/lang/String;[BZ)[B

    move-result-object v0

    return-object v0
.end method

.method public static encrypt3DES2Base64([B[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 732
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encrypt3DES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Encode([B)[B

    move-result-object v0

    return-object v0
.end method

.method public static encrypt3DES2HexString([B[BLjava/lang/String;[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 749
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encrypt3DES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptAES([B[BLjava/lang/String;[B)[B
    .locals 6
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 872
    const-string v2, "AES"

    const/4 v5, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/EncryptUtils;->symmetricTemplate([B[BLjava/lang/String;Ljava/lang/String;[BZ)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptAES2Base64([B[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 838
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptAES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Encode([B)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptAES2HexString([B[BLjava/lang/String;[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 855
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptAES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptDES([B[BLjava/lang/String;[B)[B
    .locals 6
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 660
    const-string v2, "DES"

    const/4 v5, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/EncryptUtils;->symmetricTemplate([B[BLjava/lang/String;Ljava/lang/String;[BZ)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptDES2Base64([B[BLjava/lang/String;[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 626
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptDES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Encode([B)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptDES2HexString([B[BLjava/lang/String;[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "transformation"    # Ljava/lang/String;
    .param p3, "iv"    # [B

    .line 643
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptDES([B[BLjava/lang/String;[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacMD5([B[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 412
    const-string v0, "HmacMD5"

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hmacTemplate([B[BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacMD5ToString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .line 389
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 390
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacMD5ToString([B[B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 389
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptHmacMD5ToString([B[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 401
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacMD5([B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA1([B[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 446
    const-string v0, "HmacSHA1"

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hmacTemplate([B[BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA1ToString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .line 423
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 424
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA1ToString([B[B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 423
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptHmacSHA1ToString([B[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 435
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA1([B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA224([B[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 480
    const-string v0, "HmacSHA224"

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hmacTemplate([B[BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA224ToString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .line 457
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 458
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA224ToString([B[B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 457
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptHmacSHA224ToString([B[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 469
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA224([B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA256([B[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 514
    const-string v0, "HmacSHA256"

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hmacTemplate([B[BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA256ToString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .line 491
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 492
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA256ToString([B[B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 491
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptHmacSHA256ToString([B[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 503
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA256([B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA384([B[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 548
    const-string v0, "HmacSHA384"

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hmacTemplate([B[BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA384ToString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .line 525
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 526
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA384ToString([B[B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 525
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptHmacSHA384ToString([B[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 537
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA384([B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA512([B[B)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 582
    const-string v0, "HmacSHA512"

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hmacTemplate([B[BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptHmacSHA512ToString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "key"    # Ljava/lang/String;

    .line 559
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 560
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA512ToString([B[B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 559
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptHmacSHA512ToString([B[B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 571
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptHmacSHA512([B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptMD2([B)[B
    .locals 1
    .param p0, "data"    # [B

    .line 72
    const-string v0, "MD2"

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hashTemplate([BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptMD2ToString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 51
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 52
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD2ToString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 51
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptMD2ToString([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 62
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD2([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptMD5([B)[B
    .locals 1
    .param p0, "data"    # [B

    .line 134
    const-string v0, "MD5"

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hashTemplate([BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptMD5File(Ljava/io/File;)[B
    .locals 6
    .param p0, "file"    # Ljava/io/File;

    .line 176
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 177
    :cond_0
    const/4 v1, 0x0

    .line 180
    .local v1, "fis":Ljava/io/FileInputStream;
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v1, v2

    .line 181
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 182
    .local v2, "md":Ljava/security/MessageDigest;
    new-instance v3, Ljava/security/DigestInputStream;

    invoke-direct {v3, v1, v2}, Ljava/security/DigestInputStream;-><init>(Ljava/io/InputStream;Ljava/security/MessageDigest;)V

    .line 183
    .local v3, "digestInputStream":Ljava/security/DigestInputStream;
    const/high16 v4, 0x40000

    new-array v4, v4, [B

    .line 185
    .local v4, "buffer":[B
    :cond_1
    invoke-virtual {v3, v4}, Ljava/security/DigestInputStream;->read([B)I

    move-result v5

    if-gtz v5, :cond_1

    .line 187
    invoke-virtual {v3}, Ljava/security/DigestInputStream;->getMessageDigest()Ljava/security/MessageDigest;

    move-result-object v5

    move-object v2, v5

    .line 188
    invoke-virtual {v2}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 194
    nop

    .line 195
    :try_start_1
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 199
    goto :goto_0

    .line 197
    :catch_0
    move-exception v5

    .line 198
    .local v5, "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    .line 188
    .end local v5    # "e":Ljava/io/IOException;
    :goto_0
    return-object v0

    .line 193
    .end local v2    # "md":Ljava/security/MessageDigest;
    .end local v3    # "digestInputStream":Ljava/security/DigestInputStream;
    .end local v4    # "buffer":[B
    :catchall_0
    move-exception v0

    goto :goto_4

    .line 189
    :catch_1
    move-exception v2

    goto :goto_1

    :catch_2
    move-exception v2

    .line 190
    .local v2, "e":Ljava/lang/Exception;
    :goto_1
    :try_start_2
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 191
    nop

    .line 194
    if-eqz v1, :cond_2

    .line 195
    :try_start_3
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_2

    .line 197
    :catch_3
    move-exception v3

    .line 198
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 199
    .end local v3    # "e":Ljava/io/IOException;
    :cond_2
    :goto_2
    nop

    .line 191
    :goto_3
    return-object v0

    .line 194
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_4
    if-eqz v1, :cond_3

    .line 195
    :try_start_4
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_5

    .line 197
    :catch_4
    move-exception v2

    .line 198
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_6

    .line 199
    .end local v2    # "e":Ljava/io/IOException;
    :cond_3
    :goto_5
    nop

    .line 200
    :goto_6
    throw v0
.end method

.method public static encryptMD5File(Ljava/lang/String;)[B
    .locals 2
    .param p0, "filePath"    # Ljava/lang/String;

    .line 155
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->isSpace(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 156
    .local v0, "file":Ljava/io/File;
    :goto_0
    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5File(Ljava/io/File;)[B

    move-result-object v1

    return-object v1
.end method

.method public static encryptMD5File2String(Ljava/io/File;)Ljava/lang/String;
    .locals 1
    .param p0, "file"    # Ljava/io/File;

    .line 166
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5File(Ljava/io/File;)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptMD5File2String(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "filePath"    # Ljava/lang/String;

    .line 144
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->isSpace(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 145
    .local v0, "file":Ljava/io/File;
    :goto_0
    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5File2String(Ljava/io/File;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static encryptMD5ToString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 82
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 83
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5ToString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 82
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptMD5ToString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "salt"    # Ljava/lang/String;

    .line 94
    if-nez p0, :cond_0

    if-nez p1, :cond_0

    const-string v0, ""

    return-object v0

    .line 95
    :cond_0
    if-nez p1, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 96
    :cond_1
    if-nez p0, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 97
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptMD5ToString([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 107
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptMD5ToString([B[B)Ljava/lang/String;
    .locals 4
    .param p0, "data"    # [B
    .param p1, "salt"    # [B

    .line 118
    if-nez p0, :cond_0

    if-nez p1, :cond_0

    const-string v0, ""

    return-object v0

    .line 119
    :cond_0
    if-nez p1, :cond_1

    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 120
    :cond_1
    if-nez p0, :cond_2

    invoke-static {p1}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 121
    :cond_2
    array-length v0, p0

    array-length v1, p1

    add-int/2addr v0, v1

    new-array v0, v0, [B

    .line 122
    .local v0, "dataSalt":[B
    array-length v1, p0

    const/4 v2, 0x0

    invoke-static {p0, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 123
    array-length v1, p0

    array-length v3, p1

    invoke-static {p1, v2, v0, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 124
    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptMD5([B)[B

    move-result-object v1

    invoke-static {v1}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static encryptRSA([B[BILjava/lang/String;)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "publicKey"    # [B
    .param p2, "keySize"    # I
    .param p3, "transformation"    # Ljava/lang/String;

    .line 1015
    const/4 v0, 0x1

    invoke-static {p0, p1, p2, p3, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->rsaTemplate([B[BILjava/lang/String;Z)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptRSA2Base64([B[BILjava/lang/String;)[B
    .locals 1
    .param p0, "data"    # [B
    .param p1, "publicKey"    # [B
    .param p2, "keySize"    # I
    .param p3, "transformation"    # Ljava/lang/String;

    .line 983
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptRSA([B[BILjava/lang/String;)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->base64Encode([B)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptRSA2HexString([B[BILjava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B
    .param p1, "publicKey"    # [B
    .param p2, "keySize"    # I
    .param p3, "transformation"    # Ljava/lang/String;

    .line 999
    invoke-static {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptRSA([B[BILjava/lang/String;)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA1([B)[B
    .locals 1
    .param p0, "data"    # [B

    .line 231
    const-string v0, "SHA-1"

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hashTemplate([BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA1ToString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 210
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 211
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA1ToString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 210
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptSHA1ToString([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 221
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA1([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA224([B)[B
    .locals 1
    .param p0, "data"    # [B

    .line 262
    const-string v0, "SHA224"

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hashTemplate([BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA224ToString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 241
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 242
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA224ToString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 241
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptSHA224ToString([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 252
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA224([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA256([B)[B
    .locals 1
    .param p0, "data"    # [B

    .line 293
    const-string v0, "SHA-256"

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hashTemplate([BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA256ToString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 272
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 273
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA256ToString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 272
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptSHA256ToString([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 283
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA256([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA384([B)[B
    .locals 1
    .param p0, "data"    # [B

    .line 324
    const-string v0, "SHA-384"

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hashTemplate([BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA384ToString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 303
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 304
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA384ToString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 303
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptSHA384ToString([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 314
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA384([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA512([B)[B
    .locals 1
    .param p0, "data"    # [B

    .line 355
    const-string v0, "SHA-512"

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/EncryptUtils;->hashTemplate([BLjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static encryptSHA512ToString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 334
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 335
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA512ToString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 334
    :cond_1
    :goto_0
    const-string v0, ""

    return-object v0
.end method

.method public static encryptSHA512ToString([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 345
    invoke-static {p0}, Lcom/blankj/utilcode/util/EncryptUtils;->encryptSHA512([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2HexString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static hashTemplate([BLjava/lang/String;)[B
    .locals 2
    .param p0, "data"    # [B
    .param p1, "algorithm"    # Ljava/lang/String;

    .line 366
    const/4 v0, 0x0

    if-eqz p0, :cond_1

    array-length v1, p0

    if-gtz v1, :cond_0

    goto :goto_0

    .line 368
    :cond_0
    :try_start_0
    invoke-static {p1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    .line 369
    .local v1, "md":Ljava/security/MessageDigest;
    invoke-virtual {v1, p0}, Ljava/security/MessageDigest;->update([B)V

    .line 370
    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 371
    .end local v1    # "md":Ljava/security/MessageDigest;
    :catch_0
    move-exception v1

    .line 372
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    invoke-virtual {v1}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V

    .line 373
    return-object v0

    .line 366
    .end local v1    # "e":Ljava/security/NoSuchAlgorithmException;
    :cond_1
    :goto_0
    return-object v0
.end method

.method private static hmacTemplate([B[BLjava/lang/String;)[B
    .locals 3
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "algorithm"    # Ljava/lang/String;

    .line 596
    const/4 v0, 0x0

    if-eqz p0, :cond_1

    array-length v1, p0

    if-eqz v1, :cond_1

    if-eqz p1, :cond_1

    array-length v1, p1

    if-nez v1, :cond_0

    goto :goto_1

    .line 598
    :cond_0
    :try_start_0
    new-instance v1, Ljavax/crypto/spec/SecretKeySpec;

    invoke-direct {v1, p1, p2}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 599
    .local v1, "secretKey":Ljavax/crypto/spec/SecretKeySpec;
    invoke-static {p2}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v2

    .line 600
    .local v2, "mac":Ljavax/crypto/Mac;
    invoke-virtual {v2, v1}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 601
    invoke-virtual {v2, p0}, Ljavax/crypto/Mac;->doFinal([B)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 602
    .end local v1    # "secretKey":Ljavax/crypto/spec/SecretKeySpec;
    .end local v2    # "mac":Ljavax/crypto/Mac;
    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    .line 603
    .local v1, "e":Ljava/security/GeneralSecurityException;
    :goto_0
    invoke-virtual {v1}, Ljava/security/GeneralSecurityException;->printStackTrace()V

    .line 604
    return-object v0

    .line 596
    .end local v1    # "e":Ljava/security/GeneralSecurityException;
    :cond_1
    :goto_1
    return-object v0
.end method

.method private static joins([B[B)[B
    .locals 4
    .param p0, "prefix"    # [B
    .param p1, "suffix"    # [B

    .line 1179
    array-length v0, p0

    array-length v1, p1

    add-int/2addr v0, v1

    new-array v0, v0, [B

    .line 1180
    .local v0, "ret":[B
    array-length v1, p0

    const/4 v2, 0x0

    invoke-static {p0, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1181
    array-length v1, p0

    array-length v3, p1

    invoke-static {p1, v2, v0, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1182
    return-object v0
.end method

.method public static rc4([B[B)[B
    .locals 11
    .param p0, "data"    # [B
    .param p1, "key"    # [B

    .line 1143
    if-eqz p0, :cond_5

    array-length v0, p0

    if-eqz v0, :cond_5

    if-nez p1, :cond_0

    goto :goto_3

    .line 1144
    :cond_0
    array-length v0, p1

    const/4 v1, 0x1

    if-lt v0, v1, :cond_4

    array-length v0, p1

    const/16 v1, 0x100

    if-gt v0, v1, :cond_4

    .line 1147
    new-array v0, v1, [B

    .line 1148
    .local v0, "iS":[B
    new-array v2, v1, [B

    .line 1149
    .local v2, "iK":[B
    array-length v3, p1

    .line 1150
    .local v3, "keyLen":I
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v1, :cond_1

    .line 1151
    int-to-byte v5, v4

    aput-byte v5, v0, v4

    .line 1152
    rem-int v5, v4, v3

    aget-byte v5, p1, v5

    aput-byte v5, v2, v4

    .line 1150
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 1154
    .end local v4    # "i":I
    :cond_1
    const/4 v4, 0x0

    .line 1156
    .local v4, "j":I
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_1
    if-ge v5, v1, :cond_2

    .line 1157
    aget-byte v6, v0, v5

    add-int/2addr v6, v4

    aget-byte v7, v2, v5

    add-int/2addr v6, v7

    and-int/lit16 v4, v6, 0xff

    .line 1158
    aget-byte v6, v0, v4

    .line 1159
    .local v6, "tmp":B
    aget-byte v7, v0, v5

    aput-byte v7, v0, v4

    .line 1160
    aput-byte v6, v0, v5

    .line 1156
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 1163
    .end local v5    # "i":I
    .end local v6    # "tmp":B
    :cond_2
    array-length v1, p0

    new-array v1, v1, [B

    .line 1164
    .local v1, "ret":[B
    const/4 v5, 0x0

    .line 1165
    .restart local v5    # "i":I
    const/4 v6, 0x0

    .local v6, "counter":I
    :goto_2
    array-length v7, p0

    if-ge v6, v7, :cond_3

    .line 1166
    add-int/lit8 v7, v5, 0x1

    and-int/lit16 v5, v7, 0xff

    .line 1167
    aget-byte v7, v0, v5

    add-int/2addr v7, v4

    and-int/lit16 v4, v7, 0xff

    .line 1168
    aget-byte v7, v0, v4

    .line 1169
    .local v7, "tmp":B
    aget-byte v8, v0, v5

    aput-byte v8, v0, v4

    .line 1170
    aput-byte v7, v0, v5

    .line 1171
    aget-byte v8, v0, v5

    aget-byte v9, v0, v4

    add-int/2addr v8, v9

    and-int/lit16 v8, v8, 0xff

    .line 1172
    .local v8, "t":I
    aget-byte v9, v0, v8

    .line 1173
    .local v9, "k":I
    aget-byte v10, p0, v6

    xor-int/2addr v10, v9

    int-to-byte v10, v10

    aput-byte v10, v1, v6

    .line 1165
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    .line 1175
    .end local v6    # "counter":I
    .end local v7    # "tmp":B
    .end local v8    # "t":I
    .end local v9    # "k":I
    :cond_3
    return-object v1

    .line 1145
    .end local v0    # "iS":[B
    .end local v1    # "ret":[B
    .end local v2    # "iK":[B
    .end local v3    # "keyLen":I
    .end local v4    # "j":I
    .end local v5    # "i":I
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "key must be between 1 and 256 bytes"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1143
    :cond_5
    :goto_3
    const/4 v0, 0x0

    return-object v0
.end method

.method private static rsaTemplate([B[BILjava/lang/String;Z)[B
    .locals 15
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "keySize"    # I
    .param p3, "transformation"    # Ljava/lang/String;
    .param p4, "isEncrypt"    # Z

    .line 1081
    move-object v1, p0

    move-object/from16 v2, p1

    const/4 v3, 0x0

    if-eqz v1, :cond_9

    array-length v0, v1

    if-eqz v0, :cond_9

    if-eqz v2, :cond_9

    array-length v0, v2

    if-nez v0, :cond_0

    goto/16 :goto_4

    .line 1087
    :cond_0
    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v4, 0x1c

    const-string v5, "RSA"

    if-ge v0, v4, :cond_1

    .line 1088
    :try_start_1
    const-string v0, "BC"

    invoke-static {v5, v0}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v0

    .local v0, "keyFactory":Ljava/security/KeyFactory;
    goto :goto_0

    .line 1090
    .end local v0    # "keyFactory":Ljava/security/KeyFactory;
    :cond_1
    invoke-static {v5}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v0

    .line 1092
    .restart local v0    # "keyFactory":Ljava/security/KeyFactory;
    :goto_0
    if-eqz p4, :cond_2

    .line 1093
    new-instance v4, Ljava/security/spec/X509EncodedKeySpec;

    invoke-direct {v4, v2}, Ljava/security/spec/X509EncodedKeySpec;-><init>([B)V

    .line 1094
    .local v4, "keySpec":Ljava/security/spec/X509EncodedKeySpec;
    invoke-virtual {v0, v4}, Ljava/security/KeyFactory;->generatePublic(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;

    move-result-object v5

    move-object v4, v5

    .line 1095
    .local v4, "rsaKey":Ljava/security/Key;
    goto :goto_1

    .line 1096
    .end local v4    # "rsaKey":Ljava/security/Key;
    :cond_2
    new-instance v4, Ljava/security/spec/PKCS8EncodedKeySpec;

    invoke-direct {v4, v2}, Ljava/security/spec/PKCS8EncodedKeySpec;-><init>([B)V

    .line 1097
    .local v4, "keySpec":Ljava/security/spec/PKCS8EncodedKeySpec;
    invoke-virtual {v0, v4}, Ljava/security/KeyFactory;->generatePrivate(Ljava/security/spec/KeySpec;)Ljava/security/PrivateKey;

    move-result-object v5

    move-object v4, v5

    .line 1099
    .local v4, "rsaKey":Ljava/security/Key;
    :goto_1
    if-nez v4, :cond_3

    return-object v3

    .line 1100
    :cond_3
    invoke-static/range {p3 .. p3}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v5

    .line 1101
    .local v5, "cipher":Ljavax/crypto/Cipher;
    if-eqz p4, :cond_4

    const/4 v6, 0x1

    goto :goto_2

    :cond_4
    const/4 v6, 0x2

    :goto_2
    invoke-virtual {v5, v6, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 1102
    array-length v6, v1

    .line 1103
    .local v6, "len":I
    div-int/lit8 v7, p2, 0x8

    .line 1104
    .local v7, "maxLen":I
    if-eqz p4, :cond_5

    .line 1105
    invoke-virtual/range {p3 .. p3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v8

    .line 1106
    .local v8, "lowerTrans":Ljava/lang/String;
    const-string v9, "pkcs1padding"

    invoke-virtual {v8, v9}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 1107
    add-int/lit8 v7, v7, -0xb

    .line 1110
    .end local v8    # "lowerTrans":Ljava/lang/String;
    :cond_5
    div-int v8, v6, v7

    .line 1111
    .local v8, "count":I
    if-lez v8, :cond_8

    .line 1112
    const/4 v9, 0x0

    new-array v10, v9, [B

    .line 1113
    .local v10, "ret":[B
    new-array v11, v7, [B

    .line 1114
    .local v11, "buff":[B
    const/4 v12, 0x0

    .line 1115
    .local v12, "index":I
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_3
    if-ge v13, v8, :cond_6

    .line 1116
    invoke-static {p0, v12, v11, v9, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1117
    invoke-virtual {v5, v11}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v14

    invoke-static {v10, v14}, Lcom/blankj/utilcode/util/EncryptUtils;->joins([B[B)[B

    move-result-object v14

    move-object v10, v14

    .line 1118
    add-int/2addr v12, v7

    .line 1115
    add-int/lit8 v13, v13, 0x1

    goto :goto_3

    .line 1120
    .end local v13    # "i":I
    :cond_6
    if-eq v12, v6, :cond_7

    .line 1121
    sub-int v13, v6, v12

    .line 1122
    .local v13, "restLen":I
    new-array v14, v13, [B

    move-object v11, v14

    .line 1123
    invoke-static {p0, v12, v11, v9, v13}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1124
    invoke-virtual {v5, v11}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v9

    invoke-static {v10, v9}, Lcom/blankj/utilcode/util/EncryptUtils;->joins([B[B)[B

    move-result-object v3

    move-object v10, v3

    .line 1126
    .end local v13    # "restLen":I
    :cond_7
    return-object v10

    .line 1128
    .end local v10    # "ret":[B
    .end local v11    # "buff":[B
    .end local v12    # "index":I
    :cond_8
    invoke-virtual {v5, p0}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return-object v3

    .line 1130
    .end local v0    # "keyFactory":Ljava/security/KeyFactory;
    .end local v4    # "rsaKey":Ljava/security/Key;
    .end local v5    # "cipher":Ljavax/crypto/Cipher;
    .end local v6    # "len":I
    .end local v7    # "maxLen":I
    .end local v8    # "count":I
    :catch_0
    move-exception v0

    .line 1131
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 1133
    .end local v0    # "e":Ljava/lang/Exception;
    return-object v3

    .line 1082
    :cond_9
    :goto_4
    return-object v3
.end method

.method private static symmetricTemplate([B[BLjava/lang/String;Ljava/lang/String;[BZ)[B
    .locals 6
    .param p0, "data"    # [B
    .param p1, "key"    # [B
    .param p2, "algorithm"    # Ljava/lang/String;
    .param p3, "transformation"    # Ljava/lang/String;
    .param p4, "iv"    # [B
    .param p5, "isEncrypt"    # Z

    .line 942
    const/4 v0, 0x0

    if-eqz p0, :cond_6

    array-length v1, p0

    if-eqz v1, :cond_6

    if-eqz p1, :cond_6

    array-length v1, p1

    if-nez v1, :cond_0

    goto :goto_5

    .line 945
    :cond_0
    :try_start_0
    const-string v1, "DES"

    invoke-virtual {v1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 946
    new-instance v1, Ljavax/crypto/spec/DESKeySpec;

    invoke-direct {v1, p1}, Ljavax/crypto/spec/DESKeySpec;-><init>([B)V

    .line 947
    .local v1, "desKey":Ljavax/crypto/spec/DESKeySpec;
    invoke-static {p2}, Ljavax/crypto/SecretKeyFactory;->getInstance(Ljava/lang/String;)Ljavax/crypto/SecretKeyFactory;

    move-result-object v2

    .line 948
    .local v2, "keyFactory":Ljavax/crypto/SecretKeyFactory;
    invoke-virtual {v2, v1}, Ljavax/crypto/SecretKeyFactory;->generateSecret(Ljava/security/spec/KeySpec;)Ljavax/crypto/SecretKey;

    move-result-object v3

    move-object v1, v3

    .line 949
    .end local v2    # "keyFactory":Ljavax/crypto/SecretKeyFactory;
    .local v1, "secretKey":Ljavax/crypto/SecretKey;
    goto :goto_0

    .line 950
    .end local v1    # "secretKey":Ljavax/crypto/SecretKey;
    :cond_1
    new-instance v1, Ljavax/crypto/spec/SecretKeySpec;

    invoke-direct {v1, p1, p2}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 952
    .restart local v1    # "secretKey":Ljavax/crypto/SecretKey;
    :goto_0
    invoke-static {p3}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v2

    .line 953
    .local v2, "cipher":Ljavax/crypto/Cipher;
    const/4 v3, 0x1

    const/4 v4, 0x2

    if-eqz p4, :cond_4

    array-length v5, p4

    if-nez v5, :cond_2

    goto :goto_2

    .line 956
    :cond_2
    new-instance v5, Ljavax/crypto/spec/IvParameterSpec;

    invoke-direct {v5, p4}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    .line 957
    .local v5, "params":Ljava/security/spec/AlgorithmParameterSpec;
    if-eqz p5, :cond_3

    goto :goto_1

    :cond_3
    move v3, v4

    :goto_1
    invoke-virtual {v2, v3, v1, v5}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    goto :goto_4

    .line 954
    .end local v5    # "params":Ljava/security/spec/AlgorithmParameterSpec;
    :cond_4
    :goto_2
    if-eqz p5, :cond_5

    goto :goto_3

    :cond_5
    move v3, v4

    :goto_3
    invoke-virtual {v2, v3, v1}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 959
    :goto_4
    invoke-virtual {v2, p0}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    .line 960
    .end local v1    # "secretKey":Ljavax/crypto/SecretKey;
    .end local v2    # "cipher":Ljavax/crypto/Cipher;
    :catchall_0
    move-exception v1

    .line 961
    .local v1, "e":Ljava/lang/Throwable;
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    .line 962
    return-object v0

    .line 942
    .end local v1    # "e":Ljava/lang/Throwable;
    :cond_6
    :goto_5
    return-object v0
.end method
