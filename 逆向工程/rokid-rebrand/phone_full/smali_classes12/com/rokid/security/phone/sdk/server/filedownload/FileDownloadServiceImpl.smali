.class public final Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/filedownload/AbsFileDownloadService;
.source "FileDownloadServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u000f\u001a\u00020\u0010H\u0016J \u0010\u0011\u001a\u00020\u00102\u0006\u0010\u0012\u001a\u00020\u00042\u0006\u0010\u0013\u001a\u00020\u00042\u0006\u0010\u0014\u001a\u00020\u0015H\u0016J\u0010\u0010\u0016\u001a\u00020\u00172\u0006\u0010\u0012\u001a\u00020\u0004H\u0016R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000e\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/filedownload/AbsFileDownloadService;",
        "()V",
        "TAG",
        "",
        "getTAG",
        "()Ljava/lang/String;",
        "setTAG",
        "(Ljava/lang/String;)V",
        "downloadJob",
        "Lkotlinx/coroutines/Job;",
        "getDownloadJob",
        "()Lkotlinx/coroutines/Job;",
        "setDownloadJob",
        "(Lkotlinx/coroutines/Job;)V",
        "cancelDownload",
        "",
        "fileDownload",
        "url",
        "path",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
        "getDownloadFileApi",
        "Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;

.field private static TAG:Ljava/lang/String;

.field private static downloadJob:Lkotlinx/coroutines/Job;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;

    .line 21
    const-string v0, "FileDownloadServiceImpl::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/filedownload/AbsFileDownloadService;-><init>()V

    return-void
.end method


# virtual methods
.method public cancelDownload()V
    .locals 3

    .line 114
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 115
    :cond_0
    return-void
.end method

.method public fileDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
    .locals 9
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "path"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "path"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "fileDownload: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x20

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 43
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 44
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;

    invoke-direct {v0, p1, p3, p2, v1}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;-><init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v6, v0

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    .line 110
    return-void
.end method

.method public getDownloadFileApi(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;
    .locals 9
    .param p1, "url"    # Ljava/lang/String;

    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {v0, v1, v0}, Lkotlinx/coroutines/CompletableDeferredKt;->CompletableDeferred$default(Lkotlinx/coroutines/Job;ILjava/lang/Object;)Lkotlinx/coroutines/CompletableDeferred;

    move-result-object v2

    .line 26
    .local v2, "deferred":Lkotlinx/coroutines/CompletableDeferred;
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v4, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;

    invoke-direct {v4, p1, v2, v0}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;-><init>(Ljava/lang/String;Lkotlinx/coroutines/CompletableDeferred;Lkotlin/coroutines/Continuation;)V

    move-object v6, v4

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 39
    new-instance v3, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$2;

    invoke-direct {v3, v2, v0}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$2;-><init>(Lkotlinx/coroutines/CompletableDeferred;Lkotlin/coroutines/Continuation;)V

    check-cast v3, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v3, v1, v0}, Lkotlinx/coroutines/BuildersKt;->runBlocking$default(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;

    return-object v0
.end method

.method public final getDownloadJob()Lkotlinx/coroutines/Job;
    .locals 1

    .line 20
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public final getTAG()Ljava/lang/String;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public final setDownloadJob(Lkotlinx/coroutines/Job;)V
    .locals 0
    .param p1, "<set-?>"    # Lkotlinx/coroutines/Job;

    .line 20
    sput-object p1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    return-void
.end method

.method public final setTAG(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    sput-object p1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->TAG:Ljava/lang/String;

    return-void
.end method
