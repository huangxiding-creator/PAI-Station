.class public interface abstract Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
.super Ljava/lang/Object;
.source "DownloadListener.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/base/DownloadListener$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001e\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0004\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J \u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u0007H\u0016J\u0012\u0010\t\u001a\u00020\u00032\u0008\u0008\u0001\u0010\n\u001a\u00020\u0005H&\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
        "",
        "onProgress",
        "",
        "progress",
        "",
        "downloaded",
        "",
        "total",
        "onResult",
        "status",
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
.method public abstract onProgress(I)V
.end method

.method public abstract onProgress(IJJ)V
.end method

.method public abstract onResult(I)V
    .param p1    # I
        .annotation runtime Lcom/rokid/security/phone/sdk/api/base/DownloadStatus;
        .end annotation
    .end param
.end method
