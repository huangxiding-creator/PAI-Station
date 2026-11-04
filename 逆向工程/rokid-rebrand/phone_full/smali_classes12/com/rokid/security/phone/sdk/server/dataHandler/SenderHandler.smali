.class public final Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;
.super Ljava/lang/Object;
.source "SenderHandler.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000:\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eJ\u000e\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u0012J4\u0010\u0013\u001a\u00020\u00102\u0006\u0010\u0014\u001a\u00020\u000c2\u0006\u0010\u0015\u001a\u00020\u000c2\u0008\u0008\u0002\u0010\u0016\u001a\u00020\u000c2\u0008\u0008\u0002\u0010\u0017\u001a\u00020\u000c2\u0008\u0008\u0002\u0010\u0018\u001a\u00020\u000cJ6\u0010\u0019\u001a\u00020\u00102\u0006\u0010\u0014\u001a\u00020\u000c2\u0006\u0010\u0015\u001a\u00020\u000c2\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0018\u001a\u00020\u000c2\u000e\u0010\u001a\u001a\n\u0012\u0004\u0012\u00020\u0004\u0018\u00010\u001bR\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0005\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008\"\u0004\u0008\t\u0010\n\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;",
        "",
        "()V",
        "isSelectP2P",
        "",
        "mGson",
        "Lcom/google/gson/Gson;",
        "getMGson",
        "()Lcom/google/gson/Gson;",
        "setMGson",
        "(Lcom/google/gson/Gson;)V",
        "getRequestGson",
        "",
        "request",
        "Lcom/rokid/security/sdk/base/common/RkBaseData;",
        "sendAudioStreamData",
        "",
        "streamData",
        "",
        "sendNormalData",
        "type",
        "extra",
        "requestId",
        "responseId",
        "clientId",
        "sendStreamData",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

.field public static final isSelectP2P:Z = false

.field private static mGson:Lcom/google/gson/Gson;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    .line 18
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->mGson:Lcom/google/gson/Gson;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 7

    .line 26
    and-int/lit8 p7, p6, 0x4

    const-string v0, ""

    if-eqz p7, :cond_0

    move-object v4, v0

    goto :goto_0

    :cond_0
    move-object v4, p3

    :goto_0
    and-int/lit8 p3, p6, 0x8

    if-eqz p3, :cond_1

    move-object v5, v0

    goto :goto_1

    :cond_1
    move-object v5, p4

    :goto_1
    and-int/lit8 p3, p6, 0x10

    if-eqz p3, :cond_2

    move-object v6, v0

    goto :goto_2

    :cond_2
    move-object v6, p5

    :goto_2
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    invoke-virtual/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final getMGson()Lcom/google/gson/Gson;
    .locals 1

    .line 18
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->mGson:Lcom/google/gson/Gson;

    return-object v0
.end method

.method public final getRequestGson(Lcom/rokid/security/sdk/base/common/RkBaseData;)Ljava/lang/String;
    .locals 2
    .param p1, "request"    # Lcom/rokid/security/sdk/base/common/RkBaseData;

    const-string v0, "request"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v0, p1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mGson.toJson(request)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public final sendAudioStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 46
    nop

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->sendAudioStreamDataByClassicBT([B)V

    .line 51
    return-void
.end method

.method public final sendNormalData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "extra"    # Ljava/lang/String;
    .param p3, "requestId"    # Ljava/lang/String;
    .param p4, "responseId"    # Ljava/lang/String;
    .param p5, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "type"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "extra"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "requestId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "responseId"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    new-instance v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;-><init>()V

    .line 28
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 29
    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 30
    invoke-virtual {v0, p3}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setRequestId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 31
    invoke-virtual {v0, p4}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setResponseId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 32
    invoke-virtual {v0, p5}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setClientId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 33
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->build()Lcom/rokid/security/sdk/base/common/RkBaseData;

    move-result-object v0

    .line 27
    nop

    .line 34
    .local v0, "request":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getRequestGson(Lcom/rokid/security/sdk/base/common/RkBaseData;)Ljava/lang/String;

    move-result-object v1

    .line 36
    .local v1, "requestStr":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendNormalData = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 37
    nop

    .line 40
    sget-object v2, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-virtual {v2, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->sendInterTextMsgByClassicBt(Ljava/lang/String;)V

    .line 42
    return-void
.end method

.method public final sendStreamData(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 3
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "extra"    # Ljava/lang/String;
    .param p3, "streamData"    # [B
    .param p4, "clientId"    # Ljava/lang/String;
    .param p5, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "[B",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "type"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "extra"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "streamData"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 54
    new-instance v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;-><init>()V

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->build()Lcom/rokid/security/sdk/base/common/RkBaseData;

    move-result-object v0

    .line 55
    .local v0, "request":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getRequestGson(Lcom/rokid/security/sdk/base/common/RkBaseData;)Ljava/lang/String;

    move-result-object v1

    .line 56
    .local v1, "requestStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    invoke-virtual {v2, v1, p3, p4, p5}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->sendStreamData(Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    .line 57
    return-void
.end method

.method public final setMGson(Lcom/google/gson/Gson;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/google/gson/Gson;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    sput-object p1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->mGson:Lcom/google/gson/Gson;

    return-void
.end method
