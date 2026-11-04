.class public final Lcom/rokid/security/sdk/ability/asr/AsrEngine;
.super Ljava/lang/Object;
.source "AsrEngine.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000F\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0012\u001a\u00020\u0013J\u0010\u0010\u0014\u001a\u00020\u00132\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u0016J\u0016\u0010\u0017\u001a\u00020\u00132\u0006\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u001bJ\u000e\u0010\u001c\u001a\u00020\u00132\u0006\u0010\u001d\u001a\u00020\tJ\u0006\u0010\u001e\u001a\u00020\u0013J\u0006\u0010\u001f\u001a\u00020\u0013R\u0014\u0010\u0003\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006R\u0017\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u00020\t0\u0008\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000bR\u001c\u0010\u000c\u001a\u0004\u0018\u00010\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011\u00a8\u0006 "
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/AsrEngine;",
        "",
        "()V",
        "TAG",
        "",
        "getTAG",
        "()Ljava/lang/String;",
        "connectState",
        "Lkotlinx/coroutines/flow/MutableStateFlow;",
        "",
        "getConnectState",
        "()Lkotlinx/coroutines/flow/MutableStateFlow;",
        "mAsrConnectClient",
        "Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;",
        "getMAsrConnectClient",
        "()Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;",
        "setMAsrConnectClient",
        "(Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;)V",
        "destroy",
        "",
        "doSpeechVoice",
        "audioData",
        "",
        "init",
        "config",
        "Lcom/rokid/security/sdk/ability/bean/BaseConfig;",
        "listener",
        "Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;",
        "setConnectState",
        "connect",
        "startSpeech",
        "stopSpeech",
        "sdk-common-ability_release"
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

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

.field private static mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    .line 20
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0}, Lkotlinx/coroutines/flow/StateFlowKt;->MutableStateFlow(Ljava/lang/Object;)Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->connectState:Lkotlinx/coroutines/flow/MutableStateFlow;

    .line 27
    const-string v0, "AsrEngine::"

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final declared-synchronized destroy()V
    .locals 1

    monitor-enter p0

    .line 107
    :try_start_0
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->destroy()V

    .line 108
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrEngine;
    :cond_0
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    .line 109
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->setConnectState(Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 110
    monitor-exit p0

    return-void

    .line 106
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final doSpeechVoice([B)V
    .locals 1
    .param p1, "audioData"    # [B

    .line 102
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendAudioChunk([B)V

    .line 103
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

    .line 20
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->connectState:Lkotlinx/coroutines/flow/MutableStateFlow;

    return-object v0
.end method

.method public final getMAsrConnectClient()Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;
    .locals 1

    .line 17
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    return-object v0
.end method

.method public final getTAG()Ljava/lang/String;
    .locals 1

    .line 27
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public final declared-synchronized init(Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;)V
    .locals 2
    .param p1, "config"    # Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    .param p2, "listener"    # Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    monitor-enter p0

    :try_start_0
    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 32
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->destroy()V

    .line 33
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrEngine;
    :cond_0
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;-><init>()V

    .line 34
    .local v0, "connectClient":Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;
    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    .line 35
    new-instance v1, Lcom/rokid/security/sdk/ability/asr/AsrEngine$init$1;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/asr/AsrEngine$init$1;-><init>()V

    check-cast v1, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->setWebSocketCallback(Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;)V

    .line 85
    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->setAsrListener(Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;)V

    .line 86
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->connect(Lcom/rokid/security/sdk/ability/bean/BaseConfig;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 88
    monitor-exit p0

    return-void

    .line 31
    .end local v0    # "connectClient":Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;
    .end local p1    # "config":Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    .end local p2    # "listener":Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final setConnectState(Z)V
    .locals 2
    .param p1, "connect"    # Z

    .line 24
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->connectState:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/ktx/Kt_ext_flowKt;->call(Lkotlinx/coroutines/flow/MutableStateFlow;Ljava/lang/Object;)V

    .line 25
    return-void
.end method

.method public final setMAsrConnectClient(Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    .line 17
    sput-object p1, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    return-void
.end method

.method public final startSpeech()V
    .locals 1

    .line 91
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendStartMessage()V

    .line 92
    :cond_0
    return-void
.end method

.method public final stopSpeech()V
    .locals 1

    .line 97
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->mAsrConnectClient:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendStopMessage()V

    .line 98
    :cond_0
    return-void
.end method
