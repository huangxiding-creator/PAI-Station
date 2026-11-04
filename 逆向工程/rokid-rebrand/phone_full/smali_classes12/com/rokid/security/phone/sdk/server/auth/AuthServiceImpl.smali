.class public final Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/auth/api/AbsAuthService;
.source "AuthServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAuthServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AuthServiceImpl.kt\ncom/rokid/security/phone/sdk/server/auth/AuthServiceImpl\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 4 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n*L\n1#1,445:1\n1855#2,2:446\n1855#2,2:456\n1855#2,2:458\n1#3:448\n22048#4,5:449\n13579#4,2:454\n*S KotlinDebug\n*F\n+ 1 AuthServiceImpl.kt\ncom/rokid/security/phone/sdk/server/auth/AuthServiceImpl\n*L\n155#1:446,2\n398#1:456,2\n406#1:458,2\n386#1:449,5\n389#1:454,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000^\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0008\u0003\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0011\n\u0002\u0008\u0004\n\u0002\u0010\u0008\n\u0002\u0008\u0015*\u0002\u000c\u000f\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u001a\u001a\u00020\u001b2\u0006\u0010\u001c\u001a\u00020\nJ!\u0010\u001d\u001a\u00020\u00122\u0012\u0010\u001e\u001a\n\u0012\u0006\u0008\u0001\u0012\u00020\u00120\u001f\"\u00020\u0012H\u0002\u00a2\u0006\u0002\u0010 J\u0018\u0010!\u001a\u00020\u001b2\u0006\u0010\"\u001a\u00020\u00042\u0006\u0010#\u001a\u00020$H\u0002J\u0008\u0010%\u001a\u00020\u001bH\u0002J\u0008\u0010&\u001a\u00020\u001bH\u0002J\u0010\u0010\'\u001a\u00020\u001b2\u0006\u0010(\u001a\u00020\u0004H\u0002J\u0006\u0010)\u001a\u00020\u001bJ\u0006\u0010*\u001a\u00020\u0007J\u0010\u0010+\u001a\u00020\u001b2\u0006\u0010,\u001a\u00020\u0004H\u0002J\u0006\u0010-\u001a\u00020\u001bJ\u000e\u0010.\u001a\u00020\u001b2\u0006\u0010\u001c\u001a\u00020\nJ&\u0010/\u001a\u00020\u001b2\u0006\u00100\u001a\u00020\u00072\n\u0008\u0002\u0010\"\u001a\u0004\u0018\u00010\u00042\u0008\u0008\u0002\u0010#\u001a\u00020$H\u0002J\u0010\u00101\u001a\u00020\u001b2\u0006\u00102\u001a\u00020\u0016H\u0002J\u0008\u00103\u001a\u00020\u001bH\u0002J\u0008\u00104\u001a\u00020\u001bH\u0002J \u00105\u001a\u00020\u001b2\u0006\u0010(\u001a\u00020\u00042\u0006\u00106\u001a\u00020\u00042\u0006\u00107\u001a\u00020\u0004H\u0002J\u0008\u00108\u001a\u00020\u001bH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0008\u001a\u0008\u0012\u0004\u0012\u00020\n0\tX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000b\u001a\u00020\u000cX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\rR\u0010\u0010\u000e\u001a\u00020\u000fX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0010R\u0010\u0010\u0011\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0013\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0014\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0015\u001a\u0004\u0018\u00010\u0016X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0017\u001a\u0004\u0018\u00010\u0018X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0019\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u00069"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/auth/api/AbsAuthService;",
        "()V",
        "GLASS3_SUBTYPE",
        "",
        "TAG",
        "isAuthSuccess",
        "",
        "mIAuthListeners",
        "",
        "Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;",
        "mIClassicClientListener",
        "com/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1",
        "Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1;",
        "mNonceGlass",
        "",
        "mNoncePhone",
        "mNoncePhoneB64",
        "mPubKeyInfo",
        "Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;",
        "myEph",
        "Ljava/security/KeyPair;",
        "sessionKey",
        "addAuthListener",
        "",
        "listener",
        "concat",
        "parts",
        "",
        "([[B)[B",
        "deviceAuthFail",
        "errorMsg",
        "errorCode",
        "",
        "deviceAuthSuccess",
        "generateAndSendPubKey",
        "generateSignature",
        "nonceGlassB64",
        "init",
        "isAuthenticated",
        "parseMessage",
        "msg",
        "release",
        "removeAuthListener",
        "sendDeviceAuthResultMsg",
        "isSuccess",
        "sendPublicKeyMsg",
        "info",
        "sendPublicKeyOkMsg",
        "sendReceivePublicKeyReplyMsg",
        "sendSignMsg",
        "noncePhoneB64",
        "signature",
        "sendSignOkMsg",
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
.field private static final GLASS3_SUBTYPE:Ljava/lang/String; = "ab9d547e319c93b462d866055ddb31c1"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

.field private static final TAG:Ljava/lang/String; = "AuthServiceImpl"

.field private static volatile isAuthSuccess:Z

.field private static final mIAuthListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;",
            ">;"
        }
    .end annotation
.end field

.field private static final mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1;

