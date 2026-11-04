.class final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;
.super Lkotlin/jvm/internal/Lambda;
.source "InspectionServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->qrCodeAnalyzer([BII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Ljava/lang/String;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectionServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectionServiceImpl.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,894:1\n1#2:895\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\u0010\u0000\u001a\u00020\u00012\u0008\u0010\u0002\u001a\u0004\u0018\u00010\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "result",
        "",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 437
    move-object v0, p1

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;->invoke(Ljava/lang/String;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Ljava/lang/String;)V
    .locals 16
    .param p1, "result"    # Ljava/lang/String;

    .line 438
    move-object/from16 v0, p1

    const-string v1, "InspectQr"

    if-eqz v0, :cond_0

    .line 439
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u2705 \u8bc6\u522b\u5230\u4e8c\u7ef4\u7801: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 440
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const/4 v1, 0x0

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$setNeedQRCode$p(Z)V

    .line 441
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    check-cast v1, Ljava/util/List;

    .line 442
    .local v1, "mutableList":Ljava/util/List;
    new-instance v2, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;

    invoke-direct {v2}, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;-><init>()V

    move-object v3, v2

    .local v3, "$this$invoke_u24lambda_u240":Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
    const/4 v4, 0x0

    .line 443
    .local v4, "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$endRec$1":I
    const-string v5, "qrcodeRecEnd"

    invoke-virtual {v3, v5}, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->setType(Ljava/lang/String;)V

    .line 444
    nop

    .line 442
    .end local v3    # "$this$invoke_u24lambda_u240":Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
    .end local v4    # "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$endRec$1":I
    nop

    .line 445
    .local v2, "endRec":Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 446
    new-instance v11, Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;

    const/16 v9, 0x1f

    const/4 v10, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v3, v11

    invoke-direct/range {v3 .. v10}, Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v3, "$this$invoke_u24lambda_u241":Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;
    const/4 v4, 0x0

    .line 447
    .local v4, "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$aiResponse$1":I
    invoke-virtual {v3, v1}, Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;->setFunctions(Ljava/util/List;)V

    .line 448
    nop

    .line 446
    .end local v3    # "$this$invoke_u24lambda_u241":Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;
    .end local v4    # "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$aiResponse$1":I
    nop

    .line 449
    .local v3, "aiResponse":Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;
    new-instance v4, Lcom/google/gson/Gson;

    invoke-direct {v4}, Lcom/google/gson/Gson;-><init>()V

    .line 450
    .local v4, "gson":Lcom/google/gson/Gson;
    invoke-virtual {v4, v3}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "gson.toJson(aiResponse)"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 451
    .local v5, "jsonString":Ljava/lang/String;
    new-instance v6, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v7, v6

    .local v7, "$this$invoke_u24lambda_u242":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v8, 0x0

    .line 452
    .local v8, "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$extra$1":I
    const-string v9, "onAiResponse"

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 453
    invoke-virtual {v7, v5}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswer(Ljava/lang/String;)V

    .line 454
    sget-object v9, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getGuideSessionId()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 455
    sget-object v9, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 456
    const/4 v9, 0x1

    invoke-virtual {v7, v9}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswerIsFinish(Z)V

    .line 457
    nop

    .line 451
    .end local v7    # "$this$invoke_u24lambda_u242":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v8    # "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$extra$1":I
    nop

    .line 458
    .local v6, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v7, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v7

    invoke-virtual {v7, v6}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 459
    .local v7, "extraStr":Ljava/lang/String;
    sget-object v8, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v9, "extraStr"

    invoke-static {v7, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v14, 0x1c

    const/4 v15, 0x0

    const-string v9, "AI_CHAT_API_ACTION"

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    move-object v10, v7

    invoke-static/range {v8 .. v15}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 460
    sget-object v8, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    new-instance v9, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v9}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    .line 895
    move-object v10, v9

    .local v10, "$this$invoke_u24lambda_u243":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v11, 0x0

    .line 460
    .local v11, "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$1":I
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "qrcode:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v10, v12}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestion(Ljava/lang/String;)V

    .end local v10    # "$this$invoke_u24lambda_u243":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v11    # "$i$a$-apply-InspectionServiceImpl$qrCodeAnalyzer$1$1":I
    invoke-virtual {v8, v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->toInspect(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .end local v1    # "mutableList":Ljava/util/List;
    .end local v2    # "endRec":Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
    .end local v3    # "aiResponse":Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;
    .end local v4    # "gson":Lcom/google/gson/Gson;
    .end local v5    # "jsonString":Ljava/lang/String;
    .end local v6    # "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v7    # "extraStr":Ljava/lang/String;
    goto :goto_0

    .line 463
    :cond_0
    const-string/jumbo v2, "\u672a\u68c0\u6d4b\u5230\u4e8c\u7ef4\u7801"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 465
    :goto_0
    return-void
.end method
