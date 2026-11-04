.class public final Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem$DefaultImpls;
.super Ljava/lang/Object;
.source "IFileSystem.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static addFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem;Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem;
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    invoke-interface {p0, p1}, Lcom/rokid/security/phone/sdk/api/filesystem/api/IFileSystem;->setFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V

    .line 20
    return-void
.end method
