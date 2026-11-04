.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;
.super Ljava/lang/Object;
.source "DownloadHelper.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->download(Ljava/lang/String;Ljava/lang/String;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0014\u0010\u0004\u001a\u00020\u00032\n\u0010\u0005\u001a\u00060\u0006j\u0002`\u0007H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\nH\u0016J\u0008\u0010\u000c\u001a\u00020\u0003H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1",
        "Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;",
        "onComplete",
        "",
        "onError",
        "e",
        "Ljava/lang/Exception;",
        "Lkotlin/Exception;",
        "onProgress",
        "bytesRead",
        "",
        "contentLength",
        "onStart",
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
.field final synthetic $continuation:Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/coroutines/Continuation<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $path:Ljava/lang/String;


# direct methods
.method constructor <init>(Lkotlin/coroutines/Continuation;Ljava/lang/String;)V
    .locals 0
    .param p1, "$continuation"    # Lkotlin/coroutines/Continuation;
    .param p2, "$path"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;->$continuation:Lkotlin/coroutines/Continuation;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;->$path:Ljava/lang/String;

    .line 123
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onComplete()V
    .locals 2

    .line 132
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;->$continuation:Lkotlin/coroutines/Continuation;

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;->$path:Ljava/lang/String;

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    .line 133
    return-void
.end method

.method public onError(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;

    const-string v0, "e"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 128
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;->$continuation:Lkotlin/coroutines/Continuation;

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    const/4 v1, 0x0

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    .line 129
    return-void
.end method

.method public onProgress(JJ)V
    .locals 0
    .param p1, "bytesRead"    # J
    .param p3, "contentLength"    # J

    .line 136
    return-void
.end method

.method public onStart()V
    .locals 0

    .line 125
    return-void
.end method
