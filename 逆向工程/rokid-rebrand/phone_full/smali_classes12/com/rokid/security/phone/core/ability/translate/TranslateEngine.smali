.class public final Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;
.super Ljava/lang/Object;
.source "TranslateEngine.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000D\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0007\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0011\u001a\u00020\u0012J\u0010\u0010\u0013\u001a\u00020\u00122\u0008\u0010\u0014\u001a\u0004\u0018\u00010\u0015J\u0016\u0010\u0016\u001a\u00020\u00122\u0006\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\u001aJ\u000e\u0010\u001b\u001a\u00020\u00122\u0006\u0010\u001c\u001a\u00020\u0007J\u0016\u0010\u001d\u001a\u00020\u00122\u0006\u0010\u001e\u001a\u00020\u00042\u0006\u0010\u001f\u001a\u00020\u0004J\u0006\u0010 \u001a\u00020\u0012R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0017\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\tR\u000e\u0010\n\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001c\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u000e\"\u0004\u0008\u000f\u0010\u0010\u00a8\u0006!"
    }
    d2 = {
        "Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;",
        "",
        "()V",
        "TAG",
        "",
        "connectState",
        "Lkotlinx/coroutines/flow/MutableStateFlow;",
        "",
        "getConnectState",
        "()Lkotlinx/coroutines/flow/MutableStateFlow;",
        "isInitSuccess",
        "mTranslateConnectClient",
        "Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;",
        "getMTranslateConnectClient",
        "()Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;",
        "setMTranslateConnectClient",
        "(Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;)V",
        "destroy",
        "",
        "doTranslateVoice",
        "audioData",
        "",
        "init",
        "config",
        "Lcom/rokid/security/sdk/ability/bean/BaseConfig;",
        "listener",
        "Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;",
        "setConnectState",
        "connect",
        "startTranslate",
        "src",
        "dest",
        "stopTranslate",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

.field private static final TAG:Ljava/lang/String;

.field private static final connectState:Lkotlinx/coroutines/flow/MutableStateFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/MutableStateFlow<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private static isInitSuccess:Z

.field private static mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

    invoke-direct {v0}, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->INSTANCE:Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

    .line 18
    const-string v0, "TranslateEngine::"

    sput-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->TAG:Ljava/lang/String;

    .line 24
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0}, Lkotlinx/coroutines/flow/StateFlowKt;->MutableStateFlow(Ljava/lang/Object;)Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->connectState:Lkotlinx/coroutines/flow/MutableStateFlow;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$setInitSuccess$p(Z)V
    .locals 0
    .param p0, "<set-?>"    # Z

    .line 15
    sput-boolean p0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->isInitSuccess:Z

    return-void
.end method


# virtual methods
.method public final destroy()V
    .locals 1

    .line 102
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->destroy()V

    .line 103
    :cond_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->isInitSuccess:Z

    .line 104
    return-void
.end method

.method public final doTranslateVoice([B)V
    .locals 2
    .param p1, "audioData"    # [B

    .line 94
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->TAG:Ljava/lang/String;

    const-string v1, "doTranslateVoice"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 95
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->sendAudioChunk([B)V

    .line 97
    :cond_0
    return-void
.end method

.method public final getConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/MutableStateFlow<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .line 24
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->connectState:Lkotlinx/coroutines/flow/MutableStateFlow;

    return-object v0
.end method

.method public final getMTranslateConnectClient()Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;
    .locals 1

    .line 20
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    return-object v0
.end method

.method public final init(Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;)V
    .locals 2
    .param p1, "config"    # Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    .param p2, "listener"    # Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->TAG:Ljava/lang/String;

    const-string v1, "init-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 35
    new-instance v0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    invoke-direct {v0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    .line 36
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-eqz v0, :cond_0

    new-instance v1, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine$init$1;

    invoke-direct {v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine$init$1;-><init>()V

    check-cast v1, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->setWebSocketCallback(Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;)V

    .line 64
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p2}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->setTranslateListener(Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;)V

    .line 65
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-eqz v0, :cond_2

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->connect(Lcom/rokid/security/sdk/ability/bean/BaseConfig;)V

    .line 67
    :cond_2
    return-void
.end method

.method public final setConnectState(Z)V
    .locals 2
    .param p1, "connect"    # Z

    .line 28
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->connectState:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/ktx/Kt_ext_flowKt;->call(Lkotlinx/coroutines/flow/MutableStateFlow;Ljava/lang/Object;)V

    .line 29
    return-void
.end method

.method public final setMTranslateConnectClient(Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    .line 20
    sput-object p1, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    return-void
.end method

.method public final startTranslate(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "src"    # Ljava/lang/String;
    .param p2, "dest"    # Ljava/lang/String;

    const-string/jumbo v0, "src"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "dest"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 77
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "startTranslate src:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " dest:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " isInitSuccess:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-boolean v2, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->isInitSuccess:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-nez v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    sget-boolean v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->isInitSuccess:Z

    if-eqz v0, :cond_1

    .line 80
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p1, p2}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->sendStartMessage(Ljava/lang/String;Ljava/lang/String;)V

    .line 83
    :cond_1
    return-void
.end method

.method public final stopTranslate()V
    .locals 2

    .line 87
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "stopTranslate"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 89
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->mTranslateConnectClient:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->sendStopMessage()V

    .line 90
    :cond_0
    return-void
.end method
