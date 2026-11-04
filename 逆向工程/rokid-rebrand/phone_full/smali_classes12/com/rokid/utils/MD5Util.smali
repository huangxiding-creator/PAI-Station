.class public Lcom/rokid/utils/MD5Util;
.super Ljava/lang/Object;
.source "MD5Util.java"


# static fields
.field private static final CHARSET_UTF8:Ljava/lang/String; = "UTF-8"

.field private static final SECRET_KEY:Ljava/lang/String; = "secret"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final MD5(Ljava/lang/String;)Ljava/lang/String;
    .locals 11
    .param p0, "pwd"    # Ljava/lang/String;

    .line 76
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    .line 80
    .local v0, "md5String":[C
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    .line 83
    .local v1, "btInput":[B
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 86
    .local v2, "mdInst":Ljava/security/MessageDigest;
    invoke-virtual {v2, v1}, Ljava/security/MessageDigest;->update([B)V

    .line 89
    invoke-virtual {v2}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v3

    .line 92
    .local v3, "md":[B
    array-length v4, v3

    .line 93
    .local v4, "j":I
    mul-int/lit8 v5, v4, 0x2

    new-array v5, v5, [C

    .line 94
    .local v5, "str":[C
    const/4 v6, 0x0

    .line 95
    .local v6, "k":I
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    if-ge v7, v4, :cond_0

    .line 96
    aget-byte v8, v3, v7

    .line 97
    .local v8, "byte0":B
    add-int/lit8 v9, v6, 0x1

    .end local v6    # "k":I
    .local v9, "k":I
    ushr-int/lit8 v10, v8, 0x4

    and-int/lit8 v10, v10, 0xf

    aget-char v10, v0, v10

    aput-char v10, v5, v6

    .line 98
    add-int/lit8 v6, v9, 0x1

    .end local v9    # "k":I
    .restart local v6    # "k":I
    and-int/lit8 v10, v8, 0xf

    aget-char v10, v0, v10

    aput-char v10, v5, v9

    .line 95
    .end local v8    # "byte0":B
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 102
    .end local v7    # "i":I
    :cond_0
    new-instance v7, Ljava/lang/String;

    invoke-direct {v7, v5}, Ljava/lang/String;-><init>([C)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v7

    .line 104
    .end local v1    # "btInput":[B
    .end local v2    # "mdInst":Ljava/security/MessageDigest;
    .end local v3    # "md":[B
    .end local v4    # "j":I
    .end local v5    # "str":[C
    .end local v6    # "k":I
    :catch_0
    move-exception v1

    .line 105
    .local v1, "e":Ljava/lang/Exception;
    const/4 v2, 0x0

    return-object v2

    nop

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
    .end array-data
.end method

.method public static final MD5LowerCase(Ljava/lang/String;)Ljava/lang/String;
    .locals 11
    .param p0, "pwd"    # Ljava/lang/String;

    .line 110
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    .line 113
    .local v0, "md5String":[C
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    .line 114
    .local v1, "btInput":[B
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 115
    .local v2, "mdInst":Ljava/security/MessageDigest;
    invoke-virtual {v2, v1}, Ljava/security/MessageDigest;->update([B)V

    .line 116
    invoke-virtual {v2}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v3

    .line 117
    .local v3, "md":[B
    array-length v4, v3

    .line 118
    .local v4, "j":I
    mul-int/lit8 v5, v4, 0x2

    new-array v5, v5, [C

    .line 119
    .local v5, "str":[C
    const/4 v6, 0x0

    .line 121
    .local v6, "k":I
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    if-ge v7, v4, :cond_0

    .line 122
    aget-byte v8, v3, v7

    .line 123
    .local v8, "byte0":B
    add-int/lit8 v9, v6, 0x1

    .end local v6    # "k":I
    .local v9, "k":I
    ushr-int/lit8 v10, v8, 0x4

    and-int/lit8 v10, v10, 0xf

    aget-char v10, v0, v10

    aput-char v10, v5, v6

    .line 124
    add-int/lit8 v6, v9, 0x1

    .end local v9    # "k":I
    .restart local v6    # "k":I
    and-int/lit8 v10, v8, 0xf

    aget-char v10, v0, v10

    aput-char v10, v5, v9

    .line 121
    .end local v8    # "byte0":B
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 127
    .end local v7    # "i":I
    :cond_0
    new-instance v7, Ljava/lang/String;

    invoke-direct {v7, v5}, Ljava/lang/String;-><init>([C)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v7

    .line 128
    .end local v1    # "btInput":[B
    .end local v2    # "mdInst":Ljava/security/MessageDigest;
    .end local v3    # "md":[B
    .end local v4    # "j":I
    .end local v5    # "str":[C
    .end local v6    # "k":I
    :catch_0
    move-exception v1

    .line 129
    .local v1, "var10":Ljava/lang/Exception;
    const/4 v2, 0x0

    return-object v2

    nop

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
    .end array-data
.end method

.method public static byte2hex([B)Ljava/lang/String;
    .locals 5
    .param p0, "bytes"    # [B

    .line 56
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 57
    .local v0, "sign":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_1

    .line 58
    aget-byte v2, p0, v1

    and-int/lit16 v2, v2, 0xff

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    .line 59
    .local v2, "hex":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_0

    .line 60
    const-string v3, "0"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 62
    :cond_0
    invoke-virtual {v2}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 57
    .end local v2    # "hex":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 64
    .end local v1    # "i":I
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static encryptMD5(Ljava/lang/String;)[B
    .locals 3
    .param p0, "data"    # Ljava/lang/String;

    .line 44
    const/4 v0, 0x0

    .line 46
    .local v0, "bytes":[B
    :try_start_0
    const-string v1, "MD5"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    .line 47
    .local v1, "md":Ljava/security/MessageDigest;
    const-string v2, "UTF-8"

    invoke-virtual {p0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v2
    :try_end_0
    .catch Ljava/security/GeneralSecurityException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v2

    .line 51
    .end local v1    # "md":Ljava/security/MessageDigest;
    :goto_0
    goto :goto_1

    .line 50
    :catch_0
    move-exception v1

    goto :goto_1

    .line 48
    :catch_1
    move-exception v1

    goto :goto_0

    .line 52
    :goto_1
    return-object v0
.end method

.method public static generateMD5(Ljava/util/LinkedHashMap;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "secretValue"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 23
    .local p0, "params":Ljava/util/LinkedHashMap;, "Ljava/util/LinkedHashMap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0}, Ljava/util/LinkedHashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/String;

    invoke-interface {v0, v2}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 26
    .local v0, "keys":[Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 28
    .local v2, "query":Ljava/lang/StringBuilder;
    array-length v3, v0

    :goto_0
    const-string v4, "="

    if-ge v1, v3, :cond_0

    aget-object v5, v0, v1

    .line 29
    .local v5, "key":Ljava/lang/String;
    invoke-virtual {p0, v5}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 30
    .local v6, "value":Ljava/lang/String;
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, "&"

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 28
    .end local v5    # "key":Ljava/lang/String;
    .end local v6    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 33
    :cond_0
    const-string/jumbo v1, "secret"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 37
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/utils/MD5Util;->encryptMD5(Ljava/lang/String;)[B

    move-result-object v1

    .line 40
    .local v1, "bytes":[B
    invoke-static {v1}, Lcom/rokid/utils/MD5Util;->byte2hex([B)Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method public static getMD5String(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "str"    # Ljava/lang/String;

    .line 134
    invoke-static {p0}, Lcom/rokid/utils/MD5Util;->encryptMD5(Ljava/lang/String;)[B

    move-result-object v0

    .line 135
    .local v0, "bytes":[B
    invoke-static {v0}, Lcom/rokid/utils/MD5Util;->byte2hex([B)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
