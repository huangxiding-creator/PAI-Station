.class public final Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;
.super Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
.source "TtsConnectClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;,
        Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTtsConnectClient.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TtsConnectClient.kt\ncom/rokid/security/sdk/ability/tts/TtsConnectClient\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n*L\n1#1,222:1\n1#2:223\n215#3,2:224\n*S KotlinDebug\n*F\n+ 1 TtsConnectClient.kt\ncom/rokid/security/sdk/ability/tts/TtsConnectClient\n*L\n205#1:224,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000L\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0007\u0018\u00002\u00020\u0001:\u0002\u001e\u001fB\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\u0004H\u0002J\u000e\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u0004J\u0010\u0010\u0014\u001a\u00020\u00122\u0006\u0010\u0015\u001a\u00020\u0016H\u0002J\u0010\u0010\u0017\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u0004H\u0016J\u0010\u0010\u0017\u001a\u00020\u00122\u0006\u0010\u0018\u001a\u00020\u0019H\u0016J\u0008\u0010\u001a\u001a\u00020\u0012H\u0002J\u000e\u0010\u001b\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u0004J\u0006\u0010\u001c\u001a\u00020\u0012J\u000e\u0010\u001d\u001a\u00020\u00122\u0006\u0010\u0006\u001a\u00020\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0006\u001a\u0004\u0018\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u00040\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006 "
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;",
        "Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;",
        "()V",
        "TAG",
        "",
        "currentTaskId",
        "listener",
        "Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;",
        "mGson",
        "Lcom/google/gson/Gson;",
        "mTtsState",
        "Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;",
        "ttsQueue",
        "Ljava/util/Queue;",
        "createHeader",
        "Lorg/json/JSONObject;",
        "action",
        "doSendTtsRequest",
        "",
        "text",
        "handleTtsResult",
        "header",
        "Lcom/rokid/security/sdk/ability/bean/Header;",
        "onMessage",
        "bytes",
        "Lokio/ByteString;",
        "playNextFromQueue",
        "sendStartMessage",
        "sendStopMessage",
        "setTtsListener",
        "TtsListener",
        "TtsState",
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


# instance fields
.field private final TAG:Ljava/lang/String;

.field private currentTaskId:Ljava/lang/String;

.field private listener:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

.field private mGson:Lcom/google/gson/Gson;

.field private volatile mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

.field private ttsQueue:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;-><init>()V

    .line 22
    const-string v0, "TtsConnectClient::"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    .line 23
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mGson:Lcom/google/gson/Gson;

    .line 25
    new-instance v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;-><init>()V

    check-cast v0, Ljava/util/Queue;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->ttsQueue:Ljava/util/Queue;

    .line 29
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Idle:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 20
    return-void
.end method

