.class public final Lcom/rokid/security/sdk/ability/tts/TtsManager;
.super Ljava/lang/Object;
.source "TtsManager.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/message/ICommonMessage;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTtsManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TtsManager.kt\ncom/rokid/security/sdk/ability/tts/TtsManager\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,189:1\n1#2:190\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000M\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0008\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0000*\u0001\u0010\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0012\u001a\u00020\u00132\u0006\u0010\u0014\u001a\u00020\u000cJ\u0006\u0010\u0015\u001a\u00020\u0013J\u000e\u0010\u0016\u001a\u00020\u00132\u0006\u0010\u0017\u001a\u00020\u0018J\u0006\u0010\u0019\u001a\u00020\u0013J\u0010\u0010\u001a\u001a\u00020\u00132\u0006\u0010\u001b\u001a\u00020\u000cH\u0002J\u0018\u0010\u001c\u001a\u00020\u00132\u0006\u0010\u001d\u001a\u00020\u00042\u0006\u0010\u001e\u001a\u00020\u0018H\u0016J\u000e\u0010\u001f\u001a\u00020\u00132\u0006\u0010 \u001a\u00020!R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000f\u001a\u00020\u0010X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0011\u00a8\u0006\""
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/tts/TtsManager;",
        "Lcom/rokid/security/sdk/ability/message/ICommonMessage;",
        "()V",
        "TAG",
        "",
        "connectStateJob",
        "Lkotlinx/coroutines/Job;",
        "currentSessionId",
        "",
        "initialized",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "isPlaying",
        "",
        "mPcmAudioRecorder",
        "Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;",
        "ttsConnectClient",
        "com/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1",
        "Lcom/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1;",
        "controlTtsEvent",
        "",
        "start",
        "destroy",
        "handleError",
        "errorCode",
        "",
        "initTts",
        "onConnectState",
        "connect",
        "onMessage",
        "msg",
        "type",
        "onTtsMethod",
        "extra",
        "Lcom/rokid/security/sdk/base/common/TtsExtra;",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsManager;

.field private static final TAG:Ljava/lang/String;

.field private static connectStateJob:Lkotlinx/coroutines/Job;

.field private static volatile currentSessionId:J

.field private static final initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static volatile isPlaying:Z

.field private static mPcmAudioRecorder:Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;

.field private static final ttsConnectClient:Lcom/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/tts/TtsManager;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsManager;

    .line 34
    const-string v0, "TtsManager::"

    sput-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->TAG:Ljava/lang/String;

    .line 35
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->mPcmAudioRecorder:Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;

    .line 40
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 80
    new-instance v0, Lcom/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->ttsConnectClient:Lcom/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 31
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$isPlaying$p()Z
    .locals 1

    .line 31
    sget-boolean v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->isPlaying:Z

    return v0
.end method

