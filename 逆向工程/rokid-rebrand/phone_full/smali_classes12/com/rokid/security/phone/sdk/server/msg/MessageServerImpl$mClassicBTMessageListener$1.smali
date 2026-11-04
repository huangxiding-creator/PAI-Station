.class public final Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1;
.super Ljava/lang/Object;
.source "MessageServerImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMessageServerImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MessageServerImpl.kt\ncom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,352:1\n1855#2,2:353\n1855#2,2:355\n1855#2,2:357\n1855#2,2:359\n1855#2,2:361\n1855#2,2:363\n*S KotlinDebug\n*F\n+ 1 MessageServerImpl.kt\ncom/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1\n*L\n114#1:353,2\n122#1:355,2\n134#1:357,2\n137#1:359,2\n143#1:361,2\n146#1:363,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001f\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0006*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J \u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u0005H\u0016J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u0007H\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u000c\u001a\u00020\u0005H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/msg/MessageServerImpl$mClassicBTMessageListener$1",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;",
        "onBTStreamDataReceived",
        "",
        "tag",
        "",
        "data",
        "",
        "clientId",
        "onClassicBTAudioStream",
        "buffer",
        "onClassicBTTextMessage",
        "msg",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 6
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 143
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$getMInterMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 361
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    const/4 v5, 0x0

    .line 144
    .local v5, "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onBTStreamDataReceived$1":I
    invoke-interface {v4, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;->onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V

    .line 145
    nop

    .line 361
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .end local v5    # "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onBTStreamDataReceived$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 362
    :cond_0
    nop

    .line 146
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$getMMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 363
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    const/4 v5, 0x0

    .line 147
    .local v5, "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onBTStreamDataReceived$2":I
    invoke-interface {v4, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;->onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V

    .line 148
    nop

    .line 363
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .end local v5    # "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onBTStreamDataReceived$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 364
    :cond_1
    nop

    .line 149
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onClassicBTAudioStream([B)V
    .locals 6
    .param p1, "buffer"    # [B

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 131
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onClassicBTAudioStream onClassicBTAudioStream:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    array-length v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "MessageServerImpl "

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 133
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageSender;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageSender;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageSender;->getCommonMessage()Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/sdk/ability/message/MessageType;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageType;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/MessageType;->getBT()I

    move-result v1

    invoke-interface {v0, p1, v1}, Lcom/rokid/security/sdk/ability/message/ICommonMessage;->onAudioStream([BI)V

    .line 134
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$getMInterMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 357
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    const/4 v5, 0x0

    .line 135
    .local v5, "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTAudioStream$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;->onClassicBTAudioStream([B)V

    .line 136
    nop

    .line 357
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .end local v5    # "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTAudioStream$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 358
    :cond_0
    nop

    .line 137
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$getMMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 359
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    const/4 v5, 0x0

    .line 138
    .local v5, "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTAudioStream$2":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;->onClassicBTAudioStream([B)V

    .line 139
    nop

    .line 359
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .end local v5    # "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTAudioStream$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 360
    :cond_1
    nop

    .line 140
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onClassicBTTextMessage(Ljava/lang/String;)V
    .locals 11
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 110
    sget-object v0, Lcom/rokid/security/sdk/ability/message/MessageSender;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageSender;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/message/MessageSender;->getCommonMessage()Lcom/rokid/security/sdk/ability/message/ICommonMessage;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/sdk/ability/message/MessageType;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageType;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/message/MessageType;->getBT()I

    move-result v1

    invoke-interface {v0, p1, v1}, Lcom/rokid/security/sdk/ability/message/ICommonMessage;->onMessage(Ljava/lang/String;I)V

    .line 111
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onClassicBTTextMessage "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-static {v1, p1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$sanitizeRelayLog(Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "MessageServerImpl "

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 113
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$isInterMessage(Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 114
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$getMInterMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 353
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    const/4 v5, 0x0

    .line 115
    .local v5, "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTTextMessage$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;->onClassicBTTextMessage(Ljava/lang/String;)V

    .line 116
    nop

    .line 353
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .end local v5    # "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTTextMessage$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 354
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_2

    .line 118
    :cond_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 119
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v1, "type"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "custom_business_action"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 120
    const-string v1, "clientId"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 121
    .local v2, "clientId":Ljava/lang/String;
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 122
    .local v4, "extra":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->access$getMMessageListeners$p()Ljava/util/concurrent/CopyOnWriteArraySet;

    move-result-object v5

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 355
    .local v6, "$i$f$forEach":I
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_1
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_2

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;

    .local v9, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    const/4 v10, 0x0

    .line 123
    .local v10, "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTTextMessage$2":I
    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v9, v4, v2}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;->onClassicBTTextMessage(Ljava/lang/String;Ljava/lang/String;)V

    .line 124
    nop

    .line 355
    .end local v9    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .end local v10    # "$i$a$-forEach-MessageServerImpl$mClassicBTMessageListener$1$onClassicBTTextMessage$2":I
    nop

    .end local v8    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 356
    :cond_2
    nop

    .line 128
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "clientId":Ljava/lang/String;
    .end local v4    # "extra":Ljava/lang/String;
    .end local v5    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$forEach":I
    :cond_3
    :goto_2
    return-void
.end method