.method private final createHeader(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 9
    .param p1, "action"    # Ljava/lang/String;

    .line 198
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 199
    .local v0, "header":Lorg/json/JSONObject;
    nop

    .line 200
    :try_start_0
    const-string/jumbo v1, "taskId"

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->currentTaskId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 201
    const-string v1, "reqId"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 202
    const-string/jumbo v1, "task"

    const-string/jumbo v2, "tts"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 203
    const-string v1, "action"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 204
    const-string/jumbo v1, "version"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getVersion()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 205
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getMHeaderMap()Ljava/util/Map;

    move-result-object v1

    .local v1, "$this$forEach$iv":Ljava/util/Map;
    const/4 v2, 0x0

    .line 224
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

    .line 206
    .local v6, "$i$a$-forEach-TtsConnectClient$createHeader$1":I
    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v0, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 207
    nop

    .line 224
    .end local v5    # "it":Ljava/util/Map$Entry;
    .end local v6    # "$i$a$-forEach-TtsConnectClient$createHeader$1":I
    nop

    .end local v4    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_1

    .line 225
    :cond_1
    nop

    .end local v1    # "$this$forEach$iv":Ljava/util/Map;
    .end local v2    # "$i$f$forEach":I
    goto :goto_2

    .line 208
    :catch_0
    move-exception v1

    .line 209
    :goto_2
    return-object v0
.end method

.method private final handleTtsResult(Lcom/rokid/security/sdk/ability/bean/Header;)V
    .locals 3
    .param p1, "header"    # Lcom/rokid/security/sdk/ability/bean/Header;

    .line 62
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleTtsResult "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/bean/Header;->getEvent()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x20

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 64
    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/bean/Header;->getEvent()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    :goto_0
    goto :goto_1

    :sswitch_0
    const-string v1, "Failed"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 79
    :cond_0
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Failed:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 80
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->listener:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

    if-eqz v0, :cond_1

    const/4 v1, -0x1

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;->onError(I)V

    .line 82
    :cond_1
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Idle:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 83
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->playNextFromQueue()V

    goto :goto_1

    .line 64
    :sswitch_1
    const-string v1, "Ended"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    .line 71
    :cond_2
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Ended:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 72
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->listener:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

    if-eqz v0, :cond_3

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;->onFinish()V

    .line 74
    :cond_3
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Idle:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 75
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->playNextFromQueue()V

    goto :goto_1

    .line 64
    :sswitch_2
    const-string v1, "Started"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    goto :goto_0

    .line 66
    :cond_4
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Started:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 67
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->listener:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

    if-eqz v0, :cond_5

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;->onStart()V

    .line 90
    :cond_5
    :goto_1
    return-void

    :sswitch_data_0
    .sparse-switch
        -0xddc279f -> :sswitch_2
        0x3ffda9a -> :sswitch_1
        0x7cfb805d -> :sswitch_0
    .end sparse-switch
.end method

.method private final playNextFromQueue()V
    .locals 5

    .line 187
    monitor-enter p0

    const/4 v0, 0x0

    .line 188
    .local v0, "$i$a$-synchronized-TtsConnectClient$playNextFromQueue$1":I
    :try_start_0
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->ttsQueue:Ljava/util/Queue;

    invoke-interface {v1}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 189
    .local v1, "nextText":Ljava/lang/String;
    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    sget-object v3, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Idle:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    if-ne v2, v3, :cond_0

    .line 190
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "playNextFromQueue textChars="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 191
    sget-object v2, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Started:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v2, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 192
    invoke-virtual {p0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->doSendTtsRequest(Ljava/lang/String;)V

    .line 194
    :cond_0
    nop

    .end local v0    # "$i$a$-synchronized-TtsConnectClient$playNextFromQueue$1":I
    .end local v1    # "nextText":Ljava/lang/String;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 187
    monitor-exit p0

    .line 195
    return-void

    .line 187
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method


# virtual methods
.method public final doSendTtsRequest(Ljava/lang/String;)V
    .locals 6
    .param p1, "text"    # Ljava/lang/String;

    const-string v0, "rate"

    const-string/jumbo v1, "text"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 116
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->generateId()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->currentTaskId:Ljava/lang/String;

    .line 117
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 118
    .local v2, "payload":Lorg/json/JSONObject;
    nop

    .line 119
    :try_start_0
    const-string v3, "format"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v4

    const/4 v5, 0x0

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getFormatName()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    move-object v4, v5

    :goto_0
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 120
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getSampleRate()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_1

    :cond_1
    move-object v3, v5

    :goto_1
    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 121
    const-string/jumbo v3, "volume"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getVolume()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    goto :goto_2

    :cond_2
    move-object v4, v5

    :goto_2
    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 122
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_3

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getRate()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_3

    :cond_3
    move-object v3, v5

    :goto_3
    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 123
    const-string v0, "pitch"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_4

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getPitch()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_4

    :cond_4
    move-object v3, v5

    :goto_4
    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 124
    invoke-virtual {v2, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 126
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_5

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getServerUrl()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    check-cast v0, Ljava/lang/CharSequence;

    const-string/jumbo v3, "rokid"

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x2

    invoke-static {v0, v3, v1, v4, v5}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v3, 0x1

    if-ne v0, v3, :cond_5

    move v1, v3

    :cond_5
    const-string v0, "lang"

    const-string/jumbo v3, "voice"

    if-eqz v1, :cond_6

    .line 127
    :try_start_1
    const-string v1, "longxiaochun"

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 128
    const-string/jumbo v1, "zh-cn"

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_5

    .line 130
    :cond_6
    const-string v1, "Meizhi"

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 131
    const-string/jumbo v1, "zh-cmn-Hans-CN"

    invoke-virtual {v2, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_5

    .line 133
    :catch_0
    move-exception v0

    .line 134
    .local v0, "e":Lorg/json/JSONException;
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "payload build error type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 137
    .end local v0    # "e":Lorg/json/JSONException;
    :goto_5
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 138
    .local v0, "message":Lorg/json/JSONObject;
    nop

    .line 139
    :try_start_2
    const-string v1, "header"

    const-string v3, "Start"

    invoke-direct {p0, v3}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->createHeader(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 140
    const-string v1, "payload"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_6

    .line 141
    :catch_1
    move-exception v1

    .line 142
    .local v1, "e":Lorg/json/JSONException;
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "message build error type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    .end local v1    # "e":Lorg/json/JSONException;
    :goto_6
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "sendStartMessage payloadChars="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 146
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "message.toString()"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->sendMessage(Ljava/lang/String;)Z

    .line 147
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 54
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mGson:Lcom/google/gson/Gson;

    const-class v1, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;

    .line 55
    .local v0, "response":Lcom/rokid/security/sdk/ability/bean/WekWsResponse;
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getHeader()Lcom/rokid/security/sdk/ability/bean/Header;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 223
    .local v1, "it":Lcom/rokid/security/sdk/ability/bean/Header;
    const/4 v2, 0x0

    .line 55
    .local v2, "$i$a$-let-TtsConnectClient$onMessage$1":I
    invoke-direct {p0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->handleTtsResult(Lcom/rokid/security/sdk/ability/bean/Header;)V

    .line 56
    .end local v1    # "it":Lcom/rokid/security/sdk/ability/bean/Header;
    .end local v2    # "$i$a$-let-TtsConnectClient$onMessage$1":I
    :cond_0
    return-void
.end method

.method public onMessage(Lokio/ByteString;)V
    .locals 3
    .param p1, "bytes"    # Lokio/ByteString;

    const-string v0, "bytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 49
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lokio/ByteString;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 50
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->listener:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lokio/ByteString;->toByteArray()[B

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;->onAudioStreamResult([B)V

    .line 51
    :cond_0
    return-void
.end method

.method public final sendStartMessage(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 96
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "sendStartMessage textChars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " queueSize="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->ttsQueue:Ljava/util/Queue;

    invoke-interface {v2}, Ljava/util/Queue;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " state="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 98
    monitor-enter p0

    const/4 v0, 0x0

    .line 100
    .local v0, "$i$a$-synchronized-TtsConnectClient$sendStartMessage$1":I
    :try_start_0
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    sget-object v2, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Idle:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    if-ne v1, v2, :cond_0

    .line 101
    sget-object v1, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Started:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 102
    invoke-virtual {p0, p1}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->doSendTtsRequest(Ljava/lang/String;)V

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_0

    .line 105
    :cond_0
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->ttsQueue:Ljava/util/Queue;

    invoke-interface {v1, p1}, Ljava/util/Queue;->offer(Ljava/lang/Object;)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 100
    :goto_0
    nop

    .line 98
    .end local v0    # "$i$a$-synchronized-TtsConnectClient$sendStartMessage$1":I
    monitor-exit p0

    .line 108
    return-void

    .line 98
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final sendStopMessage()V
    .locals 5

    .line 157
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendStopMessage "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 159
    monitor-enter p0

    const/4 v0, 0x0

    .line 160
    .local v0, "$i$a$-synchronized-TtsConnectClient$sendStopMessage$1":I
    :try_start_0
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->ttsQueue:Ljava/util/Queue;

    invoke-interface {v1}, Ljava/util/Queue;->clear()V

    .line 161
    sget-object v1, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;->Idle:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    iput-object v1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->mTtsState:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsState;

    .line 163
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 164
    .local v1, "payload":Lorg/json/JSONObject;
    nop

    .line 165
    :try_start_1
    const-string v2, "format"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    const/4 v4, 0x0

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getFormatName()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_0
    move-object v3, v4

    :goto_0
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 166
    const-string v2, "rate"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getSampleRate()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_1

    :cond_1
    move-object v3, v4

    :goto_1
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 167
    const-string/jumbo v2, "volume"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getVolume()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_2

    :cond_2
    move-object v3, v4

    :goto_2
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 168
    const-string v2, "rate"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_3

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getRate()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_3

    :cond_3
    move-object v3, v4

    :goto_3
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 169
    const-string v2, "pitch"

    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v3

    if-eqz v3, :cond_4

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getPitch()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    :cond_4
    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_4

    .line 170
    :catch_0
    move-exception v2

    .line 172
    :goto_4
    :try_start_2
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 173
    .local v2, "message":Lorg/json/JSONObject;
    nop

    .line 174
    :try_start_3
    const-string v3, "header"

    const-string v4, "End"

    invoke-direct {p0, v4}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->createHeader(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 175
    const-string v3, "payload"

    invoke-virtual {v2, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_5

    .line 176
    :catch_1
    move-exception v3

    .line 178
    :goto_5
    :try_start_4
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "message.toString()"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v3}, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->sendMessage(Ljava/lang/String;)Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 159
    .end local v0    # "$i$a$-synchronized-TtsConnectClient$sendStopMessage$1":I
    .end local v1    # "payload":Lorg/json/JSONObject;
    .end local v2    # "message":Lorg/json/JSONObject;
    monitor-exit p0

    .line 181
    return-void

    .line 159
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final setTtsListener(Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 45
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/tts/TtsConnectClient;->listener:Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;

    .line 46
    return-void
.end method
