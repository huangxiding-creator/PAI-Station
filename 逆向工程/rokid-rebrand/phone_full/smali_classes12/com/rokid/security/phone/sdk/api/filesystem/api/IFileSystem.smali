.class public interface abstract Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem;
.super Ljava/lang/Object;
.source "IFileSystem.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0006\u001a\u00020\u0003H&J\u0010\u0010\u0007\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&\u00a8\u0006\u0008"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem;",
        "",
        "addFileUploadListener",
        "",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;",
        "removeFileUploadListener",
        "setFileUploadListener",
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
.method public abstract addFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V
.end method

.method public abstract removeFileUploadListener()V
.end method

.method public abstract setFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V
.end method