.method public static final synthetic access$onConnectState(Lcom/rokid/security/sdk/ability/tts/TtsManager;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/tts/TtsManager;
    .param p1, "connect"    # Z

    .line 31
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->onConnectState(Z)V

    return-void
.end method

.method private final onConnectState(Z)V
    .locals 10
    .param p1, "connect"    # Z

    .line 146
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onConnectState-->"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 147
    new-instance v0, Lcom/rokid/security/sdk/base/common/TtsExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/TtsExtra;-><init>()V

    .line 148
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/TtsExtra;
    const-string v1, "connectState"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setMethodName(Ljava/lang/String;)V

    .line 149
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setConnectState(Z)V

    .line 150
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 151
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "TTS_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 152
    return-void
.end method


# virtual methods
.method public final controlTtsEvent(Z)V
    .locals 10
    .param p1, "start"    # Z

    .line 157
    new-instance v0, Lcom/rokid/security/sdk/base/common/TtsExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/TtsExtra;-><init>()V

    .line 158
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/TtsExtra;
    const-string v1, "onAudioStreamBack"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setMethodName(Ljava/lang/String;)V

    .line 159
    sget-wide v1, Lcom/rokid/security/sdk/ability/tts/TtsManager;->currentSessionId:J

    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setSessionId(J)V

    .line 160
    xor-int/lit8 v1, p1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setEnd(Z)V

    .line 161
    sget-object v2, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const-string v1, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v4, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "TTS_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 162
    return-void
.end method

.method public final declared-synchronized destroy()V
    .locals 3

    monitor-enter p0

    .line 178
    :try_start_0
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    monitor-exit p0

    return-void

    .line 179
    :cond_0
    :try_start_1
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->connectStateJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 180
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/tts/TtsManager;
    :cond_1
    sput-object v1, Lcom/rokid/security/sdk/ability/tts/TtsManager;->connectStateJob:Lkotlinx/coroutines/Job;

    .line 181
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->unInjectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V

    .line 182
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->destroy()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 183
    monitor-exit p0

    return-void

    .line 177
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final handleError(I)V
    .locals 11
    .param p1, "errorCode"    # I

    .line 168
    new-instance v0, Lcom/rokid/security/sdk/base/common/TtsExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/TtsExtra;-><init>()V

    .line 169
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/TtsExtra;
    const-string v1, "onTtsCallBack"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setMethodName(Ljava/lang/String;)V

    .line 170
    sget-wide v1, Lcom/rokid/security/sdk/ability/tts/TtsManager;->currentSessionId:J

    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setSessionId(J)V

    .line 171
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setErrorCode(I)V

    .line 172
    sget-object v3, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const-string v1, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v5, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const-string v4, "TTS_ACTION"

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 173
    return-void
.end method

.method public final declared-synchronized initTts()V
    .locals 12

    monitor-enter p0

    .line 46
    :try_start_0
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 47
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->TAG:Ljava/lang/String;

    const-string v1, "initTts ignored: already initialized"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 48
    monitor-exit p0

    return-void

    .line 50
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/tts/TtsManager;
    :cond_0
    nop

    .line 51
    const/4 v0, 0x0

    :try_start_1
    sget-object v3, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v3

    move-object v4, p0

    check-cast v4, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v3, v4}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->injectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V

    .line 52
    new-instance v3, Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    invoke-direct {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;-><init>()V

    .line 53
    .local v3, "mConfig":Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    sget-object v4, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getWS_TTS()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->setServerUrl(Ljava/lang/String;)V

    .line 55
    sget-object v4, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    sget-object v5, Lcom/rokid/security/sdk/ability/tts/TtsManager;->ttsConnectClient:Lcom/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1;

    check-cast v5, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

    invoke-virtual {v4, v3, v5}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->init(Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;)V

    .line 58
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v6

    new-instance v4, Lcom/rokid/security/sdk/ability/tts/TtsManager$initTts$1;

    invoke-direct {v4, v0}, Lcom/rokid/security/sdk/ability/tts/TtsManager$initTts$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v9, v4

    check-cast v9, Lkotlin/jvm/functions/Function2;

    const/4 v10, 0x3

    const/4 v11, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v6 .. v11}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v4

    sput-object v4, Lcom/rokid/security/sdk/ability/tts/TtsManager;->connectStateJob:Lkotlinx/coroutines/Job;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 74
    .end local v3    # "mConfig":Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    monitor-exit p0

    return-void

    .line 64
    :catchall_0
    move-exception v3

    .line 65
    .local v3, "e":Ljava/lang/Throwable;
    :try_start_2
    sget-object v4, Lcom/rokid/security/sdk/ability/tts/TtsManager;->initialized:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v4, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 66
    sget-object v2, Lcom/rokid/security/sdk/ability/tts/TtsManager;->connectStateJob:Lkotlinx/coroutines/Job;

    if-eqz v2, :cond_1

    invoke-static {v2, v0, v1, v0}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 67
    :cond_1
    sput-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->connectStateJob:Lkotlinx/coroutines/Job;

    .line 68
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->destroy()V

    .line 69
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;

    move-result-object v0

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/message/IMessageAction;->unInjectIMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;)V

    .line 70
    throw v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 45
    .end local v3    # "e":Ljava/lang/Throwable;
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public onAudioStream([BI)V
    .locals 0
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    .line 31
    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage$DefaultImpls;->onAudioStream(Lcom/rokid/security/sdk/ability/message/ICommonMessage;[BI)V

    return-void
.end method

.method public onMessage(Ljava/lang/String;I)V
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "TTS_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 113
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 114
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 115
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/TtsExtra;

    invoke-virtual {v1, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/TtsExtra;

    .line 116
    .local v1, "mTtsExtra":Lcom/rokid/security/sdk/base/common/TtsExtra;
    const-string v2, "mTtsExtra"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->onTtsMethod(Lcom/rokid/security/sdk/base/common/TtsExtra;)V

    .line 118
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "mTtsExtra":Lcom/rokid/security/sdk/base/common/TtsExtra;
    :cond_0
    return-void
.end method

.method public final onTtsMethod(Lcom/rokid/security/sdk/base/common/TtsExtra;)V
    .locals 10
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/TtsExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 124
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onTtsMethod:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    .line 126
    const-string v1, "doSpeechTts"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    const-wide/16 v5, 0x0

    if-eqz v1, :cond_3

    .line 127
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->getSessionId()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->longValue()J

    move-result-wide v7

    .line 190
    .local v7, "it":J
    const/4 v1, 0x0

    .line 127
    .local v1, "$i$a$-takeIf-TtsManager$onTtsMethod$1":I
    cmp-long v5, v7, v5

    if-eqz v5, :cond_0

    move v4, v3

    .end local v1    # "$i$a$-takeIf-TtsManager$onTtsMethod$1":I
    .end local v7    # "it":J
    :cond_0
    if-eqz v4, :cond_1

    move-object v2, v0

    :cond_1
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->getId()I

    move-result v0

    int-to-long v0, v0

    :goto_0
    sput-wide v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->currentSessionId:J

    .line 128
    sput-boolean v3, Lcom/rokid/security/sdk/ability/tts/TtsManager;->isPlaying:Z

    .line 129
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->getContent()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->playTts(Ljava/lang/String;)V

    goto :goto_3

    .line 131
    :cond_3
    const-string v1, "doCancelTts"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 132
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->getSessionId()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->longValue()J

    move-result-wide v7

    .line 190
    .restart local v7    # "it":J
    const/4 v1, 0x0

    .line 132
    .local v1, "$i$a$-takeIf-TtsManager$onTtsMethod$sessionId$1":I
    cmp-long v9, v7, v5

    if-eqz v9, :cond_4

    goto :goto_1

    :cond_4
    move v3, v4

    .end local v1    # "$i$a$-takeIf-TtsManager$onTtsMethod$sessionId$1":I
    .end local v7    # "it":J
    :goto_1
    if-eqz v3, :cond_5

    move-object v2, v0

    :cond_5
    if-eqz v2, :cond_6

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    goto :goto_2

    :cond_6
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->getId()I

    move-result v0

    int-to-long v0, v0

    .line 133
    .local v0, "sessionId":J
    :goto_2
    cmp-long v2, v0, v5

    if-eqz v2, :cond_7

    sget-wide v2, Lcom/rokid/security/sdk/ability/tts/TtsManager;->currentSessionId:J

    cmp-long v2, v0, v2

    if-nez v2, :cond_8

    .line 134
    :cond_7
    sput-boolean v4, Lcom/rokid/security/sdk/ability/tts/TtsManager;->isPlaying:Z

    .line 135
    sget-object v2, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->stopTts()V

    .line 136
    sput-wide v5, Lcom/rokid/security/sdk/ability/tts/TtsManager;->currentSessionId:J

    .line 141
    .end local v0    # "sessionId":J
    :cond_8
    :goto_3
    return-void
.end method

.method public onVideoStream([BI)V
    .locals 0
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    .line 31
    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/message/ICommonMessage$DefaultImpls;->onVideoStream(Lcom/rokid/security/sdk/ability/message/ICommonMessage;[BI)V

    return-void
.end method
