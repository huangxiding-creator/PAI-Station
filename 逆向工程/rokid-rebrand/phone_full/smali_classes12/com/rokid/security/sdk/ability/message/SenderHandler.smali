.class public final Lcom/rokid/security/sdk/ability/message/SenderHandler;
.super Ljava/lang/Object;
.source "SenderHandler.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000<\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0008\n\u0002\u0010\u0008\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\r\u001a\u00020\u00042\u0006\u0010\u000e\u001a\u00020\u000fJ\u000e\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013J4\u0010\u0014\u001a\u00020\u00112\u0006\u0010\u0015\u001a\u00020\u00042\u0006\u0010\u0016\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0017\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0018\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0019\u001a\u00020\u0004J<\u0010\u001a\u001a\u00020\u00112\u0006\u0010\u0015\u001a\u00020\u00042\u0006\u0010\u0016\u001a\u00020\u00042\u0006\u0010\u001b\u001a\u00020\u001c2\u0008\u0008\u0002\u0010\u0017\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0018\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0019\u001a\u00020\u0004J\u001e\u0010\u001d\u001a\u00020\u00112\u0006\u0010\u001e\u001a\u00020\u00042\u0006\u0010\u0012\u001a\u00020\u00132\u0006\u0010\u001b\u001a\u00020\u001cR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0007\u001a\u00020\u0008X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\t\u0010\n\"\u0004\u0008\u000b\u0010\u000c\u00a8\u0006\u001f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/message/SenderHandler;",
        "",
        "()V",
        "TAG",
        "",
        "isSelectP2P",
        "",
        "mGson",
        "Lcom/google/gson/Gson;",
        "getMGson",
        "()Lcom/google/gson/Gson;",
        "setMGson",
        "(Lcom/google/gson/Gson;)V",
        "getRequestGson",
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
        "sendNormalDataByNetworkMode",
        "networkMode",
        "",
        "sendStreamDataByNetworkMode",
        "tag",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

.field private static final TAG:Ljava/lang/String; = "SenderHandler"

.field public static final isSelectP2P:Z = false

.field private static mGson:Lcom/google/gson/Gson;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    .line 16
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->mGson:Lcom/google/gson/Gson;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic sendNormalData$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 7

    .line 24
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

    invoke-virtual/range {v1 .. v6}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic sendNormalDataByNetworkMode$default(Lcom/rokid/security/sdk/ability/message/SenderHandler;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    .locals 9

    .line 39
    and-int/lit8 v0, p7, 0x8

    const-string v1, ""

    if-eqz v0, :cond_0

    .line 43
    move-object v6, v1

    goto :goto_0

    .line 39
    :cond_0
    move-object v6, p4

    :goto_0
    and-int/lit8 v0, p7, 0x10

    if-eqz v0, :cond_1

    .line 44
    move-object v7, v1

    goto :goto_1

    .line 39
    :cond_1
    move-object v7, p5

    :goto_1
    and-int/lit8 v0, p7, 0x20

    if-eqz v0, :cond_2

    .line 45
    move-object v8, v1

    goto :goto_2

    .line 39
    :cond_2
    move-object v8, p6

    :goto_2
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    invoke-virtual/range {v2 .. v8}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendNormalDataByNetworkMode(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public final getMGson()Lcom/google/gson/Gson;
    .locals 1

    .line 16
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->mGson:Lcom/google/gson/Gson;

    return-object v0
.end method

.method public final getRequestGson(Lcom/rokid/security/sdk/base/common/RkBaseData;)Ljava/lang/String;
    .locals 2
    .param p1, "request"    # Lcom/rokid/security/sdk/base/common/RkBaseData;

    const-string v0, "request"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 77
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v0, p1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mGson.toJson(request)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public final sendAudioStreamData([B)V
    .locals 2
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->sendAudioStream([BI)V

    .line 62
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

    .line 25
    new-instance v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;-><init>()V

    .line 26
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 27
    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 28
    invoke-virtual {v0, p3}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setRequestId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 29
    invoke-virtual {v0, p4}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setResponseId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 30
    invoke-virtual {v0, p5}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setClientId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 31
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->build()Lcom/rokid/security/sdk/base/common/RkBaseData;

    move-result-object v0

    .line 25
    nop

    .line 32
    .local v0, "request":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {p0, v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getRequestGson(Lcom/rokid/security/sdk/base/common/RkBaseData;)Ljava/lang/String;

    move-result-object v1

    .line 34
    .local v1, "requestStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->sendMessage(Ljava/lang/String;I)V

    .line 35
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendNormalData type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " chars="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "SenderHandler"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 37
    return-void
.end method

.method public final sendNormalDataByNetworkMode(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "extra"    # Ljava/lang/String;
    .param p3, "networkMode"    # I
    .param p4, "requestId"    # Ljava/lang/String;
    .param p5, "responseId"    # Ljava/lang/String;
    .param p6, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "type"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "extra"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "requestId"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "responseId"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p6, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    new-instance v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;-><init>()V

    .line 48
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 49
    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 50
    invoke-virtual {v0, p4}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setRequestId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 51
    invoke-virtual {v0, p5}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setResponseId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 52
    invoke-virtual {v0, p6}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->setClientId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    move-result-object v0

    .line 53
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->build()Lcom/rokid/security/sdk/base/common/RkBaseData;

    move-result-object v0

    .line 47
    nop

    .line 54
    .local v0, "request":Lcom/rokid/security/sdk/base/common/RkBaseData;
    invoke-virtual {p0, v0}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->getRequestGson(Lcom/rokid/security/sdk/base/common/RkBaseData;)Ljava/lang/String;

    move-result-object v1

    .line 55
    .local v1, "requestStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3, p3}, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->sendMessage(Ljava/lang/String;II)V

    .line 56
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendNormalDataByNetworkMode type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " chars="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " networkMode="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "SenderHandler"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 57
    return-void
.end method

.method public final sendStreamDataByNetworkMode(Ljava/lang/String;[BI)V
    .locals 2
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "streamData"    # [B
    .param p3, "networkMode"    # I

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "streamData"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 65
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, v1, p3}, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->sendStreamData(Ljava/lang/String;[BII)V

    .line 66
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "sendStreamDataByNetworkMode tagChars="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " bytes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    array-length v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " networkMode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "SenderHandler"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 67
    return-void
.end method

.method public final setMGson(Lcom/google/gson/Gson;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/google/gson/Gson;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    sput-object p1, Lcom/rokid/security/sdk/ability/message/SenderHandler;->mGson:Lcom/google/gson/Gson;

    return-void
.end method
