.class public final Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;
.super Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
.source "TranslateConnectClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTranslateConnectClient.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TranslateConnectClient.kt\ncom/rokid/security/phone/core/ability/translate/TranslateConnectClient\n+ 2 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,156:1\n215#2,2:157\n1#3:159\n*S KotlinDebug\n*F\n+ 1 TranslateConnectClient.kt\ncom/rokid/security/phone/core/ability/translate/TranslateConnectClient\n*L\n120#1:157,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000D\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0012\n\u0002\u0008\u0007\u0018\u00002\u00020\u0001:\u0001\u001dB\u0005\u00a2\u0006\u0002\u0010\u0002J\u0012\u0010\u000c\u001a\u0004\u0018\u00010\r2\u0006\u0010\u000e\u001a\u00020\u0004H\u0002J\u0010\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u0012H\u0002J\u0010\u0010\u0013\u001a\u00020\u00102\u0006\u0010\u0014\u001a\u00020\u0004H\u0016J\u0010\u0010\u0015\u001a\u00020\u00102\u0008\u0010\u0016\u001a\u0004\u0018\u00010\u0017J\u0016\u0010\u0018\u001a\u00020\u00102\u0006\u0010\u0019\u001a\u00020\u00042\u0006\u0010\u001a\u001a\u00020\u0004J\u0006\u0010\u001b\u001a\u00020\u0010J\u000e\u0010\u001c\u001a\u00020\u00102\u0006\u0010\u0006\u001a\u00020\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0006\u001a\u0004\u0018\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;",
        "Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;",
        "()V",
        "TAG",
        "",
        "currentTaskId",
        "listener",
        "Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;",
        "mGson",
        "Lcom/google/gson/Gson;",
        "mPcm",
        "Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;",
        "createHeader",
        "Lorg/json/JSONObject;",
        "action",
        "handleTranslate",
        "",
        "payload",
        "Lcom/rokid/security/sdk/ability/bean/Payload;",
        "onMessage",
        "text",
        "sendAudioChunk",
        "audioData",
        "",
        "sendStartMessage",
        "src",
        "dest",
        "sendStopMessage",
        "setTranslateListener",
        "TranslateListener",
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


# instance fields
.field private TAG:Ljava/lang/String;

.field private currentTaskId:Ljava/lang/String;

.field private listener:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

.field private mGson:Lcom/google/gson/Gson;

.field private mPcm:Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;-><init>()V

    .line 24
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->mGson:Lcom/google/gson/Gson;

    .line 25
    const-string v0, "TranslateConnectClient::"

    iput-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->TAG:Ljava/lang/String;

    .line 27
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->mPcm:Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;

    .line 19
    return-void
.end method

