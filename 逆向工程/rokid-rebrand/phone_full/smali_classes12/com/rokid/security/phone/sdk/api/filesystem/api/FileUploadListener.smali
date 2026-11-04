.class public interface abstract Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
.super Ljava/lang/Object;
.source "FileUploadListener.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0007\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0004\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0018\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\u0008H&J2\u0010\n\u001a\u00020\u00032\u0008\u0008\u0001\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u00082\u0006\u0010\u000e\u001a\u00020\u00082\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\u000f\u001a\u00020\u0008H&\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;",
        "",
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
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# virtual methods
.method public abstract onProgress(F)V
.end method

.method public abstract onStart(Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public abstract onStatusUpdate(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .param p1    # I
        .annotation runtime Lcom/rokid/security/phone/sdk/api/filesystem/api/UploadStatus;
        .end annotation
    .end param
.end method
