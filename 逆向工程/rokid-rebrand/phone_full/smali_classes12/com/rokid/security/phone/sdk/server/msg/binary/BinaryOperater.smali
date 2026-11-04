.class public final Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;
.super Ljava/lang/Object;
.source "BinaryOperater.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBinaryOperater.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BinaryOperater.kt\ncom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,97:1\n1#2:98\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000?\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010%\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\t\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0002\u0008\u0002*\u0001\n\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u000c\u001a\u00020\rJ\u0010\u0010\u000e\u001a\u00020\r2\u0006\u0010\u000f\u001a\u00020\u0004H\u0002J\u0006\u0010\u0010\u001a\u00020\rJ4\u0010\u0011\u001a\u00020\r2\u0006\u0010\u0012\u001a\u00020\u00082\u0006\u0010\u0013\u001a\u00020\u00042\u0006\u0010\u0014\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0015\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0016\u001a\u00020\u0017H\u0002J.\u0010\u0018\u001a\u00020\r2\u0006\u0010\u0013\u001a\u00020\u00042\u0006\u0010\u0019\u001a\u00020\u001a2\u0006\u0010\u0014\u001a\u00020\u00042\u000e\u0010\u001b\u001a\n\u0012\u0004\u0012\u00020\u0008\u0018\u00010\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R \u0010\u0005\u001a\u0014\u0012\u0004\u0012\u00020\u0004\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00080\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u00020\nX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000b\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;",
        "",
        "()V",
        "TAG",
        "",
        "callbackMap",
        "",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;",
        "init",
        "",
        "parseMessage",
        "msg",
        "release",
        "sendReceiverResponseExtra",
        "isSuccess",
        "tag",
        "clientId",
        "errorMsg",
        "errorCode",
        "",
        "sendStreamData",
        "data",
        "",
        "callback",
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
.field private final TAG:Ljava/lang/String;

.field private final callbackMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation
.end field

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    const-string v0, "BinaryOperater"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->TAG:Ljava/lang/String;

    .line 19
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->callbackMap:Ljava/util/Map;

    .line 21
    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;

    .line 17
    return-void
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;
    .param p1, "msg"    # Ljava/lang/String;

    .line 17
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 9
    .param p1, "msg"    # Ljava/lang/String;

    .line 37
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "BT_BINARY_API_ACTION"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 38
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 39
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 40
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 41
    .local v2, "extraJson":Ljava/lang/String;
    move-object v3, v2

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x1

    if-eqz v3, :cond_0

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-nez v3, :cond_1

    :cond_0
    move v5, v4

    :cond_1
    if-nez v5, :cond_4

    .line 42
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 43
    .local v3, "extraJsonObject":Lorg/json/JSONObject;
    const-string v5, "methodName"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 44
    .local v5, "methodName":Ljava/lang/String;
    nop

    .line 45
    const-string v6, "receiver_response"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 46
    sget-object v6, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v6

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-class v7, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;

    invoke-virtual {v6, v1, v7}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;

    .line 47
    .local v1, "receiverResponseExtra":Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;
    if-eqz v1, :cond_4

    .line 48
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->getTag()Ljava/lang/String;

    move-result-object v6

    .line 49
    .local v6, "tag":Ljava/lang/String;
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->isSuccess()Z

    move-result v7

    if-eqz v7, :cond_2

    .line 50
    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->callbackMap:Ljava/util/Map;

    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 51
    .local v7, "callback":Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    if-eqz v7, :cond_3

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-interface {v7, v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onSuccess(Ljava/lang/Object;)V

    goto :goto_0

    .line 54
    .end local v7    # "callback":Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    :cond_2
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->callbackMap:Ljava/util/Map;

    invoke-interface {v4, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 55
    .local v4, "callback":Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    if-eqz v4, :cond_3

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->getErrorCode()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->getErrorMsg()Ljava/lang/String;

    move-result-object v8

    invoke-interface {v4, v7, v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 57
    .end local v4    # "callback":Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    :cond_3
    :goto_0
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->callbackMap:Ljava/util/Map;

    invoke-interface {v4, v6}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 64
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "receiverResponseExtra":Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;
    .end local v2    # "extraJson":Ljava/lang/String;
    .end local v3    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v5    # "methodName":Ljava/lang/String;
    .end local v6    # "tag":Ljava/lang/String;
    :cond_4
    return-void
.end method

.method private final sendReceiverResponseExtra(ZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 10
    .param p1, "isSuccess"    # Z
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "clientId"    # Ljava/lang/String;
    .param p4, "errorMsg"    # Ljava/lang/String;
    .param p5, "errorCode"    # I

    .line 73
    nop

    .line 74
    :try_start_0
    new-instance v0, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendReceiverResponseExtra_u24lambda_u241":Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;
    const/4 v2, 0x0

    .line 75
    .local v2, "$i$a$-apply-BinaryOperater$sendReceiverResponseExtra$receiverResponseExtra$1":I
    const-string v3, "receiver_response"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->setMethodName(Ljava/lang/String;)V

    .line 76
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->setSuccess(Z)V

    .line 77
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->setTag(Ljava/lang/String;)V

    .line 78
    invoke-virtual {v1, p3}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->setClientId(Ljava/lang/String;)V

    .line 79
    invoke-virtual {v1, p4}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->setErrorMsg(Ljava/lang/String;)V

    .line 80
    invoke-virtual {v1, p5}, Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;->setErrorCode(I)V

    .line 81
    nop

    .line 74
    .end local v1    # "$this$sendReceiverResponseExtra_u24lambda_u241":Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;
    .end local v2    # "$i$a$-apply-BinaryOperater$sendReceiverResponseExtra$receiverResponseExtra$1":I
    nop

    .line 82
    .local v0, "receiverResponseExtra":Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 83
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "BT_BINARY_API_ACTION"

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "receiverResponseExtra":Lcom/rokid/security/sdk/base/common/ReceiverResponseExtra;
    .end local v1    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 84
    :catch_0
    move-exception v0

    .line 85
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 87
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method static synthetic sendReceiverResponseExtra$default(Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;ZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)V
    .locals 6

    .line 72
    and-int/lit8 p7, p6, 0x8

    if-eqz p7, :cond_0

    const-string p4, ""

    :cond_0
    move-object v4, p4

    and-int/lit8 p4, p6, 0x10

    if-eqz p4, :cond_1

    const/4 p5, 0x0

    :cond_1
    move v5, p5

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->sendReceiverResponseExtra(ZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    return-void
.end method


# virtual methods
.method public final init()V
    .locals 2

    .line 90
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 91
    return-void
.end method

.method public final release()V
    .locals 2

    .line 94
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->callbackMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 95
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 96
    return-void
.end method

.method public final sendStreamData(Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 3
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;
    .param p4, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "[B",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    if-eqz p4, :cond_0

    move-object v0, p4

    .line 98
    .local v0, "it":Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    const/4 v1, 0x0

    .line 68
    .local v1, "$i$a$-let-BinaryOperater$sendStreamData$1":I
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->callbackMap:Ljava/util/Map;

    invoke-interface {v2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 69
    .end local v0    # "it":Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .end local v1    # "$i$a$-let-BinaryOperater$sendStreamData$1":I
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->sendStreamoData(Ljava/lang/String;[BLjava/lang/String;)V

    .line 70
    return-void
.end method
