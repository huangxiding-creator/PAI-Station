.class final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;
.super Lkotlin/jvm/internal/Lambda;
.source "InspectionServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->stopPiceRecording()V
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

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "path",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;

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

    .line 623
    move-object v0, p1

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;->invoke(Ljava/lang/String;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Ljava/lang/String;)V
    .locals 10
    .param p1, "path"    # Ljava/lang/String;

    const-string v0, "path"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 625
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "pice Video file ready: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "InspectionServiceImpl"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 626
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$setRecorder$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;)V

    .line 627
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v1, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->judgeOverSizeFile(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 628
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getGuideSessionDir$p()Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    .line 629
    .local v1, "subfolderName":Ljava/lang/String;
    :goto_0
    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    if-eqz v2, :cond_2

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_1

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    goto :goto_2

    :cond_2
    :goto_1
    const/4 v2, 0x1

    :goto_2
    if-eqz v2, :cond_3

    .line 630
    return-void

    .line 635
    :cond_3
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getTakePictureId$p()Ljava/lang/String;

    move-result-object v6

    .line 637
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getPiceVideoTime()J

    move-result-wide v8

    .line 632
    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 633
    nop

    .line 636
    nop

    .line 635
    nop

    .line 634
    nop

    .line 637
    nop

    .line 632
    const-string v5, ""

    const-string v7, ""

    move-object v3, v2

    move-object v4, p1

    invoke-direct/range {v3 .. v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    .line 639
    .local v2, "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionDataManager$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    move-result-object v3

    if-nez v3, :cond_4

    const-string v3, "inspectionDataManager"

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_3

    :cond_4
    move-object v0, v3

    :goto_3
    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->addInspectInfo(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;)V

    .line 641
    .end local v1    # "subfolderName":Ljava/lang/String;
    .end local v2    # "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    :cond_5
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->uploadImgList()V

    .line 642
    return-void
.end method