.method private final createHeader(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 9
    .param p1, "action"    # Ljava/lang/String;

    .line 113
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 114
    .local v0, "header":Lorg/json/JSONObject;
    nop

    .line 115
    :try_start_0
    const-string/jumbo v1, "taskId"

    iget-object v2, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->currentTaskId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 116
    const-string v1, "reqId"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 117
    const-string/jumbo v1, "task"

    const-string v2, "SpeechTranslate"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 118
    const-string v1, "action"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 119
    const-string/jumbo v1, "version"

    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getVersion()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 120
    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getMHeaderMap()Ljava/util/Map;

    move-result-object v1

    .local v1, "$this$forEach$iv":Ljava/util/Map;
    const/4 v2, 0x0

    .line 157
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

    .line 121
    .local v6, "$i$a$-forEach-TranslateConnectClient$createHeader$1":I
    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v0, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 122
    nop

    .line 157
    .end local v5    # "it":Ljava/util/Map$Entry;
    .end local v6    # "$i$a$-forEach-TranslateConnectClient$createHeader$1":I
    nop

    .end local v4    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_1

    .line 158
    :cond_1
    nop

    .end local v1    # "$this$forEach$iv":Ljava/util/Map;
    .end local v2    # "$i$f$forEach":I
    goto :goto_2

    .line 123
    :catch_0
    move-exception v1

    .line 125
    :goto_2
    return-object v0
.end method

.method private final handleTranslate(Lcom/rokid/security/sdk/ability/bean/Payload;)V
    .locals 2
    .param p1, "payload"    # Lcom/rokid/security/sdk/ability/bean/Payload;

    .line 149
    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/bean/Payload;->getHasFinal()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 150
    iget-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->listener:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/bean/Payload;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;->onTranslateFinalResult(Ljava/lang/String;)V

    goto :goto_0

    .line 152
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->listener:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/bean/Payload;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;->onTranslateResult(Ljava/lang/String;)V

    .line 154
    :cond_1
    :goto_0
    return-void
.end method


# virtual methods
.method public onMessage(Ljava/lang/String;)V
    .locals 5
    .param p1, "text"    # Ljava/lang/String;

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 133
    iget-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    iget-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->mGson:Lcom/google/gson/Gson;

    const-class v1, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;

    .line 135
    .local v0, "mResponse":Lcom/rokid/security/sdk/ability/bean/WekWsResponse;
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getHeader()Lcom/rokid/security/sdk/ability/bean/Header;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/bean/Header;->getEvent()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v3

    sparse-switch v3, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v3, "Ended"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    .line 139
    :cond_1
    iget-object v1, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->listener:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    if-eqz v1, :cond_6

    invoke-interface {v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;->onEnd()V

    goto :goto_2

    .line 135
    :sswitch_1
    const-string v3, "Started"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    .line 136
    :cond_2
    iget-object v1, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->listener:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    if-eqz v1, :cond_6

    invoke-interface {v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;->onStart()V

    goto :goto_2

    .line 135
    :sswitch_2
    const-string v3, "Generated"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    .line 137
    :cond_3
    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getPayload()Lcom/rokid/security/sdk/ability/bean/Payload;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 159
    .local v1, "it":Lcom/rokid/security/sdk/ability/bean/Payload;
    const/4 v2, 0x0

    .line 137
    .local v2, "$i$a$-let-TranslateConnectClient$onMessage$1":I
    invoke-direct {p0, v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->handleTranslate(Lcom/rokid/security/sdk/ability/bean/Payload;)V

    .end local v1    # "it":Lcom/rokid/security/sdk/ability/bean/Payload;
    .end local v2    # "$i$a$-let-TranslateConnectClient$onMessage$1":I
    goto :goto_2

    .line 141
    :cond_4
    :goto_1
    iget-object v1, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->listener:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    if-eqz v1, :cond_6

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unknown event type: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->getHeader()Lcom/rokid/security/sdk/ability/bean/Header;

    move-result-object v4

    if-eqz v4, :cond_5

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/Header;->getEvent()Ljava/lang/String;

    move-result-object v2

    :cond_5
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/16 v3, -0x2712

    invoke-interface {v1, v3, v2}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;->onError(ILjava/lang/String;)V

    .line 143
    :cond_6
    :goto_2
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x77734691 -> :sswitch_2
        -0xddc279f -> :sswitch_1
        0x3ffda9a -> :sswitch_0
    .end sparse-switch
.end method

.method public final sendAudioChunk([B)V
    .locals 4
    .param p1, "audioData"    # [B

    .line 57
    if-eqz p1, :cond_0

    move-object v0, p1

    .local v0, "it":[B
    const/4 v1, 0x0

    .line 58
    .local v1, "$i$a$-let-TranslateConnectClient$sendAudioChunk$1":I
    const/4 v2, 0x0

    array-length v3, v0

    invoke-static {v0, v2, v3}, Lokio/ByteString;->of([BII)Lokio/ByteString;

    move-result-object v2

    .line 59
    .local v2, "byteString":Lokio/ByteString;
    const-string v3, "byteString"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v2}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->sendMessage(Lokio/ByteString;)Z

    .line 57
    .end local v0    # "it":[B
    .end local v1    # "$i$a$-let-TranslateConnectClient$sendAudioChunk$1":I
    .end local v2    # "byteString":Lokio/ByteString;
    nop

    .line 62
    :cond_0
    return-void
.end method

.method public final sendStartMessage(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "src"    # Ljava/lang/String;
    .param p2, "dest"    # Ljava/lang/String;

    const-string/jumbo v0, "src"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v1, "dest"

    invoke-static {p2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->generateId()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->currentTaskId:Ljava/lang/String;

    .line 69
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 70
    .local v2, "payload":Lorg/json/JSONObject;
    nop

    .line 71
    :try_start_0
    const-string v3, "format"

    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

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

    .line 72
    const-string v3, "rate"

    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v4

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getSampleRate()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    :cond_1
    invoke-virtual {v2, v3, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 73
    invoke-virtual {v2, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 74
    invoke-virtual {v2, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 76
    :catch_0
    move-exception v0

    .line 78
    :goto_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 79
    .local v0, "message":Lorg/json/JSONObject;
    nop

    .line 80
    :try_start_1
    const-string v1, "header"

    const-string v3, "Start"

    invoke-direct {p0, v3}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->createHeader(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 81
    const-string v1, "payload"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    .line 82
    :catch_1
    move-exception v1

    .line 84
    :goto_2
    iget-object v1, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->TAG:Ljava/lang/String;

    const-string/jumbo v3, "sendStartMessage->"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 85
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "message.toString()"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->sendMessage(Ljava/lang/String;)Z

    .line 86
    return-void
.end method

.method public final sendStopMessage()V
    .locals 4

    .line 92
    iget-object v0, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendStopMessage->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 93
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 94
    .local v0, "payload":Lorg/json/JSONObject;
    nop

    .line 95
    :try_start_0
    const-string v1, "format"

    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getFormatName()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, v3

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 96
    const-string v1, "rate"

    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getSampleRate()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_1

    :cond_1
    move-object v2, v3

    :goto_1
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 97
    const-string v1, "channel"

    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getChannel()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_2

    :cond_2
    move-object v2, v3

    :goto_2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 98
    const-string v1, "bits"

    invoke-virtual {p0}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v2

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getBits()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    :cond_3
    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 100
    :catch_0
    move-exception v1

    .line 102
    :goto_3
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 103
    .local v1, "message":Lorg/json/JSONObject;
    nop

    .line 104
    :try_start_1
    const-string v2, "header"

    const-string v3, "End"

    invoke-direct {p0, v3}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->createHeader(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 105
    const-string v2, "payload"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_4

    .line 106
    :catch_1
    move-exception v2

    .line 108
    :goto_4
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "message.toString()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v2}, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->sendMessage(Ljava/lang/String;)Z

    .line 109
    return-void
.end method

.method public final setTranslateListener(Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    iput-object p1, p0, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient;->listener:Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    .line 48
    return-void
.end method
