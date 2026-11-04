.class public final Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;
.super Ljava/lang/Object;
.source "CryptoUtils.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nCryptoUtils.kt\nKotlin\n*S Kotlin\n*F\n+ 1 CryptoUtils.kt\ncom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,204:1\n1#2:205\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000X\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0012\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0010\u0008\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0008\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u00016B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J*\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\t2\u0006\u0010\u000c\u001a\u00020\t2\n\u0008\u0002\u0010\r\u001a\u0004\u0018\u00010\tJ\"\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\n\u001a\u00020\t2\u0006\u0010\u0010\u001a\u00020\t2\n\u0008\u0002\u0010\r\u001a\u0004\u0018\u00010\tJ\u000e\u0010\u0011\u001a\u00020\u00042\u0006\u0010\u0012\u001a\u00020\tJ\u000e\u0010\u0013\u001a\u00020\t2\u0006\u0010\u0014\u001a\u00020\u0004J\u0016\u0010\u0015\u001a\u00020\t2\u0006\u0010\u0016\u001a\u00020\u00172\u0006\u0010\u0018\u001a\u00020\tJ\u0010\u0010\u0019\u001a\u00020\u001a2\u0008\u0008\u0002\u0010\u001b\u001a\u00020\u0004J\u0006\u0010\u001c\u001a\u00020\u001dJ\u0010\u0010\u001e\u001a\u00020\u001f2\u0008\u0008\u0002\u0010\u001b\u001a\u00020\u0004J\u0010\u0010 \u001a\u00020!2\u0006\u0010\u001b\u001a\u00020\u0004H\u0002J\u0010\u0010\"\u001a\u00020\t2\u0008\u0008\u0002\u0010\u001b\u001a\u00020\u0004J&\u0010#\u001a\u00020\t2\u0006\u0010$\u001a\u00020\t2\u0006\u0010%\u001a\u00020\t2\u0006\u0010&\u001a\u00020\t2\u0006\u0010\'\u001a\u00020(J\u0018\u0010)\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\t2\u0006\u0010*\u001a\u00020\tH\u0002J\u0010\u0010+\u001a\u00020\u001a2\u0008\u0008\u0002\u0010\u001b\u001a\u00020\u0004J\u0012\u0010,\u001a\u00020\u001a2\u0008\u0010-\u001a\u0004\u0018\u00010!H\u0002J\u0008\u0010.\u001a\u00020/H\u0002J\u001a\u00100\u001a\u0004\u0018\u00010!2\u0006\u00101\u001a\u00020/2\u0006\u0010\u001b\u001a\u00020\u0004H\u0002J\u0018\u00102\u001a\u00020\t2\u0006\u0010*\u001a\u00020\t2\u0008\u0008\u0002\u0010\u001b\u001a\u00020\u0004J\u001e\u00103\u001a\u00020\u001a2\u0006\u00104\u001a\u00020\t2\u0006\u0010*\u001a\u00020\t2\u0006\u00105\u001a\u00020\tR\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u00067"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;",
        "",
        "()V",
        "CURVE",
        "",
        "KDF_INFO",
        "KEY_ALIAS",
        "SIGN_ALGO",
        "aesGcmDecrypt",
        "",
        "key",
        "iv",
        "ciphertext",
        "aad",
        "aesGcmEncrypt",
        "Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;",
        "plaintext",
        "b64",
        "bytes",
        "b64d",
        "str",
        "computeSharedSecret",
        "myPriv",
        "Ljava/security/PrivateKey;",
        "peerPubBytes",
        "ensureKeystoreKeyPair",
        "",
        "alias",
        "generateEphemeralKeyPair",
        "Ljava/security/KeyPair;",
        "generateKeystoreKeyPair",
        "",
        "getKeystorePrivateKeyEntry",
        "Ljava/security/KeyStore$PrivateKeyEntry;",
        "getKeystorePublicKeyBytes",
        "hkdfSha256",
        "sharedSecret",
        "salt",
        "info",
        "keyLen",
        "",
        "hmacSha256",
        "data",
        "isKeyPairExists",
        "isUsablePrivateKeyEntry",
        "entry",
        "loadAndroidKeyStore",
        "Ljava/security/KeyStore;",
        "privateKeyEntryOrNull",
        "keyStore",
        "signWithKeystore",
        "verifySignature",
        "pubBytes",
        "signature",
        "AesGcmPacket",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final CURVE:Ljava/lang/String; = "secp256r1"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

