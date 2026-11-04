.class public final Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;
.super Ljava/lang/Object;
.source "EncryptDecryptHelper.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000L\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0008\u0003\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0010\u000b\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0005*\u0002\u000f\u0012\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J1\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u0017\u001a\u00020\u00042!\u0010\u0018\u001a\u001d\u0012\u0013\u0012\u00110\u0004\u00a2\u0006\u000c\u0008\u001a\u0012\u0008\u0008\u001b\u0012\u0004\u0008\u0008(\u001c\u0012\u0004\u0012\u00020\u00160\u0019J$\u0010\u001d\u001a\u00020\u00162\u0006\u0010\u001c\u001a\u00020\u00042\u0012\u0010\u0018\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00160\u0019H\u0007J1\u0010\u001e\u001a\u00020\u00162\u0006\u0010\u001c\u001a\u00020\u00042!\u0010\u0018\u001a\u001d\u0012\u0013\u0012\u00110\u0004\u00a2\u0006\u000c\u0008\u001a\u0012\u0008\u0008\u001b\u0012\u0004\u0008\u0008(\u0017\u0012\u0004\u0012\u00020\u00160\u0019J\u0008\u0010\u001f\u001a\u00020\u0004H\u0002J\u0006\u0010 \u001a\u00020\u0016J\u0006\u0010!\u001a\u00020\"J\u0006\u0010#\u001a\u00020\"J\u0006\u0010$\u001a\u00020\u0016J\u0010\u0010%\u001a\u00020\u00162\u0006\u0010\u001c\u001a\u00020\u0004H\u0002J\u0006\u0010&\u001a\u00020\u0016J\u0010\u0010\'\u001a\u00020\u00162\u0006\u0010(\u001a\u00020\u0004H\u0002J\u0010\u0010)\u001a\u00020\u00162\u0006\u0010*\u001a\u00020+H\u0002J\u0012\u0010,\u001a\u00020\u00162\u0008\u0010-\u001a\u0004\u0018\u00010\u0001H\u0002J\u0008\u0010.\u001a\u00020\u0016H\u0002J\u0008\u0010/\u001a\u00020\u0016H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0011\u0010\u0008\u001a\u00020\t\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\nR\u000e\u0010\u000b\u001a\u00020\tX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0011\u0010\u000c\u001a\u00020\t\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000c\u0010\nR\u0011\u0010\r\u001a\u00020\t\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\nR\u0010\u0010\u000e\u001a\u00020\u000fX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0010R\u0010\u0010\u0011\u001a\u00020\u0012X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0013R\u0010\u0010\u0014\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u00060"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;",
        "",
        "()V",
        "SP_TYPE_GLASS_CERT_INFO",
        "",
        "SP_TYPE_GLASS_PUBKEY",
        "SP_TYPE_PHONE_CERT_INFO",
        "TAG",
        "isCertReady",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "()Ljava/util/concurrent/atomic/AtomicBoolean;",
        "isMctKReady",
        "isReceivedPubkey",
        "isRemoteReceivedMyPubKey",
        "mIClassicBTClientListener",
        "com/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1",
        "Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1;",
        "pubKey",
        "decrypt",
        "",
        "encMsg",
        "onFunc",
        "Lkotlin/Function1;",
        "Lkotlin/ParameterName;",
        "name",
        "msg",
        "encryptByLocalCert",
        "encryptByPubkey",
        "getEncryptCertPubKey",
        "init",
        "isDecryptReady",
        "",
        "isEncryptReady",
        "onBtDisconnect",
        "parseMessage",
        "release",
        "saveEncryptCertPubKey",
        "data",
        "saveGlassCertInfo",
        "extra",
        "Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;",
        "savePhoneCertInfo",
        "cert",
        "sendPubKeyMsg",
        "sendReceivedPubKeyMsg",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;

.field public static final SP_TYPE_GLASS_CERT_INFO:Ljava/lang/String; = "sp_type_glass_cert_info"

.field public static final SP_TYPE_GLASS_PUBKEY:Ljava/lang/String; = "sp_type_glass_pubkey"

.field public static final SP_TYPE_PHONE_CERT_INFO:Ljava/lang/String; = "sp_type_phone_cert_info"

