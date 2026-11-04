.class public final Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;
.super Ljava/lang/Object;
.source "FileSystemManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->ossFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000#\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004*\u0001\u0000\u0008\n\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001J!\u0010\u0003\u001a\u00020\u00042\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H\u0016\u00a2\u0006\u0002\u0010\tJ\u0012\u0010\n\u001a\u00020\u00042\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0002H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
        "onFailed",
        "",
        "code",
        "",
        "errormsg",
        "",
        "(Ljava/lang/Integer;Ljava/lang/String;)V",
        "onSuccess",
        "data",
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


# instance fields
.field final synthetic $filePath:Ljava/lang/String;

.field final synthetic $preCalculatedMd5:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "$filePath"    # Ljava/lang/String;
    .param p2, "$preCalculatedMd5"    # Ljava/lang/String;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->$filePath:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->$preCalculatedMd5:Ljava/lang/String;

    .line 326
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 8
    .param p1, "code"    # Ljava/lang/Integer;
    .param p2, "errormsg"    # Ljava/lang/String;

    .line 338
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v7, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->$filePath:Ljava/lang/String;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->$preCalculatedMd5:Ljava/lang/String;

    const/4 v6, 0x0

    move-object v1, v7

    move-object v2, p1

    move-object v3, p2

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onFailed$1;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v3, v7

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 344
    return-void
.end method

.method public onSuccess(Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;)V
    .locals 6
    .param p1, "data"    # Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;

    .line 328
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onSuccess$1;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->$filePath:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->$preCalculatedMd5:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-direct {v1, p1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2$onSuccess$1;-><init>(Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 335
    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/Object;

    .line 326
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;->onSuccess(Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;)V

    return-void
.end method
