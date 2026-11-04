.class public Lcom/amazonaws/cognito/clientcontext/util/SignatureGenerator;
.super Ljava/lang/Object;
.source "SignatureGenerator.java"


# static fields
.field private static final ALGORITHM:Ljava/lang/String; = "HmacSHA256"

.field private static final TAG:Ljava/lang/String; = "HMAC_SHA256_Signature"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private logWarning(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;

    .line 66
    const-string v0, "HMAC_SHA256_Signature"

    const-string v1, "Exception while completing context data signature"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 67
    return-void
.end method


# virtual methods
.method public getSignature(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "data"    # Ljava/lang/String;
    .param p2, "secret"    # Ljava/lang/String;
    .param p3, "version"    # Ljava/lang/String;

    .line 48
    const-string v0, "HmacSHA256"

    const-string v1, ""

    .line 50
    .local v1, "signature":Ljava/lang/String;
    :try_start_0
    invoke-static {v0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v2

    .line 51
    .local v2, "sha256Hmac":Ljavax/crypto/Mac;
    new-instance v3, Ljavax/crypto/spec/SecretKeySpec;

    sget-object v4, Lcom/amazonaws/cognito/clientcontext/data/ConfigurationConstant;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-direct {v3, v4, v0}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    move-object v0, v3

    .line 52
    .local v0, "secretKey":Ljavax/crypto/spec/SecretKeySpec;
    invoke-virtual {v2, v0}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 54
    sget-object v3, Lcom/amazonaws/cognito/clientcontext/data/ConfigurationConstant;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    invoke-virtual {p3, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    .line 55
    .local v3, "versionBytes":[B
    invoke-virtual {v2, v3}, Ljavax/crypto/Mac;->update([B)V

    .line 57
    sget-object v4, Lcom/amazonaws/cognito/clientcontext/data/ConfigurationConstant;->DEFAULT_CHARSET:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    .line 58
    .local v4, "dataBytes":[B
    invoke-virtual {v2, v4}, Ljavax/crypto/Mac;->doFinal([B)[B

    move-result-object v5

    const/4 v6, 0x0

    invoke-static {v5, v6}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v5
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v5

    .line 61
    .end local v0    # "secretKey":Ljavax/crypto/spec/SecretKeySpec;
    .end local v2    # "sha256Hmac":Ljavax/crypto/Mac;
    .end local v3    # "versionBytes":[B
    .end local v4    # "dataBytes":[B
    goto :goto_0

    .line 59
    :catch_0
    move-exception v0

    .line 60
    .local v0, "e":Ljava/lang/Exception;
    invoke-direct {p0, v0}, Lcom/amazonaws/cognito/clientcontext/util/SignatureGenerator;->logWarning(Ljava/lang/Exception;)V

    .line 62
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v1
.end method