.field private static mNonceGlass:[B

.field private static mNoncePhone:[B

.field private static mNoncePhoneB64:Ljava/lang/String;

.field private static mPubKeyInfo:Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

.field private static myEph:Ljava/security/KeyPair;

.field private static sessionKey:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    .line 54
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIAuthListeners:Ljava/util/Set;

    .line 56
    new-instance v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1;

    .line 204
    new-instance v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/auth/api/AbsAuthService;-><init>()V

    return-void
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;
    .param p1, "msg"    # Ljava/lang/String;

    .line 42
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$setAuthSuccess$p(Z)V
    .locals 0
    .param p0, "<set-?>"    # Z

    .line 42
    sput-boolean p0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthSuccess:Z

    return-void
.end method

.method public static final synthetic access$setMPubKeyInfo$p(Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;)V
    .locals 0
    .param p0, "<set-?>"    # Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    .line 42
    sput-object p0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mPubKeyInfo:Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    return-void
.end method

.method public static final synthetic access$setSessionKey$p([B)V
    .locals 0
    .param p0, "<set-?>"    # [B

    .line 42
    sput-object p0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sessionKey:[B

    return-void
.end method

.method private final varargs concat([[B)[B
    .locals 12
    .param p1, "parts"    # [[B

    .line 386
    move-object v0, p1

    check-cast v0, [Ljava/lang/Object;

    .local v0, "$this$sumBy$iv":[Ljava/lang/Object;
    const/4 v1, 0x0

    .line 449
    .local v1, "$i$f$sumBy":I
    const/4 v2, 0x0

    .line 450
    .local v2, "sum$iv":I
    array-length v3, v0

    const/4 v4, 0x0

    move v5, v4

    :goto_0
    if-ge v5, v3, :cond_0

    aget-object v6, v0, v5

    .line 451
    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, [B

    .local v7, "it":[B
    const/4 v8, 0x0

    .line 386
    .local v8, "$i$a$-sumBy-AuthServiceImpl$concat$total$1":I
    array-length v7, v7

    .line 451
    .end local v7    # "it":[B
    .end local v8    # "$i$a$-sumBy-AuthServiceImpl$concat$total$1":I
    add-int/2addr v2, v7

    .line 450
    .end local v6    # "element$iv":Ljava/lang/Object;
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 453
    :cond_0
    nop

    .line 386
    .end local v0    # "$this$sumBy$iv":[Ljava/lang/Object;
    .end local v1    # "$i$f$sumBy":I
    .end local v2    # "sum$iv":I
    move v0, v2

    .line 387
    .local v0, "total":I
    new-array v1, v0, [B

    .line 388
    .local v1, "out":[B
    const/4 v2, 0x0

    .line 389
    .local v2, "pos":I
    move-object v3, p1

    check-cast v3, [Ljava/lang/Object;

    .local v3, "$this$forEach$iv":[Ljava/lang/Object;
    const/4 v5, 0x0

    .line 454
    .local v5, "$i$f$forEach":I
    array-length v6, v3

    move v7, v4

    :goto_1
    if-ge v7, v6, :cond_1

    aget-object v8, v3, v7

    .local v8, "element$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, [B

    .local v9, "it":[B
    const/4 v10, 0x0

    .line 390
    .local v10, "$i$a$-forEach-AuthServiceImpl$concat$1":I
    array-length v11, v9

    invoke-static {v9, v4, v1, v2, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 391
    array-length v11, v9

    add-int/2addr v2, v11

    .line 392
    nop

    .line 454
    .end local v9    # "it":[B
    .end local v10    # "$i$a$-forEach-AuthServiceImpl$concat$1":I
    nop

    .end local v8    # "element$iv":Ljava/lang/Object;
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 455
    :cond_1
    nop

    .line 393
    .end local v3    # "$this$forEach$iv":[Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    return-object v1
.end method

.method private final deviceAuthFail(Ljava/lang/String;I)V
    .locals 7
    .param p1, "errorMsg"    # Ljava/lang/String;
    .param p2, "errorCode"    # I

    .line 397
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthSuccess:Z

    .line 398
    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIAuthListeners:Ljava/util/Set;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 456
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;
    const/4 v6, 0x0

    .line 399
    .local v6, "$i$a$-forEach-AuthServiceImpl$deviceAuthFail$1":I
    invoke-interface {v5, v0}, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;->onDeviceAuth(Z)V

    .line 400
    nop

    .line 456
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;
    .end local v6    # "$i$a$-forEach-AuthServiceImpl$deviceAuthFail$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 457
    :cond_0
    nop

    .line 401
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    invoke-direct {p0, v0, p1, p2}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendDeviceAuthResultMsg(ZLjava/lang/String;I)V

    .line 402
    return-void
.end method

.method private final deviceAuthSuccess()V
    .locals 13

    .line 405
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthSuccess:Z

    .line 406
    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIAuthListeners:Ljava/util/Set;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 458
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;
    const/4 v6, 0x0

    .line 407
    .local v6, "$i$a$-forEach-AuthServiceImpl$deviceAuthSuccess$1":I
    invoke-interface {v5, v0}, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;->onDeviceAuth(Z)V

    .line 408
    nop

    .line 458
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;
    .end local v6    # "$i$a$-forEach-AuthServiceImpl$deviceAuthSuccess$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 459
    :cond_0
    nop

    .line 409
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    const/4 v11, 0x6

    const/4 v12, 0x0

    const/4 v8, 0x1

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v7, p0

    invoke-static/range {v7 .. v12}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendDeviceAuthResultMsg$default(Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;ZLjava/lang/String;IILjava/lang/Object;)V

    .line 410
    return-void
.end method

.method private final generateAndSendPubKey()V
    .locals 5

    .line 258
    const-string v0, "AuthServiceImpl"

    .line 259
    :try_start_0
    const-string v1, "4. \u751f\u6210 ECDH \u5bc6\u94a5\u5bf9"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 261
    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->generateEphemeralKeyPair()Ljava/security/KeyPair;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->myEph:Ljava/security/KeyPair;

    .line 263
    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static {v2, v4, v3, v4}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->getKeystorePublicKeyBytes$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;Ljava/lang/String;ILjava/lang/Object;)[B

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64([B)Ljava/lang/String;

    move-result-object v1

    .line 264
    .local v1, "signPubB64":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    sget-object v3, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->myEph:Ljava/security/KeyPair;

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v3}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    move-result-object v3

    invoke-interface {v3}, Ljava/security/PublicKey;->getEncoded()[B

    move-result-object v3

    const-string v4, "myEph!!.public.encoded"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64([B)Ljava/lang/String;

    move-result-object v2

    .line 265
    .local v2, "ephPubB64":Ljava/lang/String;
    new-instance v3, Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    const-string v4, "phone"

    invoke-direct {v3, v4, v1, v2}, Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 266
    .local v3, "pubKeyInfo":Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;
    invoke-direct {p0, v3}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendPublicKeyMsg(Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "signPubB64":Ljava/lang/String;
    .end local v2    # "ephPubB64":Ljava/lang/String;
    .end local v3    # "pubKeyInfo":Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;
    goto :goto_0

    .line 267
    :catch_0
    move-exception v1

    .line 268
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "generateAndSendPubKey error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 269
    const-string/jumbo v0, "\u751f\u6210\u8ba4\u8bc1\u516c\u94a5\u5931\u8d25"

    const/4 v2, -0x4

    invoke-direct {p0, v0, v2}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthFail(Ljava/lang/String;I)V

    .line 271
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final generateSignature(Ljava/lang/String;)V
    .locals 7
    .param p1, "nonceGlassB64"    # Ljava/lang/String;

    .line 277
    const-string v0, "9. Sigin -- generateSignature \u751f\u6210\u7b7e\u540d\u4fe1\u606f"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AuthServiceImpl"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 278
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v0

    .line 279
    .local v0, "nonceGlass":[B
    const/16 v1, 0x10

    new-array v1, v1, [B

    move-object v2, v1

    .line 448
    .local v2, "it":[B
    const/4 v3, 0x0

    .line 279
    .local v3, "$i$a$-also-AuthServiceImpl$generateSignature$noncePhone$1":I
    new-instance v4, Ljava/security/SecureRandom;

    invoke-direct {v4}, Ljava/security/SecureRandom;-><init>()V

    invoke-virtual {v4, v2}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 280
    .end local v2    # "it":[B
    .end local v3    # "$i$a$-also-AuthServiceImpl$generateSignature$noncePhone$1":I
    .local v1, "noncePhone":[B
    sget-object v2, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v2, v1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64([B)Ljava/lang/String;

    move-result-object v2

    .line 281
    .local v2, "noncePhoneB64":Ljava/lang/String;
    sput-object v2, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhoneB64:Ljava/lang/String;

    .line 282
    sput-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhone:[B

    .line 283
    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNonceGlass:[B

    .line 284
    filled-new-array {v0, v1}, [[B

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->concat([[B)[B

    move-result-object v3

    .line 285
    .local v3, "toSign":[B
    sget-object v4, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    const/4 v5, 0x0

    const/4 v6, 0x2

    invoke-static {v4, v3, v5, v6, v5}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->signWithKeystore$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;[BLjava/lang/String;ILjava/lang/Object;)[B

    move-result-object v4

    .line 286
    .local v4, "sigPhone":[B
    sget-object v5, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v5, v4}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64([B)Ljava/lang/String;

    move-result-object v5

    .line 288
    .local v5, "sigPhoneB64":Ljava/lang/String;
    invoke-direct {p0, p1, v2, v5}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendSignMsg(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 289
    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 19
    .param p1, "msg"    # Ljava/lang/String;

    .line 68
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    const-string/jumbo v0, "\u8bbe\u5907\u8ba4\u8bc1\u5931\u8d25,Glass3\u955c\u50cf\u548c\u624b\u673a\u5e94\u7528\u7248\u672c\u4e0d\u5339\u914d"

    move-object v3, v2

    check-cast v3, Ljava/lang/CharSequence;

    const-string v4, "DEVICE_AUTH"

    move-object v5, v4

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x2

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static {v3, v5, v8, v6, v7}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_19

    .line 69
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 70
    .local v3, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v5, "type"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_18

    .line 71
    const-string v4, "extra"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 72
    .local v4, "extraJson":Ljava/lang/String;
    move-object v5, v4

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x1

    if-eqz v5, :cond_1

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-nez v5, :cond_0

    goto :goto_0

    :cond_0
    move v5, v8

    goto :goto_1

    :cond_1
    :goto_0
    move v5, v6

    :goto_1
    if-nez v5, :cond_17

    .line 73
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 74
    .local v5, "extraJsonObject":Lorg/json/JSONObject;
    const-string v7, "methodName"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 75
    .local v7, "methodName":Ljava/lang/String;
    if-eqz v7, :cond_16

    invoke-virtual {v7}, Ljava/lang/String;->hashCode()I

    move-result v9

    const-string v10, "AuthServiceImpl"

    sparse-switch v9, :sswitch_data_0

    goto/16 :goto_6

    :sswitch_0
    const-string v0, "Signature_Verificat_Result"

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto/16 :goto_3

    .line 149
    :cond_2
    const-string v0, "16.\u534f\u5546\u5b8c\u6210"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 150
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v6, Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;

    invoke-virtual {v0, v4, v6}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;

    .line 151
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;
    if-eqz v0, :cond_19

    .line 152
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;->isSuccess()Z

    move-result v6

    if-nez v6, :cond_19

    .line 153
    const-string/jumbo v6, "\u534f\u5546\u5931\u8d25,\u5bf9\u65b9\u7b7e\u540d\u9a8c\u8bc1\u5931\u8d25"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v10, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 154
    sput-boolean v8, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthSuccess:Z

    .line 155
    sget-object v6, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIAuthListeners:Ljava/util/Set;

    check-cast v6, Ljava/lang/Iterable;

    .local v6, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 446
    .local v9, "$i$f$forEach":I
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_2
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_3

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    .local v11, "element$iv":Ljava/lang/Object;
    move-object v12, v11

    check-cast v12, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;

    .local v12, "it":Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;
    const/4 v13, 0x0

    .line 156
    .local v13, "$i$a$-forEach-AuthServiceImpl$parseMessage$1":I
    invoke-interface {v12, v8}, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;->onDeviceAuth(Z)V

    .line 157
    nop

    .line 446
    .end local v12    # "it":Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;
    .end local v13    # "$i$a$-forEach-AuthServiceImpl$parseMessage$1":I
    nop

    .end local v11    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 447
    :cond_3
    nop

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;
    .end local v6    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v9    # "$i$f$forEach":I
    goto/16 :goto_7

    .line 75
    :sswitch_1
    const-string v6, "Send_Encrypt_Auth_Msg"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_4

    goto/16 :goto_3

    .line 164
    :cond_4
    const-string/jumbo v6, "\u6536\u5230\u52a0\u5bc6\u8ba4\u8bc1\u6d88\u606f"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v10, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 165
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v6

    const-class v8, Lcom/rokid/security/sdk/base/common/EncryptAuthMsgExtra;

    invoke-virtual {v6, v4, v8}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/rokid/security/sdk/base/common/EncryptAuthMsgExtra;

    .line 166
    .local v6, "extra":Lcom/rokid/security/sdk/base/common/EncryptAuthMsgExtra;
    if-eqz v6, :cond_19

    .line 167
    sget-object v8, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sessionKey:[B

    if-eqz v8, :cond_6

    .line 168
    sget-object v8, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/EncryptAuthMsgExtra;->getIv()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v8

    .line 169
    .local v8, "iv":[B
    sget-object v9, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/EncryptAuthMsgExtra;->getCt()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v9

    .line 170
    .local v9, "ct":[B
    nop

    .line 171
    :try_start_0
    sget-object v11, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    sget-object v12, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sessionKey:[B

    invoke-static {v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    const/16 v16, 0x8

    const/16 v17, 0x0

    const/4 v15, 0x0

    move-object v13, v8

    move-object v14, v9

    invoke-static/range {v11 .. v17}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->aesGcmDecrypt$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;[B[B[B[BILjava/lang/Object;)[B

    move-result-object v11

    .line 172
    .local v11, "pt":[B
    new-instance v12, Ljava/lang/String;

    sget-object v13, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v12, v11, v13}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 173
    .local v12, "data":Ljava/lang/String;
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "Decrypted msg: "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    invoke-static {v10, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 180
    const-string v13, "ab9d547e319c93b462d866055ddb31c1"

    invoke-static {v13, v12}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_5

    .line 181
    const-string/jumbo v0, "\u8bbe\u5907\u8ba4\u8bc1\u6210\u529f"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 182
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthSuccess()V

    goto/16 :goto_7

    .line 184
    :cond_5
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v13

    invoke-static {v10, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 185
    const/4 v13, -0x4

    invoke-direct {v1, v0, v13}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthFail(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v11    # "pt":[B
    .end local v12    # "data":Ljava/lang/String;
    goto/16 :goto_7

    .line 188
    :catch_0
    move-exception v0

    .line 189
    .local v0, "e":Ljava/lang/Exception;
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Decrypt failed: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 190
    const-string v10, "Decrypt failed"

    const/4 v11, -0x6

    invoke-direct {v1, v10, v11}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthFail(Ljava/lang/String;I)V

    .end local v0    # "e":Ljava/lang/Exception;
    .end local v8    # "iv":[B
    .end local v9    # "ct":[B
    goto/16 :goto_7

    .line 193
    :cond_6
    const-string/jumbo v0, "\u751f\u6210\u4f1a\u8bdd\u5bc6\u94a5 sessionKey = null"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 194
    const-string/jumbo v0, "\u4f1a\u8bdd\u5bc6\u94a5 sessionKey\u4e3a\u7a7a"

    const/4 v8, -0x5

    invoke-direct {v1, v0, v8}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthFail(Ljava/lang/String;I)V

    goto/16 :goto_7

    .line 75
    .end local v6    # "extra":Lcom/rokid/security/sdk/base/common/EncryptAuthMsgExtra;
    :sswitch_2
    const-string v0, "Send_Signature"

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    :goto_3
    goto/16 :goto_7

    .line 109
    :cond_7
    const-string v0, "11. \u6536\u5230\u7b7e\u540d, \u5f00\u59cb\u9a8c\u8bc1\u7b7e\u540d"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 110
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v9, Lcom/rokid/security/sdk/base/common/SignExtra;

    invoke-virtual {v0, v4, v9}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/SignExtra;

    .line 111
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    if-eqz v0, :cond_11

    .line 112
    sget-object v9, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhoneB64:Ljava/lang/String;

    check-cast v9, Ljava/lang/CharSequence;

    if-eqz v9, :cond_8

    invoke-interface {v9}, Ljava/lang/CharSequence;->length()I

    move-result v9

    if-nez v9, :cond_9

    :cond_8
    move v8, v6

    :cond_9
    if-nez v8, :cond_10

    .line 113
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/SignExtra;->getNoncePhoneB64()Ljava/lang/String;

    move-result-object v6

    sget-object v8, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhoneB64:Ljava/lang/String;

    invoke-static {v6, v8}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_a

    .line 114
    const-string/jumbo v6, "\u7b7e\u540d\u9519\u8bef, Nonce\u4e0d\u4e00\u81f4"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v10, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 115
    const/4 v8, -0x1

    invoke-direct {v1, v6, v8}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthFail(Ljava/lang/String;I)V

    goto/16 :goto_7

    .line 118
    :cond_a
    sget-object v6, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/SignExtra;->getNonceGlassB64()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v6

    .line 119
    .local v6, "nonceGlass":[B
    sget-object v8, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/SignExtra;->getNoncePhoneB64()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v8

    .line 120
    .local v8, "noncePhone":[B
    sget-object v9, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/SignExtra;->getSignature()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v9

    .line 121
    .local v9, "signature":[B
    filled-new-array {v6, v8}, [[B

    move-result-object v11

    invoke-direct {v1, v11}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->concat([[B)[B

    move-result-object v11

    .line 122
    .local v11, "signData":[B
    sget-object v12, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    sget-object v13, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mPubKeyInfo:Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    const-string v14, ""

    if-eqz v13, :cond_b

    invoke-virtual {v13}, Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;->getSignPubB64()Ljava/lang/String;

    move-result-object v13

    if-nez v13, :cond_c

    :cond_b
    move-object v13, v14

    :cond_c
    invoke-virtual {v12, v13}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v12

    .line 123
    .local v12, "peerSignPub":[B
    sget-object v13, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    invoke-virtual {v13, v12, v11, v9}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->verifySignature([B[B[B)Z

    move-result v13

    .line 124
    .local v13, "ok":Z
    if-eqz v13, :cond_f

    .line 125
    const-string v15, "12.Glass3\u7b7e\u540d\u9a8c\u8bc1\u6210\u529f"

    filled-new-array {v15}, [Ljava/lang/Object;

    move-result-object v15

    invoke-static {v10, v15}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 126
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendSignOkMsg()V

    .line 128
    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNonceGlass:[B

    if-eqz v15, :cond_e

    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhone:[B

    if-eqz v15, :cond_e

    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->myEph:Ljava/security/KeyPair;

    if-eqz v15, :cond_e

    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mPubKeyInfo:Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    if-eqz v15, :cond_e

    .line 129
    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    sget-object v16, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mPubKeyInfo:Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    invoke-static/range {v16 .. v16}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual/range {v16 .. v16}, Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;->getEphPubB64()Ljava/lang/String;

    move-result-object v16

    if-nez v16, :cond_d

    goto :goto_4

    :cond_d
    move-object/from16 v14, v16

    :goto_4
    invoke-virtual {v15, v14}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->b64d(Ljava/lang/String;)[B

    move-result-object v14

    .line 130
    .local v14, "peerEphPub":[B
    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    sget-object v16, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->myEph:Ljava/security/KeyPair;

    invoke-static/range {v16 .. v16}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    move-object/from16 v17, v0

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .local v17, "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    invoke-virtual/range {v16 .. v16}, Ljava/security/KeyPair;->getPrivate()Ljava/security/PrivateKey;

    move-result-object v0

    const-string v2, "myEph!!.private"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v15, v0, v14}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->computeSharedSecret(Ljava/security/PrivateKey;[B)[B

    move-result-object v0

    .line 131
    .local v0, "shared":[B
    sget-object v2, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNonceGlass:[B

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhone:[B

    invoke-static {v15}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    filled-new-array {v2, v15}, [[B

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->concat([[B)[B

    move-result-object v2

    .line 132
    .local v2, "salt":[B
    sget-object v15, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    move-object/from16 v16, v3

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .local v16, "jsonObject":Lorg/json/JSONObject;
    const-string v3, "BT-Session"

    move-object/from16 v18, v5

    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .local v18, "extraJsonObject":Lorg/json/JSONObject;
    sget-object v5, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v3, v5}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    const-string/jumbo v5, "this as java.lang.String).getBytes(charset)"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v5, 0x20

    invoke-virtual {v15, v0, v2, v3, v5}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->hkdfSha256([B[B[BI)[B

    move-result-object v3

    sput-object v3, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sessionKey:[B

    .line 133
    const-string v3, "17.\u751f\u6210\u4f1a\u8bdd\u5bc6\u94a5\u5b8c\u6210"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v10, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v0    # "shared":[B
    .end local v2    # "salt":[B
    .end local v14    # "peerEphPub":[B
    goto/16 :goto_7

    .line 128
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :cond_e
    move-object/from16 v17, v0

    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .line 135
    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    const-string/jumbo v0, "\u751f\u6210\u4f1a\u8bdd\u5bc6\u94a5\u5931\u8d25"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v10, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 136
    const/4 v2, -0x2

    invoke-direct {v1, v0, v2}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthFail(Ljava/lang/String;I)V

    goto/16 :goto_7

    .line 140
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :cond_f
    move-object/from16 v17, v0

    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    const-string/jumbo v0, "\u7b7e\u540d\u9a8c\u8bc1\u5931\u8d25"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v10, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    const/4 v2, -0x3

    invoke-direct {v1, v0, v2}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->deviceAuthFail(Ljava/lang/String;I)V

    .end local v6    # "nonceGlass":[B
    .end local v8    # "noncePhone":[B
    .end local v9    # "signature":[B
    .end local v11    # "signData":[B
    .end local v12    # "peerSignPub":[B
    .end local v13    # "ok":Z
    .end local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    goto/16 :goto_7

    .line 112
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :cond_10
    move-object/from16 v17, v0

    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    goto/16 :goto_7

    .line 111
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :cond_11
    move-object/from16 v17, v0

    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    goto/16 :goto_7

    .line 75
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v17    # "extra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :sswitch_3
    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    const-string v0, "RECEIVE_PUBLIC_KEY_REPLY"

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_12

    goto :goto_5

    .line 87
    :cond_12
    const-string v0, "6.\u6536\u5230\u5bf9\u65b9\u5df2\u6536\u5230\u516c\u94a5 "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 89
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendPublicKeyOkMsg()V

    goto/16 :goto_7

    .line 75
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :sswitch_4
    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    const-string v0, "Send_Nonce"

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_13

    goto :goto_5

    .line 100
    :cond_13
    const-string v0, "8. Sigin -- \u6536\u5230 nonceGlass"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 101
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v2, Lcom/rokid/security/sdk/base/common/NonceExtra;

    invoke-virtual {v0, v4, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/NonceExtra;

    .line 102
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/NonceExtra;
    if-eqz v0, :cond_19

    .line 104
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/NonceExtra;->getNonceGlassB64()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->generateSignature(Ljava/lang/String;)V

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/NonceExtra;
    goto :goto_7

    .line 75
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :sswitch_5
    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    const-string v0, "PUBLIC_KEY_OK"

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_14

    goto :goto_5

    .line 93
    :cond_14
    const-string v0, "3. 3\u6b21\u63e1\u624b\u5b8c\u6210"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 96
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->generateAndSendPubKey()V

    goto :goto_7

    .line 75
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :sswitch_6
    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    const-string v0, "SEND_PUBLIC_KEY"

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_15

    :goto_5
    goto :goto_7

    .line 77
    :cond_15
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v2, Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;

    invoke-virtual {v0, v4, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;

    .line 78
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;
    if-eqz v0, :cond_19

    .line 79
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "2.\u6536\u5230\u5bf9\u65b9\u7684\u516c\u94a5 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v10, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 80
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;->getPubKeyInfo()Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    move-result-object v2

    sput-object v2, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mPubKeyInfo:Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    .line 82
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendReceivePublicKeyReplyMsg()V

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;
    goto :goto_7

    .line 75
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v5    # "extraJsonObject":Lorg/json/JSONObject;
    :cond_16
    :goto_6
    move-object/from16 v16, v3

    move-object/from16 v18, v5

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v18    # "extraJsonObject":Lorg/json/JSONObject;
    goto :goto_7

    .line 72
    .end local v7    # "methodName":Ljava/lang/String;
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v18    # "extraJsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    :cond_17
    move-object/from16 v16, v3

    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    .restart local v16    # "jsonObject":Lorg/json/JSONObject;
    goto :goto_7

    .line 70
    .end local v4    # "extraJson":Ljava/lang/String;
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .restart local v3    # "jsonObject":Lorg/json/JSONObject;
    :cond_18
    move-object/from16 v16, v3

    .line 202
    .end local v3    # "jsonObject":Lorg/json/JSONObject;
    :cond_19
    :goto_7
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x76995b80 -> :sswitch_6
        -0x637a518e -> :sswitch_5
        -0x59e46f88 -> :sswitch_4
        0x9a68870 -> :sswitch_3
        0x2af584c1 -> :sswitch_2
        0x5e5294db -> :sswitch_1
        0x65c6ded6 -> :sswitch_0
    .end sparse-switch
.end method

.method private final sendDeviceAuthResultMsg(ZLjava/lang/String;I)V
    .locals 11
    .param p1, "isSuccess"    # Z
    .param p2, "errorMsg"    # Ljava/lang/String;
    .param p3, "errorCode"    # I

    .line 368
    const-string v0, "AuthServiceImpl"

    .line 369
    :try_start_0
    const-string v1, "18. sendDeviceAuthResultMsg \u53d1\u9001\u8bbe\u5907\u955c\u50cf\u8ba4\u8bc1\u7ed3\u679c"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 370
    new-instance v1, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendDeviceAuthResultMsg_u24lambda_u249":Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;
    const/4 v3, 0x0

    .line 371
    .local v3, "$i$a$-apply-AuthServiceImpl$sendDeviceAuthResultMsg$deviceAuthResultExtra$1":I
    const-string v4, "Device_Auth_Result"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->setMethodName(Ljava/lang/String;)V

    .line 372
    invoke-virtual {v2, p1}, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->setSuccess(Z)V

    .line 373
    if-eqz p2, :cond_0

    move-object v4, p2

    .line 448
    .local v4, "it":Ljava/lang/String;
    const/4 v5, 0x0

    .line 373
    .local v5, "$i$a$-let-AuthServiceImpl$sendDeviceAuthResultMsg$deviceAuthResultExtra$1$1":I
    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->setErrorMsg(Ljava/lang/String;)V

    .line 374
    .end local v4    # "it":Ljava/lang/String;
    .end local v5    # "$i$a$-let-AuthServiceImpl$sendDeviceAuthResultMsg$deviceAuthResultExtra$1$1":I
    :cond_0
    move v4, p3

    .line 448
    .local v4, "it":I
    const/4 v5, 0x0

    .line 374
    .local v5, "$i$a$-let-AuthServiceImpl$sendDeviceAuthResultMsg$deviceAuthResultExtra$1$2":I
    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;->setErrorCode(I)V

    .line 375
    .end local v4    # "it":I
    .end local v5    # "$i$a$-let-AuthServiceImpl$sendDeviceAuthResultMsg$deviceAuthResultExtra$1$2":I
    nop

    .line 370
    .end local v2    # "$this$sendDeviceAuthResultMsg_u24lambda_u249":Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;
    .end local v3    # "$i$a$-apply-AuthServiceImpl$sendDeviceAuthResultMsg$deviceAuthResultExtra$1":I
    nop

    .line 376
    .local v1, "deviceAuthResultExtra":Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 377
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "DEVICE_AUTH"

    const-string v5, "extra"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "deviceAuthResultExtra":Lcom/rokid/security/sdk/base/common/DeviceAuthResultExtra;
    .end local v2    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 378
    :catch_0
    move-exception v1

    .line 379
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 380
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendDeviceAuthResultMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 382
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method static synthetic sendDeviceAuthResultMsg$default(Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;ZLjava/lang/String;IILjava/lang/Object;)V
    .locals 0

    .line 367
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_0

    const/4 p2, 0x0

    :cond_0
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_1

    const/4 p3, 0x0

    :cond_1
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sendDeviceAuthResultMsg(ZLjava/lang/String;I)V

    return-void
.end method

.method private final sendPublicKeyMsg(Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;)V
    .locals 11
    .param p1, "info"    # Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    .line 293
    const-string v0, "AuthServiceImpl"

    .line 294
    :try_start_0
    const-string v1, "5. sendPublicKeyMsg \u53d1\u9001\u516c\u94a5"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 295
    new-instance v1, Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendPublicKeyMsg_u24lambda_u242":Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;
    const/4 v3, 0x0

    .line 296
    .local v3, "$i$a$-apply-AuthServiceImpl$sendPublicKeyMsg$sendPublicKeyExtra$1":I
    const-string v4, "SEND_PUBLIC_KEY"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;->setMethodName(Ljava/lang/String;)V

    .line 297
    invoke-virtual {v2, p1}, Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;->setPubKeyInfo(Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;)V

    .line 298
    nop

    .line 295
    .end local v2    # "$this$sendPublicKeyMsg_u24lambda_u242":Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;
    .end local v3    # "$i$a$-apply-AuthServiceImpl$sendPublicKeyMsg$sendPublicKeyExtra$1":I
    nop

    .line 299
    .local v1, "sendPublicKeyExtra":Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 300
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "DEVICE_AUTH"

    const-string v5, "extra"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "sendPublicKeyExtra":Lcom/rokid/security/sdk/base/common/SendPublicKeyExtra;
    .end local v2    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 301
    :catch_0
    move-exception v1

    .line 302
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 303
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendPublicKeyMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 305
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final sendPublicKeyOkMsg()V
    .locals 11

    .line 322
    const-string v0, "AuthServiceImpl"

    .line 323
    :try_start_0
    const-string v1, "7. sendPublicKeyOkMsg \u901a\u77e5\u5bf9\u65b9,\u6211\u77e5\u9053\u4f60\u6536\u5230\u6211\u7684\u516c\u94a5\u4e86"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 324
    new-instance v1, Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendPublicKeyOkMsg_u24lambda_u244":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    const/4 v3, 0x0

    .line 325
    .local v3, "$i$a$-apply-AuthServiceImpl$sendPublicKeyOkMsg$receivePublicKeyReplyExtra$1":I
    const-string v4, "PUBLIC_KEY_OK"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;->setMethodName(Ljava/lang/String;)V

    .line 326
    nop

    .line 324
    .end local v2    # "$this$sendPublicKeyOkMsg_u24lambda_u244":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    .end local v3    # "$i$a$-apply-AuthServiceImpl$sendPublicKeyOkMsg$receivePublicKeyReplyExtra$1":I
    nop

    .line 327
    .local v1, "receivePublicKeyReplyExtra":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 328
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "DEVICE_AUTH"

    const-string v5, "extra"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "receivePublicKeyReplyExtra":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    .end local v2    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 329
    :catch_0
    move-exception v1

    .line 330
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 331
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendPublicKeyOkMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 333
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final sendReceivePublicKeyReplyMsg()V
    .locals 11

    .line 308
    const-string v0, "AuthServiceImpl"

    .line 309
    :try_start_0
    const-string v1, "5. sendReceivePublicKeyReplyMsg \u56de\u590d\u5bf9\u65b9\u5df2\u6536\u5230\u516c\u94a5"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 310
    new-instance v1, Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendReceivePublicKeyReplyMsg_u24lambda_u243":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    const/4 v3, 0x0

    .line 311
    .local v3, "$i$a$-apply-AuthServiceImpl$sendReceivePublicKeyReplyMsg$receivePublicKeyReplyExtra$1":I
    const-string v4, "RECEIVE_PUBLIC_KEY_REPLY"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;->setMethodName(Ljava/lang/String;)V

    .line 312
    nop

    .line 310
    .end local v2    # "$this$sendReceivePublicKeyReplyMsg_u24lambda_u243":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    .end local v3    # "$i$a$-apply-AuthServiceImpl$sendReceivePublicKeyReplyMsg$receivePublicKeyReplyExtra$1":I
    nop

    .line 313
    .local v1, "receivePublicKeyReplyExtra":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 314
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "DEVICE_AUTH"

    const-string v5, "extra"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "receivePublicKeyReplyExtra":Lcom/rokid/security/sdk/base/common/ReceivePublicKeyReplyExtra;
    .end local v2    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 315
    :catch_0
    move-exception v1

    .line 316
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 317
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendReceivePublicKeyReplyMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 319
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final sendSignMsg(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 11
    .param p1, "nonceGlassB64"    # Ljava/lang/String;
    .param p2, "noncePhoneB64"    # Ljava/lang/String;
    .param p3, "signature"    # Ljava/lang/String;

    .line 336
    const-string v0, "AuthServiceImpl"

    .line 337
    :try_start_0
    const-string v1, "10. sendSignMsg \u53d1\u9001\u7b7e\u540d\u4fe1\u606f"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 338
    new-instance v1, Lcom/rokid/security/sdk/base/common/SignExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/SignExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendSignMsg_u24lambda_u245":Lcom/rokid/security/sdk/base/common/SignExtra;
    const/4 v3, 0x0

    .line 339
    .local v3, "$i$a$-apply-AuthServiceImpl$sendSignMsg$signExtra$1":I
    const-string v4, "Send_Signature"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/SignExtra;->setMethodName(Ljava/lang/String;)V

    .line 340
    invoke-virtual {v2, p1}, Lcom/rokid/security/sdk/base/common/SignExtra;->setNonceGlassB64(Ljava/lang/String;)V

    .line 341
    invoke-virtual {v2, p2}, Lcom/rokid/security/sdk/base/common/SignExtra;->setNoncePhoneB64(Ljava/lang/String;)V

    .line 342
    invoke-virtual {v2, p3}, Lcom/rokid/security/sdk/base/common/SignExtra;->setSignature(Ljava/lang/String;)V

    .line 343
    nop

    .line 338
    .end local v2    # "$this$sendSignMsg_u24lambda_u245":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v3    # "$i$a$-apply-AuthServiceImpl$sendSignMsg$signExtra$1":I
    nop

    .line 344
    .local v1, "signExtra":Lcom/rokid/security/sdk/base/common/SignExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 345
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "DEVICE_AUTH"

    const-string v5, "extra"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "signExtra":Lcom/rokid/security/sdk/base/common/SignExtra;
    .end local v2    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 346
    :catch_0
    move-exception v1

    .line 347
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 348
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendSignMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 350
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final sendSignOkMsg()V
    .locals 11

    .line 353
    const-string v0, "AuthServiceImpl"

    .line 354
    :try_start_0
    const-string v1, "13. sendSignOkMsg \u901a\u77e5\u5bf9\u65b9\u9a8c\u7b7e\u6210\u529f"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 355
    new-instance v1, Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendSignOkMsg_u24lambda_u246":Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;
    const/4 v3, 0x0

    .line 356
    .local v3, "$i$a$-apply-AuthServiceImpl$sendSignOkMsg$signVerificatResultExtra$1":I
    const-string v4, "Signature_Verificat_Result"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;->setMethodName(Ljava/lang/String;)V

    .line 357
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;->setSuccess(Z)V

    .line 358
    nop

    .line 355
    .end local v2    # "$this$sendSignOkMsg_u24lambda_u246":Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;
    .end local v3    # "$i$a$-apply-AuthServiceImpl$sendSignOkMsg$signVerificatResultExtra$1":I
    nop

    .line 359
    .local v1, "signVerificatResultExtra":Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 360
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "DEVICE_AUTH"

    const-string v5, "extra"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "signVerificatResultExtra":Lcom/rokid/security/sdk/base/common/SignVerificatResultExtra;
    .end local v2    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 361
    :catch_0
    move-exception v1

    .line 362
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 363
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendSignOkMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 365
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method


# virtual methods
.method public final addAuthListener(Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 413
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIAuthListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 414
    return-void
.end method

.method public final init()V
    .locals 3

    .line 246
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;->ensureKeystoreKeyPair$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;Ljava/lang/String;ILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 247
    const-string v0, "1. \u751f\u6210\u957f\u671f\u7b7e\u540d\u5bc6\u94a5\u5bf9"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AuthServiceImpl"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 249
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 250
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->addClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 251
    return-void
.end method

.method public final isAuthenticated()Z
    .locals 2

    .line 422
    sget-object v0, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->isGlassLowVersion3()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 423
    const/4 v0, 0x1

    return v0

    .line 426
    :cond_0
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthSuccess:Z

    if-nez v0, :cond_1

    .line 427
    const-string v0, "isAuthenticated = false  \u8bbe\u5907\u672a\u5b8c\u6210\u53cc\u5411\u8ba4\u8bc1"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AuthServiceImpl"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 429
    :cond_1
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthSuccess:Z

    return v0
.end method

.method public final release()V
    .locals 2

    .line 434
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 435
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->removeClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 436
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthSuccess:Z

    .line 437
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mPubKeyInfo:Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;

    .line 438
    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->sessionKey:[B

    .line 439
    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhoneB64:Ljava/lang/String;

    .line 440
    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNoncePhone:[B

    .line 441
    sput-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mNonceGlass:[B

    .line 442
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIAuthListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 443
    return-void
.end method

.method public final removeAuthListener(Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 417
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->mIAuthListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 418
    return-void
.end method
