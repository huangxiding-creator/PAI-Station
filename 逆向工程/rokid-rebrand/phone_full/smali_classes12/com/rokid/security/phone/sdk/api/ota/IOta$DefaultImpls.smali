.class public final Lcom/rokid/security/phone/sdk/api/ota/IOta$DefaultImpls;
.super Ljava/lang/Object;
.source "IOta.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/ota/IOta;
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
.method public static cancelDownload(Lcom/rokid/security/phone/sdk/api/ota/IOta;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/ota/IOta;

    .line 34
    return-void
.end method

.method public static otaDownload(Lcom/rokid/security/phone/sdk/api/ota/IOta;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/ota/IOta;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "filePath"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    return-void
.end method

.method public static otaDownloadWithResume(Lcom/rokid/security/phone/sdk/api/ota/IOta;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;J)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/ota/IOta;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .param p4, "downloadedSize"    # J

    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "filePath"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 45
    invoke-interface {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/ota/IOta;->otaDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V

    .line 46
    return-void
.end method

.method public static synthetic otaDownloadWithResume$default(Lcom/rokid/security/phone/sdk/api/ota/IOta;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JILjava/lang/Object;)V
    .locals 6

    .line 39
    if-nez p7, :cond_1

    and-int/lit8 p6, p6, 0x8

    if-eqz p6, :cond_0

    .line 43
    const-wide/16 p4, 0x0

    move-wide v4, p4

    goto :goto_0

    .line 39
    :cond_0
    move-wide v4, p4

    :goto_0
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-interface/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/api/ota/IOta;->otaDownloadWithResume(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;J)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: otaDownloadWithResume"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
