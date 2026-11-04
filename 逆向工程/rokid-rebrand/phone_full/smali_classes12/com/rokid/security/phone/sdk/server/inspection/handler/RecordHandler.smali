.class public final Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;
.super Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
.source "RecordHandler.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0018\u0000 \r2\u00020\u0001:\u0001\rB\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000e\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006H\u0016J\u0010\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0016J\u0010\u0010\u000c\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0002\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;",
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;",
        "serviceImpl",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;",
        "(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V",
        "getSupportedMethods",
        "",
        "",
        "handleMessage",
        "",
        "aiChatExtra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "handleRecordEndTime",
        "Companion",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler$Companion;

.field private static final TAG:Ljava/lang/String; = "RecordHandler"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;->Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler$Companion;

    return-void
.end method

.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V
    .locals 1
    .param p1, "serviceImpl"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const-string/jumbo v0, "serviceImpl"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    return-void
.end method

.method private final handleRecordEndTime(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 6
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 54
    const-string/jumbo v0, "\u5904\u7406\u5f55\u5236\u7ed3\u675f\u65f6\u95f4\u6233"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "RecordHandler"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 55
    nop

    .line 56
    :try_start_0
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getGuideSessionId()Ljava/lang/String;

    move-result-object v0

    .line 57
    .local v0, "sessionId":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getVideoFileMD5()Ljava/lang/String;

    move-result-object v2

    .line 58
    .local v2, "fileMD5":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getRecordEndTime()J

    move-result-wide v3

    .line 64
    .local v3, "recordEndTimeStamp":J
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v5

    invoke-virtual {v5, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->toInspectEnd(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "sessionId":Ljava/lang/String;
    .end local v2    # "fileMD5":Ljava/lang/String;
    .end local v3    # "recordEndTimeStamp":J
    goto :goto_0

    .line 65
    :catch_0
    move-exception v0

    .line 66
    .local v0, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u89e3\u6790\u5f55\u5236\u7ed3\u675f\u65f6\u95f4\u6233\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 68
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method


# virtual methods
.method public getSupportedMethods()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 43
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "recordEndTime"

    aput-object v2, v0, v1

    .line 44
    const-string v1, "GlobalRecording"

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 43
    nop

    .line 45
    const-string v1, "StartManualRecording"

    const/4 v2, 0x2

    aput-object v1, v0, v2

    .line 43
    nop

    .line 46
    const-string v1, "EndManualRecording"

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 43
    nop

    .line 42
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "aiChatExtra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    :goto_0
    goto :goto_1

    :sswitch_0
    const-string v1, "recordEndTime"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 25
    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;->handleRecordEndTime(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_1

    .line 23
    :sswitch_1
    const-string v1, "GlobalRecording"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 28
    :cond_1
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->GlobalRecording()V

    goto :goto_1

    .line 23
    :sswitch_2
    const-string v1, "StartManualRecording"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    .line 32
    :cond_2
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->StartManualRecording(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    goto :goto_1

    .line 23
    :sswitch_3
    const-string v1, "EndManualRecording"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_0

    .line 36
    :cond_3
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;->getServiceImpl()Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->EndManualRecording()V

    .line 39
    :goto_1
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x75e23170 -> :sswitch_3
        -0x4f7b53d7 -> :sswitch_2
        -0x41754692 -> :sswitch_1
        0x5d9348b7 -> :sswitch_0
    .end sparse-switch
.end method
