.class public interface abstract Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;
.super Ljava/lang/Object;
.source "DownloadListener.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0012\u0010\u0006\u001a\u00020\u00032\u0008\u0008\u0001\u0010\u0007\u001a\u00020\u0005H&\u00a8\u0006\u0008"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;",
        "",
        "onProgress",
        "",
        "progress",
        "",
        "onResult",
        "status",
        "base-utils_release"
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

.method public abstract onResult(I)V
    .param p1    # I
        .annotation runtime Lcom/rokid/security/phone/sdk/base/utils/net/DownloadStatus;
        .end annotation
    .end param
.end method
