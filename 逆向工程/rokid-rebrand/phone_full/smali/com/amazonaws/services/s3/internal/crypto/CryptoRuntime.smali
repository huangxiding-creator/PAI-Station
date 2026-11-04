.class public Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;
.super Ljava/lang/Object;
.source "CryptoRuntime.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime$RsaEcbOaepWithSHA256AndMGF1Padding;,
        Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime$AesGcm;
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final BC_PROVIDER_FQCN:Ljava/lang/String; = "org.bouncycastle.jce.provider.BouncyCastleProvider"

.field static final BOUNCY_CASTLE_PROVIDER:Ljava/lang/String; = "BC"

.field private static final LOGGER:Lcom/amazonaws/logging/Log;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 39
    const-class v0, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;->LOGGER:Lcom/amazonaws/logging/Log;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized enableBouncyCastle()V
    .locals 4

    const-class v0, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;

    monitor-enter v0

    .line 53
    :try_start_0
    invoke-static {}, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;->isBouncyCastleAvailable()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    .line 54
    monitor-exit v0

    return-void

    .line 58
    :cond_0
    :try_start_1
    const-string v1, "org.bouncycastle.jce.provider.BouncyCastleProvider"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 59
    .local v1, "c":Ljava/lang/Class;, "Ljava/lang/Class<Ljava/security/Provider;>;"
    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/security/Provider;

    .line 60
    .local v2, "provider":Ljava/security/Provider;
    invoke-static {v2}, Ljava/security/Security;->addProvider(Ljava/security/Provider;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 63
    .end local v1    # "c":Ljava/lang/Class;, "Ljava/lang/Class<Ljava/security/Provider;>;"
    .end local v2    # "provider":Ljava/security/Provider;
    goto :goto_0

    .line 61
    :catch_0
    move-exception v1

    .line 62
    .local v1, "e":Ljava/lang/Exception;
    :try_start_2
    sget-object v2, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;->LOGGER:Lcom/amazonaws/logging/Log;

    const-string v3, "Bouncy Castle not available"

    invoke-interface {v2, v3, v1}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 64
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    monitor-exit v0

    return-void

    .line 52
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static isAesGcmAvailable(Ljava/security/Provider;)Z
    .locals 1
    .param p0, "cryptoProvider"    # Ljava/security/Provider;

    .line 73
    if-eqz p0, :cond_0

    move-object v0, p0

    goto :goto_0

    :cond_0
    const-string v0, "BC"

    invoke-static {v0}, Ljava/security/Security;->getProvider(Ljava/lang/String;)Ljava/security/Provider;

    move-result-object v0

    :goto_0
    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime$AesGcm;->access$000(Ljava/security/Provider;)Z

    move-result v0

    return v0
.end method

.method public static declared-synchronized isBouncyCastleAvailable()Z
    .locals 2

    const-class v0, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;

    monitor-enter v0

    .line 46
    :try_start_0
    const-string v1, "BC"

    invoke-static {v1}, Ljava/security/Security;->getProvider(Ljava/lang/String;)Ljava/security/Provider;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    monitor-exit v0

    return v1

    .line 46
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static isRsaKeyWrapAvailable(Ljava/security/Provider;)Z
    .locals 1
    .param p0, "cryptoProvider"    # Ljava/security/Provider;

    .line 77
    if-eqz p0, :cond_0

    move-object v0, p0

    goto :goto_0

    :cond_0
    const-string v0, "BC"

    invoke-static {v0}, Ljava/security/Security;->getProvider(Ljava/lang/String;)Ljava/security/Provider;

    move-result-object v0

    :goto_0
    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime$RsaEcbOaepWithSHA256AndMGF1Padding;->access$100(Ljava/security/Provider;)Z

    move-result v0

    return v0
.end method
