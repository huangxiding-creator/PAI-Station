.class public Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;
.super Lcom/alibaba/sdk/android/oss/signer/ServiceSignature;
.source "HmacSHA256Signature.java"


# static fields
.field private static final ALGORITHM:Ljava/lang/String; = "HmacSHA256"

.field private static final DEFAULT_ENCODING:Ljava/lang/String; = "UTF-8"

.field private static final LOCK:Ljava/lang/Object;

.field private static final VERSION:Ljava/lang/String; = "1"

.field private static macInstance:Ljavax/crypto/Mac;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 20
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->LOCK:Ljava/lang/Object;

    .line 49
    :try_start_0
    const-string v0, "HmacSHA256"

    invoke-static {v0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->macInstance:Ljavax/crypto/Mac;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 51
    goto :goto_0

    .line 50
    :catchall_0
    move-exception v0

    .line 52
    :goto_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Lcom/alibaba/sdk/android/oss/signer/ServiceSignature;-><init>()V

    return-void
.end method


# virtual methods
.method public computeHash([B[B)[B
    .locals 6
    .param p1, "key"    # [B
    .param p2, "data"    # [B

    .line 44
    sget-object v3, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->macInstance:Ljavax/crypto/Mac;

    sget-object v4, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->LOCK:Ljava/lang/Object;

    const-string v5, "HmacSHA256"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->sign([B[BLjavax/crypto/Mac;Ljava/lang/Object;Ljava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public computeSignature(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;

    .line 35
    const-string v0, "UTF-8"

    :try_start_0
    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    sget-object v4, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->macInstance:Ljavax/crypto/Mac;

    sget-object v5, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->LOCK:Ljava/lang/Object;

    const-string v6, "HmacSHA256"

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lcom/alibaba/sdk/android/oss/signer/HmacSHA256Signature;->sign([B[BLjavax/crypto/Mac;Ljava/lang/Object;Ljava/lang/String;)[B

    move-result-object v0

    .line 37
    .local v0, "signData":[B
    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/utils/BinaryUtil;->toBase64String([B)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 38
    .end local v0    # "signData":[B
    :catch_0
    move-exception v0

    .line 39
    .local v0, "ex":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "Unsupported algorithm: UTF-8"

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getAlgorithm()Ljava/lang/String;
    .locals 1

    .line 26
    const-string v0, "HmacSHA256"

    return-object v0
.end method

.method public getVersion()Ljava/lang/String;
    .locals 1

    .line 30
    const-string v0, "1"

    return-object v0
.end method
