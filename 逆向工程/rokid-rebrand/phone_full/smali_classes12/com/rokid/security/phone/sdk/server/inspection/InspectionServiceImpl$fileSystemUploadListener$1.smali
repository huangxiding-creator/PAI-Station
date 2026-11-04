.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1;
.super Ljava/lang/Object;
.source "InspectionServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000)\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0007\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0005*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0018\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\u0008H\u0016J0\u0010\n\u001a\u00020\u00032\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u00082\u0006\u0010\u000e\u001a\u00020\u00082\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\u000f\u001a\u00020\u0008H\u0016J.\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u00082\u0006\u0010\u000e\u001a\u00020\u00082\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\u000f\u001a\u00020\u0008\u00a8\u0006\u0011"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;",
        "onProgress",
        "",
        "progress",
        "",
        "onStart",
        "filePath",
        "",
        "fileName",
        "onStatusUpdate",
        "status",
        "",
        "url",
        "fileMD5",
        "fileId",
        "uploadNonGlobalResources",
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

    .line 82
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgress(F)V
    .locals 0
    .param p1, "progress"    # F

    .line 144
    return-void
.end method

.method public onStart(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "fileName"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "fileName"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 85
    return-void
.end method

.method public onStatusUpdate(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "status"    # I
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "fileMD5"    # Ljava/lang/String;
    .param p4, "filePath"    # Ljava/lang/String;
    .param p5, "fileId"    # Ljava/lang/String;

    const-string/jumbo v0, "url"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "fileMD5"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "filePath"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "fileId"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 88
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onStatusUpdate called, isInspect: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isInspect$p()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "InspectionServiceImpl"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 89
    const/4 v0, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne p1, v3, :cond_5

    .line 90
    const-string v4, ".mp4"

    const/4 v5, 0x2

    invoke-static {p2, v4, v2, v5, v0}, Lkotlin/text/StringsKt;->endsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 92
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionVideoUploader$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    move-result-object v4

    if-nez v4, :cond_0

    const-string v4, "inspectionVideoUploader"

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    move-object v0, v4

    :goto_0
    invoke-virtual {v0, p4, p5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->markUploadSuccess(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 91
    nop

    .line 95
    .local v0, "sessionId":Ljava/lang/String;
    if-eqz v0, :cond_2

    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-lez v4, :cond_1

    move v4, v3

    goto :goto_1

    :cond_1
    move v4, v2

    :goto_1
    if-ne v4, v3, :cond_2

    move v2, v3

    :cond_2
    if-eqz v2, :cond_3

    .line 96
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "global videoupload success "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 98
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;

    new-instance v3, Lcom/rokid/security/phone/sdk/server/inspection/VideoUploadRequest;

    invoke-virtual {v0}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-direct {v3, p5, v4, v5}, Lcom/rokid/security/phone/sdk/server/inspection/VideoUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->uploadVideo(Lcom/rokid/security/phone/sdk/server/inspection/VideoUploadRequest;)V

    goto :goto_2

    .line 100
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "piece videoupload success "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 101
    invoke-virtual/range {p0 .. p5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1;->uploadNonGlobalResources(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 103
    :goto_2
    const-string v2, "inspectionData is empty, no guideSessionId to check."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_4

    .line 105
    .end local v0    # "sessionId":Ljava/lang/String;
    :cond_4
    invoke-virtual/range {p0 .. p5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1;->uploadNonGlobalResources(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4

    .line 110
    :cond_5
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getImageUploadManager$p()Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    move-result-object v1

    if-nez v1, :cond_6

    const-string v1, "imageUploadManager"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_3

    :cond_6
    move-object v0, v1

    :goto_3
    invoke-virtual {v0, p4, v2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->notifyUploadResult(Ljava/lang/String;Z)V

    .line 112
    :goto_4
    return-void
.end method

.method public final uploadNonGlobalResources(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "status"    # I
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "fileMD5"    # Ljava/lang/String;
    .param p4, "filePath"    # Ljava/lang/String;
    .param p5, "fileId"    # Ljava/lang/String;

    const-string/jumbo v0, "url"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "fileMD5"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "filePath"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "fileId"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 116
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    const-string v4, ""

    const-wide/16 v6, 0x0

    move-object v1, v0

    move-object v2, p4

    move-object v3, p5

    move-object v5, p2

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    .line 118
    .local v0, "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionDataManager$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    move-result-object v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    const-string v1, "inspectionDataManager"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_0
    new-instance v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;

    invoke-direct {v3, p2, p5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    check-cast v3, Lkotlin/jvm/functions/Function3;

    invoke-virtual {v1, p4, v0, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->updateInspectDataInfo(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;Lkotlin/jvm/functions/Function3;)V

    .line 136
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getImageUploadManager$p()Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    move-result-object v1

    if-nez v1, :cond_1

    const-string v1, "imageUploadManager"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    move-object v2, v1

    :goto_0
    if-eqz v2, :cond_2

    move-object v1, v2

    .local v1, "mgr":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    const/4 v2, 0x0

    .line 137
    .local v2, "$i$a$-let-InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$2":I
    const/4 v3, 0x1

    invoke-virtual {v1, p4, v3}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->notifyUploadResult(Ljava/lang/String;Z)V

    .line 138
    nop

    .line 136
    .end local v1    # "mgr":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .end local v2    # "$i$a$-let-InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$2":I
    nop

    .line 140
    :cond_2
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->uploadImgList()V

    .line 141
    return-void
.end method
