.class public final Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;
.super Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
.source "AsrConnectClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;,
        Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAsrConnectClient.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AsrConnectClient.kt\ncom/rokid/security/sdk/ability/asr/AsrConnectClient\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n*L\n1#1,292:1\n1#2:293\n215#3,2:294\n*S KotlinDebug\n*F\n+ 1 AsrConnectClient.kt\ncom/rokid/security/sdk/ability/asr/AsrConnectClient\n*L\n241#1:294,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000p\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010\u0003\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0010\u0012\n\u0002\u0008\u0008\u0018\u0000 62\u00020\u0001:\u000256B\u0005\u00a2\u0006\u0002\u0010\u0002J\u001a\u0010\u0012\u001a\u0004\u0018\u00010\u00132\u0006\u0010\u0014\u001a\u00020\u00042\u0006\u0010\u0015\u001a\u00020\u0004H\u0002J\u0018\u0010\u0016\u001a\u00020\u00172\u0006\u0010\u0015\u001a\u00020\u00042\u0006\u0010\u0018\u001a\u00020\u0019H\u0002J\u001a\u0010\u001a\u001a\u00020\u00172\u0006\u0010\u0015\u001a\u00020\u00042\u0008\u0010\u001b\u001a\u0004\u0018\u00010\u0004H\u0002J\u0010\u0010\u001c\u001a\u00020\u00172\u0006\u0010\u001d\u001a\u00020\u001eH\u0002J\u001a\u0010\u001f\u001a\u00020\u00172\u0008\u0010\u001b\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0015\u001a\u00020\u0004H\u0002J\u0018\u0010 \u001a\u00020\u00172\u0006\u0010!\u001a\u00020\"2\u0006\u0010#\u001a\u00020\u0004H\u0016J\u001a\u0010$\u001a\u00020\u00172\u0006\u0010%\u001a\u00020&2\u0008\u0010\'\u001a\u0004\u0018\u00010(H\u0016J\u0010\u0010)\u001a\u00020\u00172\u0006\u0010*\u001a\u00020\u0004H\u0016J\u0010\u0010+\u001a\u00020\u00172\u0006\u0010\'\u001a\u00020(H\u0016J\u0008\u0010,\u001a\u00020\u0017H\u0002J\u0010\u0010-\u001a\u00020\u00172\u0008\u0010.\u001a\u0004\u0018\u00010/J\u0010\u00100\u001a\u00020\u00172\u0006\u0010#\u001a\u00020\u0004H\u0002J\u0006\u00101\u001a\u00020\u0017J\u0006\u00102\u001a\u00020\u0017J\u000e\u00103\u001a\u00020\u00172\u0006\u0010\u0008\u001a\u00020\tJ\u0012\u00104\u001a\u00020\u00042\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u0004H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0011X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u00067"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;",
        "Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;",
        "()V",
        "TAG",
        "",
        "droppedAudioChunks",
        "",
        "lastAudioStatsLogMs",
        "listener",
        "Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;",
        "mGson",
        "Lcom/google/gson/Gson;",
        "sentAudioBytes",
        "sentAudioChunks",
        "startRecovery",
        "Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;",
        "taskLifecycle",
        "Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;",
        "createHeader",
        "Lorg/json/JSONObject;",
        "action",
        "taskId",
        "finishTask",
        "",
        "failed",
        "",
        "finishUnknownTask",
        "event",
        "handleAsrResult",
        "payload",
        "Lcom/rokid/security/sdk/ability/bean/Payload;",
        "logStaleResponse",
        "onClosed",
        "code",
        "",
        "reason",
        "onFailure",
        "t",
        "",
        "response",
        "Lokhttp3/Response;",
        "onMessage",
        "text",
        "onOpen",
        "resetAudioStats",
        "sendAudioChunk",
        "audioData",
        "",
        "sendPendingStart",
        "sendStartMessage",
        "sendStopMessage",
        "setAsrListener",
        "shortTaskId",
        "AsrListener",
        "Companion",
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
.field private static final AUDIO_STATS_LOG_INTERVAL_MS:J = 0x3e8L

