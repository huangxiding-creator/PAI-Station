.class public abstract Lcom/alibaba/sdk/android/oss/signer/ServiceSignature;
.super Ljava/lang/Object;
.source "ServiceSignature.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static create()Lcom/alibaba/sdk/android/oss/signer/ServiceSignature;
    .locals 1

    .line 56
    new-instance v0, Lcom/alibaba/sdk/android/oss/signer/HmacSHA1Signature;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/oss/signer/HmacSHA1Signature;-><init>()V

    return-object v0
.end method

.method public static create(Ljava/lang/String;)Lcom/alibaba/sdk/android/oss/signer/ServiceSignature;
    .locals 3
    .param p0, "algorithm"    # Ljava/lang/String;

    .line 66
    const-string v0, "HmacSHA256"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 67
    new-instance v0, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;-><init>()V

    return-object v0

    .line 68
    :cond_0
    const-string v0, "HmacSHA1"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 69
    new-instance v0, Lcom/alibaba/sdk/android/oss/signer/HmacSHA1Signature;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/oss/signer/HmacSHA1Signature;-><init>()V

    return-object v0

    .line 71
    :cond_1
    new-instance v0, Ljava/lang/RuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unsupported algorithm: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public abstract computeHash([B[B)[B
.end method

.method public abstract computeSignature(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
.end method

.method public abstract getAlgorithm()Ljava/lang/String;
.end method

.method public abstract getVersion()Ljava/lang/String;
.end method

.method protected sign([B[BLjavax/crypto/Mac;Ljava/lang/Object;Ljava/lang/String;)[B
    .locals 4
    .param p1, "key"    # [B
    .param p2, "data"    # [B
    .param p3, "macInstance"    # Ljavax/crypto/Mac;
    .param p4, "lock"    # Ljava/lang/Object;
    .param p5, "algorithm"    # Ljava/lang/String;

    .line 79
    if-nez p3, :cond_1

    .line 80
    :try_start_0
    monitor-enter p4
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    if-nez p3, :cond_0

    .line 82
    :try_start_1
    invoke-static {p5}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v0

    move-object p3, v0

    .line 84
    :cond_0
    monitor-exit p4

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local p1    # "key":[B
    .end local p2    # "data":[B
    .end local p3    # "macInstance":Ljavax/crypto/Mac;
    .end local p4    # "lock":Ljava/lang/Object;
    .end local p5    # "algorithm":Ljava/lang/String;
    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_0

    .line 89
    .restart local p1    # "key":[B
    .restart local p2    # "data":[B
    .restart local p3    # "macInstance":Ljavax/crypto/Mac;
    .restart local p4    # "lock":Ljava/lang/Object;
    .restart local p5    # "algorithm":Ljava/lang/String;
    :cond_1
    :goto_0
    :try_start_3
    invoke-virtual {p3}, Ljavax/crypto/Mac;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljavax/crypto/Mac;
    :try_end_3
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_3 .. :try_end_3} :catch_0

    .line 93
    .local v0, "mac":Ljavax/crypto/Mac;
    goto :goto_1

    .line 98
    .end local v0    # "mac":Ljavax/crypto/Mac;
    :catch_0
    move-exception v0

    goto :goto_2

    .line 96
    :catch_1
    move-exception v0

    goto :goto_3

    .line 90
    :catch_2
    move-exception v0

    .line 92
    .local v0, "e":Ljava/lang/CloneNotSupportedException;
    :try_start_4
    invoke-static {p5}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v1

    move-object v0, v1

    .line 94
    .local v0, "mac":Ljavax/crypto/Mac;
    :goto_1
    new-instance v1, Ljavax/crypto/spec/SecretKeySpec;

    invoke-direct {v1, p1, p5}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    invoke-virtual {v0, v1}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 95
    invoke-virtual {v0, p2}, Ljavax/crypto/Mac;->doFinal([B)[B

    move-result-object v1
    :try_end_4
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_4 .. :try_end_4} :catch_0

    return-object v1

    .line 99
    .local v0, "ex":Ljava/security/InvalidKeyException;
    :goto_2
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid key: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 97
    .local v0, "ex":Ljava/security/NoSuchAlgorithmException;
    :goto_3
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unsupported algorithm: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method