.field public static final KDF_INFO:Ljava/lang/String; = "BT-Session"

.field public static final KEY_ALIAS:Ljava/lang/String; = "security_longterm_sign_key"

.field public static final SIGN_ALGO:Ljava/lang/String; = "SHA256withECDSA"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic aesGcmDecrypt$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;[B[B[B[BILjava/lang/Object;)[B
    .locals 0

    .line 187
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_0

    const/4 p4, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->aesGcmDecrypt([B[B[B[B)[B

    move-result-object p0

    return-object p0
.end method

.method public static synthetic aesGcmEncrypt$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;[B[B[BILjava/lang/Object;)Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;
    .locals 0

    .line 175
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_0

    const/4 p3, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->aesGcmEncrypt([B[B[B)Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic ensureKeystoreKeyPair$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;Ljava/lang/String;ILjava/lang/Object;)Z
    .locals 0

    .line 37
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const-string/jumbo p1, "security_longterm_sign_key"

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->ensureKeystoreKeyPair(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public static synthetic generateKeystoreKeyPair$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 0

    .line 23
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const-string/jumbo p1, "security_longterm_sign_key"

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->generateKeystoreKeyPair(Ljava/lang/String;)V

    return-void
.end method

.method private final declared-synchronized getKeystorePrivateKeyEntry(Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;
    .locals 3
    .param p1, "alias"    # Ljava/lang/String;

    monitor-enter p0

    .line 84
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->ensureKeystoreKeyPair(Ljava/lang/String;)Z

    .line 85
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->loadAndroidKeyStore()Ljava/security/KeyStore;

    move-result-object v0

    invoke-direct {p0, v0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->privateKeyEntryOrNull(Ljava/security/KeyStore;Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    monitor-exit p0

    return-object v0

    :cond_0
    :try_start_1
    new-instance v0, Ljava/lang/IllegalStateException;

    .line 86
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AndroidKeyStore private key entry missing for alias "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 83
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;
    .end local p1    # "alias":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public static synthetic getKeystorePublicKeyBytes$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;Ljava/lang/String;ILjava/lang/Object;)[B
    .locals 0

    .line 68
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const-string/jumbo p1, "security_longterm_sign_key"

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->getKeystorePublicKeyBytes(Ljava/lang/String;)[B

    move-result-object p0

    return-object p0
.end method

.method private final hmacSha256([B[B)[B
    .locals 4
    .param p1, "key"    # [B
    .param p2, "data"    # [B

    .line 166
    const-string v0, "HmacSHA256"

    invoke-static {v0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v1

    .line 167
    .local v1, "mac":Ljavax/crypto/Mac;
    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    invoke-direct {v2, p1, v0}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    move-object v0, v2

    .line 168
    .local v0, "keySpec":Ljavax/crypto/spec/SecretKeySpec;
    move-object v2, v0

    check-cast v2, Ljava/security/Key;

    invoke-virtual {v1, v2}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 169
    invoke-virtual {v1, p2}, Ljavax/crypto/Mac;->doFinal([B)[B

    move-result-object v2

    const-string v3, "mac.doFinal(data)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method

.method public static synthetic isKeyPairExists$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;Ljava/lang/String;ILjava/lang/Object;)Z
    .locals 0

    .line 58
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const-string/jumbo p1, "security_longterm_sign_key"

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->isKeyPairExists(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method private final isUsablePrivateKeyEntry(Ljava/security/KeyStore$PrivateKeyEntry;)Z
    .locals 2
    .param p1, "entry"    # Ljava/security/KeyStore$PrivateKeyEntry;

    .line 105
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/security/KeyStore$PrivateKeyEntry;->getPrivateKey()Ljava/security/PrivateKey;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    if-eqz v1, :cond_2

    invoke-virtual {p1}, Ljava/security/KeyStore$PrivateKeyEntry;->getCertificate()Ljava/security/cert/Certificate;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v0

    :cond_1
    if-eqz v0, :cond_2

    const/4 v0, 0x1

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    :goto_1
    return v0
.end method

.method private final loadAndroidKeyStore()Ljava/security/KeyStore;
    .locals 4

    .line 90
    const-string v0, "AndroidKeyStore"

    invoke-static {v0}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v0

    move-object v1, v0

    .line 205
    .local v1, "$this$loadAndroidKeyStore_u24lambda_u241":Ljava/security/KeyStore;
    const/4 v2, 0x0

    .line 90
    .local v2, "$i$a$-apply-CryptoUtils$loadAndroidKeyStore$1":I
    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .end local v1    # "$this$loadAndroidKeyStore_u24lambda_u241":Ljava/security/KeyStore;
    .end local v2    # "$i$a$-apply-CryptoUtils$loadAndroidKeyStore$1":I
    const-string v1, "getInstance(\"AndroidKeyS\u2026re\").apply { load(null) }"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method private final privateKeyEntryOrNull(Ljava/security/KeyStore;Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;
    .locals 3
    .param p1, "keyStore"    # Ljava/security/KeyStore;
    .param p2, "alias"    # Ljava/lang/String;

    .line 97
    nop

    .line 98
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, p2, v0}, Ljava/security/KeyStore;->getEntry(Ljava/lang/String;Ljava/security/KeyStore$ProtectionParameter;)Ljava/security/KeyStore$Entry;

    move-result-object v1

    instance-of v2, v1, Ljava/security/KeyStore$PrivateKeyEntry;

    if-eqz v2, :cond_0

    check-cast v1, Ljava/security/KeyStore$PrivateKeyEntry;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    goto :goto_0

    .line 99
    :catch_0
    move-exception v1

    .line 100
    .local v1, "e":Ljava/lang/Exception;
    nop

    .line 97
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-object v0
.end method

.method public static synthetic signWithKeystore$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;[BLjava/lang/String;ILjava/lang/Object;)[B
    .locals 0

    .line 74
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const-string/jumbo p2, "security_longterm_sign_key"

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->signWithKeystore([BLjava/lang/String;)[B

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final aesGcmDecrypt([B[B[B[B)[B
    .locals 6
    .param p1, "key"    # [B
    .param p2, "iv"    # [B
    .param p3, "ciphertext"    # [B
    .param p4, "aad"    # [B

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "iv"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "ciphertext"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 188
    const-string v0, "AES/GCM/NoPadding"

    invoke-static {v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    .line 189
    .local v0, "cipher":Ljavax/crypto/Cipher;
    new-instance v1, Ljavax/crypto/spec/GCMParameterSpec;

    const/16 v2, 0x80

    invoke-direct {v1, v2, p2}, Ljavax/crypto/spec/GCMParameterSpec;-><init>(I[B)V

    .line 190
    .local v1, "spec":Ljavax/crypto/spec/GCMParameterSpec;
    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    const-string v3, "AES"

    invoke-direct {v2, p1, v3}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 191
    .local v2, "sk":Ljavax/crypto/spec/SecretKeySpec;
    move-object v3, v2

    check-cast v3, Ljava/security/Key;

    move-object v4, v1

    check-cast v4, Ljava/security/spec/AlgorithmParameterSpec;

    const/4 v5, 0x2

    invoke-virtual {v0, v5, v3, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 192
    if-eqz p4, :cond_0

    invoke-virtual {v0, p4}, Ljavax/crypto/Cipher;->updateAAD([B)V

    .line 193
    :cond_0
    invoke-virtual {v0, p3}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v3

    const-string v4, "cipher.doFinal(ciphertext)"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v3
.end method

.method public final aesGcmEncrypt([B[B[B)Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;
    .locals 12
    .param p1, "key"    # [B
    .param p2, "plaintext"    # [B
    .param p3, "aad"    # [B

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "plaintext"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 176
    const-string v0, "AES/GCM/NoPadding"

    invoke-static {v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    .line 177
    .local v0, "cipher":Ljavax/crypto/Cipher;
    const/16 v1, 0xc

    new-array v1, v1, [B

    .line 178
    .local v1, "iv":[B
    new-instance v2, Ljava/security/SecureRandom;

    invoke-direct {v2}, Ljava/security/SecureRandom;-><init>()V

    invoke-virtual {v2, v1}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 179
    new-instance v2, Ljavax/crypto/spec/GCMParameterSpec;

    const/16 v3, 0x80

    invoke-direct {v2, v3, v1}, Ljavax/crypto/spec/GCMParameterSpec;-><init>(I[B)V

    move-object v8, v2

    .line 180
    .local v8, "spec":Ljavax/crypto/spec/GCMParameterSpec;
    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    const-string v3, "AES"

    invoke-direct {v2, p1, v3}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    move-object v9, v2

    .line 181
    .local v9, "sk":Ljavax/crypto/spec/SecretKeySpec;
    move-object v2, v9

    check-cast v2, Ljava/security/Key;

    move-object v3, v8

    check-cast v3, Ljava/security/spec/AlgorithmParameterSpec;

    const/4 v4, 0x1

    invoke-virtual {v0, v4, v2, v3}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 182
    if-eqz p3, :cond_0

    invoke-virtual {v0, p3}, Ljavax/crypto/Cipher;->updateAAD([B)V

    .line 183
    :cond_0
    invoke-virtual {v0, p2}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v10

    .line 184
    .local v10, "ct":[B
    new-instance v11, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;

    const-string v2, "ct"

    invoke-static {v10, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v6, 0x4

    const/4 v7, 0x0

    const/4 v5, 0x0

    move-object v2, v11

    move-object v3, v1

    move-object v4, v10

    invoke-direct/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;-><init>([B[BIILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v11
.end method

.method public final b64([B)Ljava/lang/String;
    .locals 2
    .param p1, "bytes"    # [B

    const-string v0, "bytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 198
    const/4 v0, 0x2

    invoke-static {p1, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    const-string v1, "encodeToString(bytes, android.util.Base64.NO_WRAP)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public final b64d(Ljava/lang/String;)[B
    .locals 2
    .param p1, "str"    # Ljava/lang/String;

    const-string/jumbo v0, "str"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 201
    const/4 v0, 0x0

    invoke-static {p1, v0}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v0

    const-string v1, "decode(str, android.util.Base64.DEFAULT)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public final computeSharedSecret(Ljava/security/PrivateKey;[B)[B
    .locals 5
    .param p1, "myPriv"    # Ljava/security/PrivateKey;
    .param p2, "peerPubBytes"    # [B

    const-string v0, "myPriv"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "peerPubBytes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 134
    const-string v0, "EC"

    invoke-static {v0}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v0

    .line 135
    .local v0, "kf":Ljava/security/KeyFactory;
    new-instance v1, Ljava/security/spec/X509EncodedKeySpec;

    invoke-direct {v1, p2}, Ljava/security/spec/X509EncodedKeySpec;-><init>([B)V

    check-cast v1, Ljava/security/spec/KeySpec;

    invoke-virtual {v0, v1}, Ljava/security/KeyFactory;->generatePublic(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;

    move-result-object v1

    .line 136
    .local v1, "peerPub":Ljava/security/PublicKey;
    const-string v2, "ECDH"

    invoke-static {v2}, Ljavax/crypto/KeyAgreement;->getInstance(Ljava/lang/String;)Ljavax/crypto/KeyAgreement;

    move-result-object v2

    .line 137
    .local v2, "ka":Ljavax/crypto/KeyAgreement;
    move-object v3, p1

    check-cast v3, Ljava/security/Key;

    invoke-virtual {v2, v3}, Ljavax/crypto/KeyAgreement;->init(Ljava/security/Key;)V

    .line 138
    move-object v3, v1

    check-cast v3, Ljava/security/Key;

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Ljavax/crypto/KeyAgreement;->doPhase(Ljava/security/Key;Z)Ljava/security/Key;

    .line 139
    invoke-virtual {v2}, Ljavax/crypto/KeyAgreement;->generateSecret()[B

    move-result-object v3

    const-string v4, "ka.generateSecret()"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v3
.end method

.method public final declared-synchronized ensureKeystoreKeyPair(Ljava/lang/String;)Z
    .locals 5
    .param p1, "alias"    # Ljava/lang/String;

    monitor-enter p0

    :try_start_0
    const-string v0, "alias"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->loadAndroidKeyStore()Ljava/security/KeyStore;

    move-result-object v0

    .line 39
    .local v0, "keyStore":Ljava/security/KeyStore;
    invoke-direct {p0, v0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->privateKeyEntryOrNull(Ljava/security/KeyStore;Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->isUsablePrivateKeyEntry(Ljava/security/KeyStore$PrivateKeyEntry;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    .line 40
    monitor-exit p0

    const/4 v1, 0x0

    return v1

    .line 43
    :cond_0
    :try_start_1
    invoke-virtual {v0, p1}, Ljava/security/KeyStore;->containsAlias(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 44
    invoke-virtual {v0, p1}, Ljava/security/KeyStore;->deleteEntry(Ljava/lang/String;)V

    .line 46
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;
    :cond_1
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->generateKeystoreKeyPair(Ljava/lang/String;)V

    .line 48
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->loadAndroidKeyStore()Ljava/security/KeyStore;

    move-result-object v1

    invoke-direct {p0, v1, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->privateKeyEntryOrNull(Ljava/security/KeyStore;Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;

    move-result-object v1

    .line 49
    .local v1, "checkedEntry":Ljava/security/KeyStore$PrivateKeyEntry;
    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->isUsablePrivateKeyEntry(Ljava/security/KeyStore$PrivateKeyEntry;)Z

    move-result v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v2, :cond_2

    .line 52
    monitor-exit p0

    const/4 v2, 0x1

    return v2

    .line 49
    :cond_2
    const/4 v2, 0x0

    .line 50
    .local v2, "$i$a$-check-CryptoUtils$ensureKeystoreKeyPair$1":I
    :try_start_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "AndroidKeyStore entry unavailable after generating alias "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 49
    .end local v2    # "$i$a$-check-CryptoUtils$ensureKeystoreKeyPair$1":I
    new-instance v2, Ljava/lang/IllegalStateException;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 37
    .end local v0    # "keyStore":Ljava/security/KeyStore;
    .end local v1    # "checkedEntry":Ljava/security/KeyStore$PrivateKeyEntry;
    .end local p1    # "alias":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final generateEphemeralKeyPair()Ljava/security/KeyPair;
    .locals 4

    .line 126
    const-string v0, "EC"

    invoke-static {v0}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;)Ljava/security/KeyPairGenerator;

    move-result-object v0

    .line 127
    .local v0, "kpg":Ljava/security/KeyPairGenerator;
    new-instance v1, Ljava/security/spec/ECGenParameterSpec;

    const-string/jumbo v2, "secp256r1"

    invoke-direct {v1, v2}, Ljava/security/spec/ECGenParameterSpec;-><init>(Ljava/lang/String;)V

    .line 128
    .local v1, "ecSpec":Ljava/security/spec/ECGenParameterSpec;
    move-object v2, v1

    check-cast v2, Ljava/security/spec/AlgorithmParameterSpec;

    invoke-virtual {v0, v2}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 129
    invoke-virtual {v0}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;

    move-result-object v2

    const-string v3, "kpg.generateKeyPair()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method

.method public final generateKeystoreKeyPair(Ljava/lang/String;)V
    .locals 6
    .param p1, "alias"    # Ljava/lang/String;

    const-string v0, "alias"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    const-string v0, "EC"

    const-string v1, "AndroidKeyStore"

    invoke-static {v0, v1}, Ljava/security/KeyPairGenerator;->getInstance(Ljava/lang/String;Ljava/lang/String;)Ljava/security/KeyPairGenerator;

    move-result-object v0

    .line 25
    .local v0, "kpg":Ljava/security/KeyPairGenerator;
    new-instance v1, Landroid/security/keystore/KeyGenParameterSpec$Builder;

    .line 26
    nop

    .line 27
    nop

    .line 25
    const/16 v2, 0xc

    invoke-direct {v1, p1, v2}, Landroid/security/keystore/KeyGenParameterSpec$Builder;-><init>(Ljava/lang/String;I)V

    .line 29
    new-instance v2, Ljava/security/spec/ECGenParameterSpec;

    const-string/jumbo v3, "secp256r1"

    invoke-direct {v2, v3}, Ljava/security/spec/ECGenParameterSpec;-><init>(Ljava/lang/String;)V

    check-cast v2, Ljava/security/spec/AlgorithmParameterSpec;

    invoke-virtual {v1, v2}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->setAlgorithmParameterSpec(Ljava/security/spec/AlgorithmParameterSpec;)Landroid/security/keystore/KeyGenParameterSpec$Builder;

    move-result-object v1

    .line 30
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "SHA-256"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const/4 v3, 0x1

    const-string v5, "SHA-512"

    aput-object v5, v2, v3

    invoke-virtual {v1, v2}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->setDigests([Ljava/lang/String;)Landroid/security/keystore/KeyGenParameterSpec$Builder;

    move-result-object v1

    .line 31
    invoke-virtual {v1, v4}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->setUserAuthenticationRequired(Z)Landroid/security/keystore/KeyGenParameterSpec$Builder;

    move-result-object v1

    const-string v2, "Builder(\n            ali\u2026enticationRequired(false)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    nop

    .line 32
    .local v1, "builder":Landroid/security/keystore/KeyGenParameterSpec$Builder;
    invoke-virtual {v1}, Landroid/security/keystore/KeyGenParameterSpec$Builder;->build()Landroid/security/keystore/KeyGenParameterSpec;

    move-result-object v2

    check-cast v2, Ljava/security/spec/AlgorithmParameterSpec;

    invoke-virtual {v0, v2}, Ljava/security/KeyPairGenerator;->initialize(Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 33
    invoke-virtual {v0}, Ljava/security/KeyPairGenerator;->generateKeyPair()Ljava/security/KeyPair;

    .line 34
    return-void
.end method

.method public final getKeystorePublicKeyBytes(Ljava/lang/String;)[B
    .locals 3
    .param p1, "alias"    # Ljava/lang/String;

    const-string v0, "alias"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->getKeystorePrivateKeyEntry(Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;

    move-result-object v0

    .line 70
    .local v0, "entry":Ljava/security/KeyStore$PrivateKeyEntry;
    invoke-virtual {v0}, Ljava/security/KeyStore$PrivateKeyEntry;->getCertificate()Ljava/security/cert/Certificate;

    move-result-object v1

    invoke-virtual {v1}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v1

    invoke-interface {v1}, Ljava/security/PublicKey;->getEncoded()[B

    move-result-object v1

    const-string v2, "entry.certificate.publicKey.encoded"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v1
.end method

.method public final hkdfSha256([B[B[BI)[B
    .locals 9
    .param p1, "sharedSecret"    # [B
    .param p2, "salt"    # [B
    .param p3, "info"    # [B
    .param p4, "keyLen"    # I

    const-string/jumbo v0, "sharedSecret"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "salt"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "info"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 145
    invoke-direct {p0, p2, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->hmacSha256([B[B)[B

    move-result-object v0

    .line 147
    .local v0, "prk":[B
    new-array v1, p4, [B

    .line 148
    .local v1, "result":[B
    const/4 v2, 0x0

    new-array v3, v2, [B

    .line 149
    .local v3, "t":[B
    const/4 v4, 0x0

    .line 150
    .local v4, "offset":I
    const/4 v5, 0x1

    .line 151
    .local v5, "counter":B
    :goto_0
    if-ge v4, p4, :cond_0

    .line 152
    array-length v6, v3

    array-length v7, p3

    add-int/2addr v6, v7

    add-int/lit8 v6, v6, 0x1

    new-array v6, v6, [B

    .line 153
    .local v6, "input":[B
    array-length v7, v3

    invoke-static {v3, v2, v6, v2, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 154
    array-length v7, v3

    array-length v8, p3

    invoke-static {p3, v2, v6, v7, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 155
    array-length v7, v6

    add-int/lit8 v7, v7, -0x1

    aput-byte v5, v6, v7

    .line 156
    invoke-direct {p0, v0, v6}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->hmacSha256([B[B)[B

    move-result-object v3

    .line 157
    array-length v7, v3

    sub-int v8, p4, v4

    invoke-static {v7, v8}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 158
    .local v7, "toCopy":I
    invoke-static {v3, v2, v1, v4, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 159
    add-int/2addr v4, v7

    .line 160
    add-int/lit8 v8, v5, 0x1

    int-to-byte v5, v8

    .end local v6    # "input":[B
    .end local v7    # "toCopy":I
    goto :goto_0

    .line 162
    :cond_0
    return-object v1
.end method

.method public final isKeyPairExists(Ljava/lang/String;)Z
    .locals 2
    .param p1, "alias"    # Ljava/lang/String;

    const-string v0, "alias"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    nop

    .line 60
    :try_start_0
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->loadAndroidKeyStore()Ljava/security/KeyStore;

    move-result-object v0

    invoke-direct {p0, v0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->privateKeyEntryOrNull(Ljava/security/KeyStore;Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->isUsablePrivateKeyEntry(Ljava/security/KeyStore$PrivateKeyEntry;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 61
    :catch_0
    move-exception v0

    .line 63
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    move v0, v1

    .line 59
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return v0
.end method

.method public final signWithKeystore([BLjava/lang/String;)[B
    .locals 4
    .param p1, "data"    # [B
    .param p2, "alias"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "alias"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 75
    invoke-direct {p0, p2}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->getKeystorePrivateKeyEntry(Ljava/lang/String;)Ljava/security/KeyStore$PrivateKeyEntry;

    move-result-object v0

    invoke-virtual {v0}, Ljava/security/KeyStore$PrivateKeyEntry;->getPrivateKey()Ljava/security/PrivateKey;

    move-result-object v0

    .line 76
    .local v0, "priv":Ljava/security/PrivateKey;
    const-string v1, "SHA256withECDSA"

    invoke-static {v1}, Ljava/security/Signature;->getInstance(Ljava/lang/String;)Ljava/security/Signature;

    move-result-object v1

    .line 77
    .local v1, "sig":Ljava/security/Signature;
    invoke-virtual {v1, v0}, Ljava/security/Signature;->initSign(Ljava/security/PrivateKey;)V

    .line 78
    invoke-virtual {v1, p1}, Ljava/security/Signature;->update([B)V

    .line 79
    invoke-virtual {v1}, Ljava/security/Signature;->sign()[B

    move-result-object v2

    const-string/jumbo v3, "sig.sign()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method

.method public final verifySignature([B[B[B)Z
    .locals 4
    .param p1, "pubBytes"    # [B
    .param p2, "data"    # [B
    .param p3, "signature"    # [B

    const-string v0, "pubBytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "signature"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 110
    nop

    .line 111
    :try_start_0
    const-string v0, "EC"

    invoke-static {v0}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v0

    .line 112
    .local v0, "kf":Ljava/security/KeyFactory;
    new-instance v1, Ljava/security/spec/X509EncodedKeySpec;

    invoke-direct {v1, p1}, Ljava/security/spec/X509EncodedKeySpec;-><init>([B)V

    check-cast v1, Ljava/security/spec/KeySpec;

    invoke-virtual {v0, v1}, Ljava/security/KeyFactory;->generatePublic(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;

    move-result-object v1

    .line 113
    .local v1, "pub":Ljava/security/PublicKey;
    const-string v2, "SHA256withECDSA"

    invoke-static {v2}, Ljava/security/Signature;->getInstance(Ljava/lang/String;)Ljava/security/Signature;

    move-result-object v2

    .line 114
    .local v2, "sig":Ljava/security/Signature;
    invoke-virtual {v2, v1}, Ljava/security/Signature;->initVerify(Ljava/security/PublicKey;)V

    .line 115
    invoke-virtual {v2, p2}, Ljava/security/Signature;->update([B)V

    .line 116
    invoke-virtual {v2, p3}, Ljava/security/Signature;->verify([B)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v3

    .line 117
    .end local v0    # "kf":Ljava/security/KeyFactory;
    .end local v1    # "pub":Ljava/security/PublicKey;
    .end local v2    # "sig":Ljava/security/Signature;
    :catch_0
    move-exception v0

    .line 118
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "-->"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "verifySignature"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 119
    const/4 v1, 0x0

    return v1
.end method