.field public static final Companion:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$Companion;


# instance fields
.field private final TAG:Ljava/lang/String;

.field private droppedAudioChunks:J

.field private lastAudioStatsLogMs:J

.field private listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

.field private mGson:Lcom/google/gson/Gson;

.field private sentAudioBytes:J

.field private sentAudioChunks:J

.field private final startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

.field private final taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->Companion:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 34
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;-><init>()V

    .line 36
    const-string v0, "AsrConnectClient::"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    .line 37
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->mGson:Lcom/google/gson/Gson;

    .line 52
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    .line 57
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    .line 34
    return-void
.end method

.method private final createHeader(Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 9
    .param p1, "action"    # Ljava/lang/String;
    .param p2, "taskId"    # Ljava/lang/String;

    .line 234
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 235
    .local v0, "header":Lorg/json/JSONObject;
    nop

    .line 236
    :try_start_0
    const-string/jumbo v1, "taskId"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 237
    const-string v1, "reqId"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 238
    const-string/jumbo v1, "task"

    const-string v2, "asr"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 239
    const-string v1, "action"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 240
    const-string/jumbo v1, "version"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getVersion()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 241
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getMHeaderMap()Ljava/util/Map;

    move-result-object v1

    .local v1, "$this$forEach$iv":Ljava/util/Map;
    const/4 v2, 0x0

    .line 294
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .local v4, "element$iv":Ljava/util/Map$Entry;
    move-object v5, v4

    .local v5, "it":Ljava/util/Map$Entry;
    const/4 v6, 0x0

    .line 242
    .local v6, "$i$a$-forEach-AsrConnectClient$createHeader$1":I
    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v0, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 243
    nop

    .line 294
    .end local v5    # "it":Ljava/util/Map$Entry;
    .end local v6    # "$i$a$-forEach-AsrConnectClient$createHeader$1":I
    nop

    .end local v4    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_1

    .line 295
    :cond_1
    nop

    .end local v1    # "$this$forEach$iv":Ljava/util/Map;
    .end local v2    # "$i$f$forEach":I
    goto :goto_2

    .line 244
    :catch_0
    move-exception v1

    .line 246
    :goto_2
    return-object v0
.end method

.method private final finishTask(Ljava/lang/String;Z)V
    .locals 5
    .param p1, "taskId"    # Ljava/lang/String;
    .param p2, "failed"    # Z

    .line 96
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->terminate(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    move-result-object v0

    .line 97
    .local v0, "previous":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    if-nez v0, :cond_1

    .line 98
    if-eqz p2, :cond_0

    const-string v1, "Failed"

    goto :goto_0

    :cond_0
    const-string v1, "Ended"

    :goto_0
    invoke-direct {p0, v1, p1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->logStaleResponse(Ljava/lang/String;Ljava/lang/String;)V

    .line 99
    return-void

    .line 101
    :cond_1
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->cancel()V

    .line 102
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "asrAudioStats terminal taskId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " failed="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " previous="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " chunks="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioChunks:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " bytes="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioBytes:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " dropped="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->droppedAudioChunks:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 103
    if-eqz p2, :cond_2

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STOPPING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-eq v0, v1, :cond_2

    .line 104
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v1, :cond_3

    const/16 v2, -0x2714

    const-string v3, "ASR task failed"

    invoke-interface {v1, v2, v3}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onError(ILjava/lang/String;)V

    goto :goto_1

    .line 106
    :cond_2
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v1, :cond_3

    invoke-interface {v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onFinish()V

    .line 108
    :cond_3
    :goto_1
    return-void
.end method

.method private final finishUnknownTask(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "taskId"    # Ljava/lang/String;
    .param p2, "event"    # Ljava/lang/String;

    .line 111
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->terminate(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    move-result-object v0

    .line 112
    .local v0, "previous":Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;
    if-nez v0, :cond_0

    .line 113
    invoke-direct {p0, p2, p1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->logStaleResponse(Ljava/lang/String;Ljava/lang/String;)V

    .line 114
    return-void

    .line 116
    :cond_0
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->cancel()V

    .line 117
    sget-object v1, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;->STOPPING:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    if-ne v0, v1, :cond_1

    .line 118
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v1, :cond_2

    invoke-interface {v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onFinish()V

    goto :goto_0

    .line 120
    :cond_1
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v1, :cond_2

    const/16 v2, -0x2712

    const-string v3, "Unknown ASR event"

    invoke-interface {v1, v2, v3}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onError(ILjava/lang/String;)V

    .line 122
    :cond_2
    :goto_0
    return-void
.end method

.method private final handleAsrResult(Lcom/rokid/security/sdk/ability/bean/Payload;)V
    .locals 5
    .param p1, "payload"    # Lcom/rokid/security/sdk/ability/bean/Payload;

    .line 129
    nop

    .line 130
    :try_start_0
    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/bean/Payload;->getHasFinal()Z

    move-result v0

    .line 131
    .local v0, "isFinal":Z
    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/bean/Payload;->getText()Ljava/lang/String;

    move-result-object v1

    .line 133
    .local v1, "text":Ljava/lang/String;
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleAsrResult textChars="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " isFinal:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    if-eqz v0, :cond_0

    .line 135
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v2, :cond_1

    invoke-interface {v2, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onFinalResult(Ljava/lang/String;)V

    goto :goto_0

    .line 137
    :cond_0
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v2, :cond_1

    invoke-interface {v2, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onPartialResult(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 139
    .end local v0    # "isFinal":Z
    .end local v1    # "text":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 141
    :cond_1
    :goto_0
    return-void
.end method

.method private final logStaleResponse(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "taskId"    # Ljava/lang/String;

    .line 125
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ignore stale ASR response event="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " taskId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0, p2}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " current="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->currentTaskId()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 126
    return-void
.end method

.method private final resetAudioStats()V
    .locals 2

    .line 274
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioChunks:J

    .line 275
    iput-wide v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioBytes:J

    .line 276
    iput-wide v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->droppedAudioChunks:J

    .line 277
    iput-wide v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->lastAudioStatsLogMs:J

    .line 278
    return-void
.end method

.method private final declared-synchronized sendPendingStart(Ljava/lang/String;)V
    .locals 5
    .param p1, "reason"    # Ljava/lang/String;

    monitor-enter p0

    .line 219
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->nextToSend()Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    monitor-exit p0

    return-void

    .line 220
    .local v0, "pending":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;
    :cond_0
    :try_start_1
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;->getTaskId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->canReplayStart(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 221
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->cancel()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 222
    monitor-exit p0

    return-void

    .line 224
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;
    :cond_1
    :try_start_2
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendMessage(Ljava/lang/String;)Z

    move-result v1

    .line 225
    .local v1, "accepted":Z
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;->getTaskId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v1}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->onSendResult(Ljava/lang/String;Z)V

    .line 226
    if-eqz v1, :cond_2

    .line 227
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "ASR Start accepted reason="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " taskId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;->getTaskId()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 229
    :cond_2
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "ASR Start retained until connection recovers taskId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;->getTaskId()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 231
    :goto_0
    monitor-exit p0

    return-void

    .line 218
    .end local v0    # "pending":Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery$Request;
    .end local v1    # "accepted":Z
    .end local p1    # "reason":Ljava/lang/String;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method private final shortTaskId(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "taskId"    # Ljava/lang/String;

    .line 280
    if-eqz p1, :cond_0

    const/16 v0, 0x8

    invoke-static {p1, v0}, Lkotlin/text/StringsKt;->take(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    const-string v0, ""

    :cond_1
    return-object v0
.end method


# virtual methods
.method public onClosed(ILjava/lang/String;)V
    .locals 1
    .param p1, "code"    # I
    .param p2, "reason"    # Ljava/lang/String;

    const-string v0, "reason"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 213
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->markTransportLost()V

    .line 214
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->onTransportLost()V

    .line 215
    return-void
.end method

.method public onFailure(Ljava/lang/Throwable;Lokhttp3/Response;)V
    .locals 1
    .param p1, "t"    # Ljava/lang/Throwable;
    .param p2, "response"    # Lokhttp3/Response;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 208
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->markTransportLost()V

    .line 209
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->onTransportLost()V

    .line 210
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 8
    .param p1, "text"    # Ljava/lang/String;

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 70
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->mGson:Lcom/google/gson/Gson;

    const-class v1, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;

    .line 71
    .local v0, "response":Lcom/rokid/security/sdk/ability/bean/WekWsResponse;
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getHeader()Lcom/rokid/security/sdk/ability/bean/Header;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/bean/Header;->getTaskId()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    if-nez v1, :cond_1

    const-string v1, ""

    .line 72
    .local v1, "responseTaskId":Ljava/lang/String;
    :cond_1
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getHeader()Lcom/rokid/security/sdk/ability/bean/Header;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/Header;->getEvent()Ljava/lang/String;

    move-result-object v2

    .line 73
    .local v2, "event":Ljava/lang/String;
    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onMessage event="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " taskId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-direct {p0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " hasPayload="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getPayload()Lcom/rokid/security/sdk/ability/bean/Payload;

    move-result-object v5

    const/4 v6, 0x1

    const/4 v7, 0x0

    if-eqz v5, :cond_3

    move v5, v6

    goto :goto_1

    :cond_3
    move v5, v7

    :goto_1
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 74
    if-eqz v2, :cond_a

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v3

    sparse-switch v3, :sswitch_data_0

    goto :goto_2

    :sswitch_0
    const-string v3, "Failed"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    goto :goto_2

    .line 90
    :cond_4
    invoke-direct {p0, v1, v6}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->finishTask(Ljava/lang/String;Z)V

    goto :goto_3

    .line 74
    :sswitch_1
    const-string v3, "Ended"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    goto :goto_2

    .line 89
    :cond_5
    invoke-direct {p0, v1, v7}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->finishTask(Ljava/lang/String;Z)V

    goto :goto_3

    .line 74
    :sswitch_2
    const-string v3, "Started"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    goto :goto_2

    .line 83
    :cond_6
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v3, v1}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->markStarted(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_7

    .line 84
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v3, :cond_b

    invoke-interface {v3}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onStart()V

    goto :goto_3

    .line 86
    :cond_7
    invoke-direct {p0, v2, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->logStaleResponse(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 74
    :sswitch_3
    const-string v3, "Generated"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    goto :goto_2

    .line 76
    :cond_8
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v3, v1}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->acceptsResult(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 77
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getPayload()Lcom/rokid/security/sdk/ability/bean/Payload;

    move-result-object v3

    if-eqz v3, :cond_b

    .line 293
    .local v3, "it":Lcom/rokid/security/sdk/ability/bean/Payload;
    const/4 v4, 0x0

    .line 77
    .local v4, "$i$a$-let-AsrConnectClient$onMessage$1":I
    invoke-direct {p0, v3}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->handleAsrResult(Lcom/rokid/security/sdk/ability/bean/Payload;)V

    .end local v3    # "it":Lcom/rokid/security/sdk/ability/bean/Payload;
    .end local v4    # "$i$a$-let-AsrConnectClient$onMessage$1":I
    goto :goto_3

    .line 79
    :cond_9
    invoke-direct {p0, v2, v1}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->logStaleResponse(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 91
    :cond_a
    :goto_2
    invoke-direct {p0, v1, v2}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->finishUnknownTask(Ljava/lang/String;Ljava/lang/String;)V

    .line 93
    :cond_b
    :goto_3
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x77734691 -> :sswitch_3
        -0xddc279f -> :sswitch_2
        0x3ffda9a -> :sswitch_1
        0x7cfb805d -> :sswitch_0
    .end sparse-switch
.end method

.method public onOpen(Lokhttp3/Response;)V
    .locals 1
    .param p1, "response"    # Lokhttp3/Response;

    const-string v0, "response"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 204
    const-string v0, "reconnected"

    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendPendingStart(Ljava/lang/String;)V

    .line 205
    return-void
.end method

.method public final sendAudioChunk([B)V
    .locals 10
    .param p1, "audioData"    # [B

    .line 251
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->acceptsAudio()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 252
    :cond_0
    nop

    .line 255
    if-eqz p1, :cond_3

    move-object v0, p1

    .local v0, "it":[B
    const/4 v1, 0x0

    .line 256
    .local v1, "$i$a$-let-AsrConnectClient$sendAudioChunk$1":I
    const/4 v2, 0x0

    array-length v3, v0

    invoke-static {v0, v2, v3}, Lokio/ByteString;->of([BII)Lokio/ByteString;

    move-result-object v2

    .line 257
    .local v2, "byteString":Lokio/ByteString;
    const-string v3, "byteString"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v2}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendMessage(Lokio/ByteString;)Z

    move-result v3

    .line 258
    .local v3, "sent":Z
    const-wide/16 v4, 0x1

    if-eqz v3, :cond_1

    .line 259
    iget-wide v6, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioChunks:J

    add-long/2addr v6, v4

    iput-wide v6, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioChunks:J

    .line 260
    iget-wide v4, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioBytes:J

    array-length v6, v0

    int-to-long v6, v6

    add-long/2addr v4, v6

    iput-wide v4, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioBytes:J

    goto :goto_0

    .line 262
    :cond_1
    iget-wide v6, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->droppedAudioChunks:J

    add-long/2addr v6, v4

    iput-wide v6, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->droppedAudioChunks:J

    .line 264
    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 265
    .local v4, "now":J
    iget-wide v6, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->lastAudioStatsLogMs:J

    sub-long v6, v4, v6

    const-wide/16 v8, 0x3e8

    cmp-long v6, v6, v8

    if-ltz v6, :cond_2

    .line 266
    iput-wide v4, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->lastAudioStatsLogMs:J

    .line 267
    iget-object v6, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "asrAudioStats sending taskId="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v8}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->currentTaskId()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " chunks="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-wide v8, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioChunks:J

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " bytes="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-wide v8, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioBytes:J

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " dropped="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-wide v8, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->droppedAudioChunks:J

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " lastSize="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    array-length v8, v0

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 269
    :cond_2
    nop

    .line 255
    .end local v0    # "it":[B
    .end local v1    # "$i$a$-let-AsrConnectClient$sendAudioChunk$1":I
    .end local v2    # "byteString":Lokio/ByteString;
    .end local v3    # "sent":Z
    .end local v4    # "now":J
    nop

    .line 271
    :cond_3
    return-void
.end method

.method public final declared-synchronized sendStartMessage()V
    .locals 7

    monitor-enter p0

    .line 148
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendStartMessage "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 149
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->generateId()Ljava/lang/String;

    move-result-object v0

    .line 150
    .local v0, "taskId":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v1, v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->begin(Ljava/lang/String;)V

    .line 151
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->resetAudioStats()V

    .line 152
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 153
    .local v1, "payload":Lorg/json/JSONObject;
    nop

    .line 154
    const/4 v2, 0x0

    :try_start_1
    const-string v3, "format"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v4

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getFormatName()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;
    :cond_0
    move-object v4, v2

    :goto_0
    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 155
    const-string v3, "rate"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v4

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getSampleRate()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    goto :goto_1

    :cond_1
    move-object v4, v2

    :goto_1
    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 156
    const-string v3, "channel"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getChannel()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    goto :goto_2

    :cond_2
    move-object v4, v2

    :goto_2
    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 157
    const-string v3, "bits"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v4

    if-eqz v4, :cond_3

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getBits()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    goto :goto_3

    :cond_3
    move-object v4, v2

    :goto_3
    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_4

    .line 159
    :catch_0
    move-exception v3

    .line 161
    :goto_4
    :try_start_2
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 162
    .local v3, "message":Lorg/json/JSONObject;
    nop

    .line 163
    :try_start_3
    const-string v4, "header"

    const-string v5, "Start"

    invoke-direct {p0, v5, v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->createHeader(Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 164
    const-string v4, "payload"

    invoke-virtual {v3, v4, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_5

    .line 165
    :catch_1
    move-exception v4

    .line 167
    :goto_5
    :try_start_4
    iget-object v4, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "message.toString()"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v0, v5}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->begin(Ljava/lang/String;Ljava/lang/String;)V

    .line 168
    iget-object v4, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "asrAudioStats start taskId="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " format="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v6

    if-eqz v6, :cond_4

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getFormatName()Ljava/lang/String;

    move-result-object v6

    goto :goto_6

    :cond_4
    move-object v6, v2

    :goto_6
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " rate="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v6

    if-eqz v6, :cond_5

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getSampleRate()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    goto :goto_7

    :cond_5
    move-object v6, v2

    :goto_7
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " channel="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v6

    if-eqz v6, :cond_6

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getChannel()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    goto :goto_8

    :cond_6
    move-object v6, v2

    :goto_8
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " bits="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v6

    if-eqz v6, :cond_7

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getBits()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    :cond_7
    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v4, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 169
    const-string v2, "request"

    invoke-direct {p0, v2}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendPendingStart(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 170
    monitor-exit p0

    return-void

    .line 147
    .end local v0    # "taskId":Ljava/lang/String;
    .end local v1    # "payload":Lorg/json/JSONObject;
    .end local v3    # "message":Lorg/json/JSONObject;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized sendStopMessage()V
    .locals 6

    monitor-enter p0

    .line 176
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->requestStop()Ljava/lang/String;

    move-result-object v0

    .line 177
    .local v0, "taskId":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 178
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    const-string v2, "ignore duplicate ASR stop: no active task"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 179
    monitor-exit p0

    return-void

    .line 181
    .end local p0    # "this":Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;
    :cond_0
    :try_start_1
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "asrAudioStats stop request taskId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " chunks="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioChunks:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " bytes="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sentAudioBytes:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " dropped="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->droppedAudioChunks:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 182
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 183
    .local v1, "payload":Lorg/json/JSONObject;
    nop

    .line 184
    :try_start_2
    const-string v2, "format"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getFormatName()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_1
    move-object v3, v4

    :goto_0
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 185
    const-string v2, "rate"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getSampleRate()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    :cond_2
    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 187
    :catch_0
    move-exception v2

    .line 189
    :goto_1
    :try_start_3
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 190
    .local v2, "message":Lorg/json/JSONObject;
    nop

    .line 191
    :try_start_4
    const-string v3, "header"

    const-string v4, "End"

    invoke-direct {p0, v4, v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->createHeader(Ljava/lang/String;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 192
    const-string v3, "payload"

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_2

    .line 193
    :catch_1
    move-exception v3

    .line 195
    :goto_2
    :try_start_5
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->startRecovery:Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/asr/AsrStartRecovery;->cancel()V

    .line 196
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "message.toString()"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v3}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->sendMessage(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 197
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->taskLifecycle:Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;

    invoke-virtual {v3, v0}, Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle;->terminate(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/AsrTaskLifecycle$State;

    .line 198
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    if-eqz v3, :cond_3

    invoke-interface {v3}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;->onFinish()V

    .line 199
    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "ASR stop completed locally because transport is unavailable taskId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->shortTaskId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 201
    :cond_4
    monitor-exit p0

    return-void

    .line 175
    .end local v0    # "taskId":Ljava/lang/String;
    .end local v1    # "payload":Lorg/json/JSONObject;
    .end local v2    # "message":Lorg/json/JSONObject;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final setAsrListener(Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 63
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/asr/AsrConnectClient;->listener:Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;

    .line 64
    return-void
.end method
