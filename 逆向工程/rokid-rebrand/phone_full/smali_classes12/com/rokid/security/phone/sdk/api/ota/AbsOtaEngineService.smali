.class public abstract Lcom/rokid/security/phone/sdk/api/ota/AbsOtaEngineService;
.super Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;
.source "AbsOtaEngineService.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/ota/IOta;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0010\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008&\u0018\u00002\u00020\u00012\u00020\u0002B\u0005\u00a2\u0006\u0002\u0010\u0003\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/ota/AbsOtaEngineService;",
        "Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;",
        "Lcom/rokid/security/phone/sdk/api/ota/IOta;",
        "()V",
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


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;-><init>()V

    return-void
.end method


# virtual methods
.method public cancelDownload()V
    .locals 0

    .line 8
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/ota/IOta$DefaultImpls;->cancelDownload(Lcom/rokid/security/phone/sdk/api/ota/IOta;)V

    return-void
.end method

.method public otaDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .line 8
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/ota/IOta$DefaultImpls;->otaDownload(Lcom/rokid/security/phone/sdk/api/ota/IOta;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V

    return-void
.end method

.method public otaDownloadWithResume(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;J)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .param p4, "downloadedSize"    # J

    .line 8
    invoke-static/range {p0 .. p5}, Lcom/rokid/security/phone/sdk/api/ota/IOta$DefaultImpls;->otaDownloadWithResume(Lcom/rokid/security/phone/sdk/api/ota/IOta;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;J)V

    return-void
.end method
