.class public final Lcom/rokid/security/phone/sdk/api/base/DownloadListener$DefaultImpls;
.super Ljava/lang/Object;
.source "DownloadListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
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
.method public static onProgress(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;IJJ)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .param p1, "progress"    # I
    .param p2, "downloaded"    # J
    .param p4, "total"    # J

    .line 14
    invoke-interface {p0, p1}, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;->onProgress(I)V

    .line 15
    return-void
.end method