.field private static final TAG:Ljava/lang/String;

.field private static final isCertReady:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final isMctKReady:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final isRemoteReceivedMyPubKey:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1;

.field private static pubKey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;

    .line 42
    const-string v0, "EncryptDecryptHelper"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    .line 43
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isMctKReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 44
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isCertReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 45
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isRemoteReceivedMyPubKey:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 46
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 63
    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1;

    .line 99
    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 38
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$isMctKReady$p()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 38
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isMctKReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;
    .param p1, "msg"    # Ljava/lang/String;

    .line 38
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendPubKeyMsg(Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;

    .line 38
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->sendPubKeyMsg()V

    return-void
.end method

.method private final getEncryptCertPubKey()Ljava/lang/String;
    .locals 2

    .line 228
    invoke-static {}, Lcom/blankj/utilcode/util/SPUtils;->getInstance()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v0

    const-string/jumbo v1, "sp_type_glass_pubkey"

    invoke-virtual {v0, v1}, Lcom/blankj/utilcode/util/SPUtils;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "getInstance().getString(SP_TYPE_GLASS_PUBKEY)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 8
    .param p1, "msg"    # Ljava/lang/String;

    .line 110
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "Cert_ACTION"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 111
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "parseMessage: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 112
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 113
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 114
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 115
    .local v1, "extraJson":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x1

    if-eqz v2, :cond_1

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    :cond_0
    move v2, v5

    goto :goto_1

    :cond_1
    :goto_0
    move v2, v3

    :goto_1
    if-nez v2, :cond_6

    .line 116
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 117
    .local v2, "extraJsonObject":Lorg/json/JSONObject;
    const-string v4, "methodName"

    invoke-virtual {v2, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 118
    .local v4, "methodName":Ljava/lang/String;
    nop

    .line 119
    const-string v6, "Send_PubKey"

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 120
    sget-object v6, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string/jumbo v7, "\u63a5\u6536[\u773c\u955c\u516c\u94a5]"

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 121
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v6

    const-class v7, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;

    invoke-virtual {v6, v1, v7}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;

    .line 122
    .local v6, "extra":Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->isSuccess()Z

    move-result v7

    if-eqz v7, :cond_4

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->getBase64EncCert()Ljava/lang/String;

    move-result-object v7

    check-cast v7, Ljava/lang/CharSequence;

    if-eqz v7, :cond_3

    invoke-interface {v7}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-nez v7, :cond_2

    goto :goto_2

    :cond_2
    move v7, v5

    goto :goto_3

    :cond_3
    :goto_2
    move v7, v3

    :goto_3
    if-nez v7, :cond_4

    .line 124
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->getBase64EncCert()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {p0, v5}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->saveEncryptCertPubKey(Ljava/lang/String;)V

    .line 128
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->sendReceivedPubKeyMsg()V

    .line 130
    sget-object v5, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v5, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    goto :goto_4

    .line 132
    :cond_4
    sget-object v3, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v3, v5}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 133
    sget-object v3, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string/jumbo v5, "\u63a5\u6536[\u773c\u955c\u516c\u94a5]\u4fe1\u606f\u5f02\u5e38"

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v6    # "extra":Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;
    goto :goto_4

    .line 137
    :cond_5
    const-string v5, "Received_PubKey"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 138
    sget-object v5, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string/jumbo v6, "\u773c\u955c\u6536\u5230[\u672c\u673a\u516c\u94a5]"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 139
    sget-object v5, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isRemoteReceivedMyPubKey:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v5, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 145
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extraJson":Ljava/lang/String;
    .end local v2    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v4    # "methodName":Ljava/lang/String;
    :cond_6
    :goto_4
    return-void
.end method

.method private final saveEncryptCertPubKey(Ljava/lang/String;)V
    .locals 6
    .param p1, "data"    # Ljava/lang/String;

    .line 189
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$saveEncryptCertPubKey$1;

    const/4 v2, 0x0

    invoke-direct {v1, p1, v2}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$saveEncryptCertPubKey$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 192
    return-void
.end method

.method private final saveGlassCertInfo(Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;)V
    .locals 3
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;

    .line 199
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "saveGlassCertInfo "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/SendPubKeyExtra;->getAlias()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " - MCTK\u5df2\u79fb\u9664"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 208
    return-void
.end method

.method private final savePhoneCertInfo(Ljava/lang/Object;)V
    .locals 2
    .param p1, "cert"    # Ljava/lang/Object;

    .line 216
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "savePhoneCertInfo - MCTK\u5df2\u79fb\u9664"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 223
    return-void
.end method

.method private final sendPubKeyMsg()V
    .locals 2

    .line 150
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "\u53d1\u9001[\u624b\u673a\u516c\u94a5] - MCTK\u5df2\u79fb\u9664\uff0c\u6b64\u529f\u80fd\u5df2\u7981\u7528"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 168
    return-void
.end method

.method private final sendReceivedPubKeyMsg()V
    .locals 8

    .line 174
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "\u624b\u673a\u7aef\u53d1\u9001[\u5df2\u6536\u5230\u773c\u955c\u7684\u516c\u94a5]"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 175
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$sendReceivedPubKeyMsg$1;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$sendReceivedPubKeyMsg$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 184
    return-void
.end method


# virtual methods
.method public final decrypt(Ljava/lang/String;Lkotlin/jvm/functions/Function1;)V
    .locals 7
    .param p1, "encMsg"    # Ljava/lang/String;
    .param p2, "onFunc"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "encMsg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onFunc"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 273
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$decrypt$1;

    const/4 v2, 0x0

    invoke-direct {v0, p1, p2, v2}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$decrypt$1;-><init>(Ljava/lang/String;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 281
    return-void
.end method

.method public final encryptByLocalCert(Ljava/lang/String;Lkotlin/jvm/functions/Function1;)V
    .locals 7
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "onFunc"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onFunc"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 262
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$encryptByLocalCert$1;

    const/4 v2, 0x0

    invoke-direct {v0, p2, p1, v2}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$encryptByLocalCert$1;-><init>(Lkotlin/jvm/functions/Function1;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 267
    return-void
.end method

.method public final encryptByPubkey(Ljava/lang/String;Lkotlin/jvm/functions/Function1;)V
    .locals 7
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "onFunc"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onFunc"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 254
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$encryptByPubkey$1;

    const/4 v2, 0x0

    invoke-direct {v0, p2, p1, v2}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$encryptByPubkey$1;-><init>(Lkotlin/jvm/functions/Function1;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 259
    return-void
.end method

.method public final init()V
    .locals 8

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isCertReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 50
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isRemoteReceivedMyPubKey:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 51
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 54
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$init$1;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$init$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 59
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 60
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V

    .line 61
    return-void
.end method

.method public final isCertReady()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 44
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isCertReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public final isDecryptReady()Z
    .locals 2

    .line 244
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string v1, "isDecryptReady - MCTK\u5df2\u79fb\u9664\uff0c\u59cb\u7ec8\u8fd4\u56defalse"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 245
    const/4 v0, 0x0

    return v0
.end method

.method public final isEncryptReady()Z
    .locals 2

    .line 236
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->TAG:Ljava/lang/String;

    const-string v1, "isEncryptReady - MCTK\u5df2\u79fb\u9664\uff0c\u59cb\u7ec8\u8fd4\u56defalse"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 237
    const/4 v0, 0x0

    return v0
.end method

.method public final isReceivedPubkey()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 46
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public final isRemoteReceivedMyPubKey()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 45
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isRemoteReceivedMyPubKey:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public final onBtDisconnect()V
    .locals 2

    .line 294
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isRemoteReceivedMyPubKey:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 295
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isCertReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 296
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 297
    return-void
.end method

.method public final release()V
    .locals 2

    .line 285
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 286
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->mIClassicBTClientListener:Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper$mIClassicBTClientListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V

    .line 287
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isRemoteReceivedMyPubKey:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 288
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isCertReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 289
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isReceivedPubkey:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 290
    sget-object v0, Lcom/rokid/security/phone/sdk/server/certificate/EncryptDecryptHelper;->isMctKReady:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 292
    return-void
.end method
