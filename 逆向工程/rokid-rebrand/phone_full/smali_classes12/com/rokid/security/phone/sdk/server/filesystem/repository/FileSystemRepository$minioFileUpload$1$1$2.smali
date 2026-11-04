.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$2;
.super Lkotlin/jvm/internal/Lambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Ljava/lang/Integer;",
        "Ljava/lang/String;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\n\u00a2\u0006\u0002\u0008\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "code",
        "",
        "errorMsg",
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


# instance fields
.field final synthetic $callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p1, "p1"    # Ljava/lang/Object;
    .param p2, "p2"    # Ljava/lang/Object;

    .line 290
    move-object v0, p1

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    move-object v1, p2

    check-cast v1, Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$2;->invoke(ILjava/lang/String;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(ILjava/lang/String;)V
    .locals 3
    .param p1, "code"    # I
    .param p2, "errorMsg"    # Ljava/lang/String;

    const-string v0, "errorMsg"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 313
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/4 v1, -0x4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "onUploadFail \u8c03\u7528\u5931\u8d25"

    invoke-interface {v0, v1, v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 314
    return-void
.end method
