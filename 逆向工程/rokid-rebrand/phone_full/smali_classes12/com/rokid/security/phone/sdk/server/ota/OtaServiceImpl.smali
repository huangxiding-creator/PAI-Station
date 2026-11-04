.class public final Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/ota/AbsOtaEngineService;
.source "OtaServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOtaServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OtaServiceImpl.kt\ncom/rokid/security/phone/sdk/server/ota/OtaServiceImpl\n+ 2 CoroutineScope.kt\nkotlinx/coroutines/CoroutineScopeKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,681:1\n329#2:682\n1#3:683\n*S KotlinDebug\n*F\n+ 1 OtaServiceImpl.kt\ncom/rokid/security/phone/sdk/server/ota/OtaServiceImpl\n*L\n300#1:682\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000b\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u000c\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001DB\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J(\u0010!\u001a\u00020\"2\u0006\u0010#\u001a\u00020$2\u0006\u0010%\u001a\u00020\"2\u0006\u0010&\u001a\u00020\"2\u0006\u0010\'\u001a\u00020(H\u0002J\u0008\u0010)\u001a\u00020*H\u0016J6\u0010+\u001a\u0008\u0012\u0004\u0012\u00020-0,2\u0006\u0010.\u001a\u00020\u00042\u0006\u0010/\u001a\u00020\u00042\u0006\u00100\u001a\u00020\u00042\u0006\u00101\u001a\u00020\u00042\u0006\u00102\u001a\u00020\u0004H\u0016J\u0019\u00103\u001a\u0004\u0018\u00010\"2\u0008\u00104\u001a\u0004\u0018\u00010\u0004H\u0002\u00a2\u0006\u0002\u00105J\u0008\u00106\u001a\u00020\nH\u0002J9\u00107\u001a\u00020*2\u0006\u00108\u001a\u0002092\u0006\u0010:\u001a\u00020(2\n\u0008\u0002\u0010;\u001a\u0004\u0018\u00010\"2\n\u0008\u0002\u0010<\u001a\u0004\u0018\u00010\"H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010=J1\u0010>\u001a\u00020*2\u0006\u0010?\u001a\u00020\u00042\u0006\u0010@\u001a\u00020\u00042\u0006\u00108\u001a\u0002092\u0006\u0010&\u001a\u00020\"H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010AJ \u0010B\u001a\u00020*2\u0006\u0010?\u001a\u00020\u00042\u0006\u0010@\u001a\u00020\u00042\u0006\u00108\u001a\u000209H\u0016J(\u0010C\u001a\u00020*2\u0006\u0010?\u001a\u00020\u00042\u0006\u0010@\u001a\u00020\u00042\u0006\u00108\u001a\u0002092\u0006\u0010&\u001a\u00020\"H\u0016R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001b\u0010\t\u001a\u00020\n8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\r\u0010\u000e\u001a\u0004\u0008\u000b\u0010\u000cR\u001c\u0010\u000f\u001a\u0004\u0018\u00010\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u001a\u0010\u0015\u001a\u00020\u0016X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0017\u0010\u0018\"\u0004\u0008\u0019\u0010\u001aR\u001a\u0010\u001b\u001a\u00020\u001cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001d\u0010\u001e\"\u0004\u0008\u001f\u0010 \u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006E"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/ota/AbsOtaEngineService;",
        "()V",
        "TAG",
        "",
        "getTAG",
        "()Ljava/lang/String;",
        "setTAG",
        "(Ljava/lang/String;)V",
        "downloadClient",
        "Lokhttp3/OkHttpClient;",
        "getDownloadClient",
        "()Lokhttp3/OkHttpClient;",
        "downloadClient$delegate",
        "Lkotlin/Lazy;",
        "downloadJob",
        "Lkotlinx/coroutines/Job;",
        "getDownloadJob",
        "()Lkotlinx/coroutines/Job;",
        "setDownloadJob",
        "(Lkotlinx/coroutines/Job;)V",
        "mOtaRepository",
        "Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;",
        "getMOtaRepository",
        "()Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;",
        "setMOtaRepository",
        "(Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;)V",
        "systemInfo",
        "Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
        "getSystemInfo",
        "()Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
        "setSystemInfo",
        "(Lcom/rokid/security/sdk/base/common/ota/SystemInfo;)V",
        "calculateTotalSize",
        "",
        "response",
        "Lokhttp3/Response;",
        "contentLength",
        "downloadedSize",
        "statusCode",
        "",
        "cancelDownload",
        "",
        "checkUpdate",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
        "version",
        "osType",
        "cpuType",
        "deviceId",
        "deviceTypeId",
        "contentRangeStart",
        "contentRange",
        "(Ljava/lang/String;)Ljava/lang/Long;",
        "createDownloadClient",
        "dispatchDownloadResult",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
        "status",
        "downloaded",
        "total",
        "(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "downloadWithRetrofit",
        "url",
        "path",
        "(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "otaDownload",
        "otaDownloadWithResume",
        "DownloadRetryInterceptor",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

.field private static TAG:Ljava/lang/String;

.field private static final downloadClient$delegate:Lkotlin/Lazy;

.field private static downloadJob:Lkotlinx/coroutines/Job;

.field private static mOtaRepository:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;

.field private static systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;


# direct methods
.method public static synthetic $r8$lambda$1_TP66Zpgk6M8r2lg6kvsIxNBEM(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->createDownloadClient$lambda$0(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .line 42
    new-instance v0, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    .line 43
    new-instance v0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->mOtaRepository:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;

    .line 47
    const-string v0, "OtaServiceImpl::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    .line 50
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadClient$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadClient$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadClient$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/ota/AbsOtaEngineService;-><init>()V

    return-void
.end method

.method public static final synthetic access$createDownloadClient(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;)Lokhttp3/OkHttpClient;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .line 40
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->createDownloadClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$dispatchDownloadResult(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .param p2, "status"    # I
    .param p3, "downloaded"    # Ljava/lang/Long;
    .param p4, "total"    # Ljava/lang/Long;
    .param p5, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 40
    invoke-direct/range {p0 .. p5}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$downloadWithRetrofit(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "path"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .param p4, "downloadedSize"    # J
    .param p6, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 40
    invoke-direct/range {p0 .. p6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadWithRetrofit(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private final calculateTotalSize(Lokhttp3/Response;JJI)J
    .locals 9
    .param p1, "response"    # Lokhttp3/Response;
    .param p2, "contentLength"    # J
    .param p4, "downloadedSize"    # J
    .param p6, "statusCode"    # I

    .line 554
    const-string v0, "/"

    .line 555
    const-wide/16 v1, 0x0

    :try_start_0
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    const-string v4, "=== \u54cd\u5e94\u5934\u4fe1\u606f ==="

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 556
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "headers: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->getMGson()Lcom/google/gson/Gson;

    move-result-object v5

    invoke-virtual {p1}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 557
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u72b6\u6001\u7801: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 558
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Content-Length: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 559
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u5df2\u4e0b\u8f7d\u5927\u5c0f: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 560
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    const-string v4, "=== \u54cd\u5e94\u5934\u7ed3\u675f ==="

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 562
    sparse-switch p6, :sswitch_data_0

    .line 582
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    goto/16 :goto_0

    .line 564
    :sswitch_0
    const-string v3, "Content-Range"

    invoke-virtual {p1, v3}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 565
    .local v3, "contentRange":Ljava/lang/String;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Content-Range: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 567
    if-eqz v3, :cond_0

    move-object v4, v3

    check-cast v4, Ljava/lang/CharSequence;

    move-object v5, v0

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v4, v5, v6, v7, v8}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 568
    invoke-static {v3, v0, v8, v7, v8}, Lkotlin/text/StringsKt;->substringAfter$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    .line 569
    .local v4, "totalSize":J
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "\u4eceContent-Range\u83b7\u53d6\u603b\u5927\u5c0f: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v0, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 570
    move-wide v1, v4

    .end local v4    # "totalSize":J
    goto :goto_1

    .line 572
    :cond_0
    add-long v4, p2, p4

    .line 573
    .local v4, "estimatedTotal":J
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "206\u54cd\u5e94\u4f46\u6ca1\u6709Content-Range\uff0c\u4f7f\u7528\u4f30\u7b97\u5927\u5c0f: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v0, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 574
    move-wide v1, v4

    .end local v3    # "contentRange":Ljava/lang/String;
    .end local v4    # "estimatedTotal":J
    goto :goto_1

    .line 578
    :sswitch_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "200\u54cd\u5e94\uff0c\u670d\u52a1\u5668\u4e0d\u652f\u6301\u65ad\u70b9\u7eed\u4f20\uff0c\u4f7f\u7528Content-Length: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 579
    move-wide v1, p2

    goto :goto_1

    .line 582
    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u975e200/206\u72b6\u6001\u7801: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string/jumbo v4, "\uff0c\u65e0\u6cd5\u786e\u5b9a\u603b\u5927\u5c0f"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 583
    nop

    :goto_1
    goto :goto_2

    .line 586
    :catch_0
    move-exception v0

    .line 587
    .local v0, "e":Ljava/lang/Exception;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v4, "\u8ba1\u7b97\u603b\u5927\u5c0f\u5931\u8d25"

    filled-new-array {v4, v0}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 588
    nop

    .line 554
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_2
    return-wide v1

    :sswitch_data_0
    .sparse-switch
        0xc8 -> :sswitch_1
        0xce -> :sswitch_0
    .end sparse-switch
.end method

.method private final contentRangeStart(Ljava/lang/String;)Ljava/lang/Long;
    .locals 4
    .param p1, "contentRange"    # Ljava/lang/String;

    .line 544
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_1

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    const/4 v1, 0x0

    if-eqz v0, :cond_2

    return-object v1

    .line 545
    :cond_2
    const-string v0, "bytes "

    const-string v2, ""

    invoke-static {p1, v0, v2}, Lkotlin/text/StringsKt;->substringAfter(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 546
    const/16 v2, 0x2d

    const/4 v3, 0x2

    invoke-static {v0, v2, v1, v3, v1}, Lkotlin/text/StringsKt;->substringBefore$default(Ljava/lang/String;CLjava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 547
    invoke-static {v0}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    .line 545
    return-object v0
.end method

.method private final createDownloadClient()Lokhttp3/OkHttpClient;
    .locals 9

    .line 54
    const/4 v0, 0x1

    new-array v1, v0, [Ljavax/net/ssl/TrustManager;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$createDownloadClient$trustAllCerts$1;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$createDownloadClient$trustAllCerts$1;-><init>()V

    const/4 v3, 0x0

    aput-object v2, v1, v3

    .line 53
    nop

    .line 61
    .local v1, "trustAllCerts":[Ljavax/net/ssl/TrustManager;
    const-string v2, "SSL"

    invoke-static {v2}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v2

    .line 62
    .local v2, "sslContext":Ljavax/net/ssl/SSLContext;
    new-instance v4, Ljava/security/SecureRandom;

    invoke-direct {v4}, Ljava/security/SecureRandom;-><init>()V

    const/4 v5, 0x0

    invoke-virtual {v2, v5, v1, v4}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 64
    new-instance v4, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v4}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 65
    invoke-virtual {v2}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v5

    aget-object v3, v1, v3

    const-string v6, "null cannot be cast to non-null type javax.net.ssl.X509TrustManager"

    invoke-static {v3, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v3, Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v4, v5, v3}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    new-instance v4, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$$ExternalSyntheticLambda0;

    invoke-direct {v4}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$$ExternalSyntheticLambda0;-><init>()V

    .line 66
    invoke-virtual {v3, v4}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 69
    sget-object v4, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v5, 0x78

    invoke-virtual {v3, v5, v6, v4}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 70
    const-wide/16 v7, 0x708

    sget-object v4, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v7, v8, v4}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 71
    sget-object v4, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v5, v6, v4}, Lokhttp3/OkHttpClient$Builder;->writeTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 72
    const-wide/16 v4, 0x1c20

    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v4, v5, v6}, Lokhttp3/OkHttpClient$Builder;->callTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 74
    invoke-virtual {v3, v0}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 75
    new-instance v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;

    invoke-direct {v3}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;-><init>()V

    check-cast v3, Lokhttp3/Interceptor;

    invoke-virtual {v0, v3}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 76
    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    .line 65
    const-string v3, "Builder()\n            .s\u2026\u667a\u80fd\u91cd\u8bd5\n            .build()"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 64
    return-object v0
.end method

.method private static final createDownloadClient$lambda$0(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z
    .locals 0

    .line 66
    const/4 p0, 0x1

    return p0
.end method

.method private final dispatchDownloadResult(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
            "I",
            "Ljava/lang/Long;",
            "Ljava/lang/Long;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p5, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;

    if-eqz v0, :cond_0

    move-object v0, p5

    check-cast v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;

    iget v1, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p5, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;->label:I

    sub-int/2addr p5, v2

    iput p5, v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;

    invoke-direct {v0, p0, p5}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;-><init>(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p5, v0

    .local p5, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v6, p5, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;->result:Ljava/lang/Object;

    .local v6, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v7

    .line 526
    iget v0, p5, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;->label:I

    packed-switch v0, :pswitch_data_0

    .end local v6    # "$result":Ljava/lang/Object;
    .end local p5    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v6    # "$result":Ljava/lang/Object;
    .restart local p5    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object p1, v6

    goto :goto_1

    :pswitch_1
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move v2, p2

    .local v2, "status":I
    move-object v4, p4

    .local v4, "total":Ljava/lang/Long;
    move-object v1, p1

    .local v1, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    move-object v3, p3

    .line 538
    .local v3, "downloaded":Ljava/lang/Long;
    nop

    .line 533
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object p1

    invoke-virtual {p1}, Lkotlinx/coroutines/MainCoroutineDispatcher;->getImmediate()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object p1

    move-object v0, p1

    check-cast v0, Lkotlinx/coroutines/CoroutineDispatcher;

    .line 534
    nop

    .line 535
    .end local v1    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    nop

    .line 536
    .end local v2    # "status":I
    nop

    .line 537
    .end local v3    # "downloaded":Ljava/lang/Long;
    nop

    .line 532
    .end local v4    # "total":Ljava/lang/Long;
    const/4 p1, 0x1

    iput p1, p5, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$dispatchDownloadResult$1;->label:I

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt;->deliverDownloadResult(Lkotlinx/coroutines/CoroutineDispatcher;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v7, :cond_1

    .line 526
    return-object v7

    :cond_1
    :goto_1
    check-cast p1, Ljava/lang/Throwable;

    .line 538
    if-eqz p1, :cond_2

    .line 532
    nop

    .line 538
    nop

    .local p1, "it":Ljava/lang/Throwable;
    const/4 p2, 0x0

    .line 539
    .local p2, "$i$a$-let-OtaServiceImpl$dispatchDownloadResult$2":I
    sget-object p3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "flow=ota src=phone stage=download event=callback_failed type="

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p4

    filled-new-array {p4}, [Ljava/lang/Object;

    move-result-object p4

    invoke-static {p3, p4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 540
    nop

    .line 538
    .end local p1    # "it":Ljava/lang/Throwable;
    .end local p2    # "$i$a$-let-OtaServiceImpl$dispatchDownloadResult$2":I
    :cond_2
    nop

    .line 541
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic dispatchDownloadResult$default(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 7

    .line 526
    and-int/lit8 p7, p6, 0x4

    const/4 v0, 0x0

    if-eqz p7, :cond_0

    .line 529
    move-object v4, v0

    goto :goto_0

    .line 526
    :cond_0
    move-object v4, p3

    :goto_0
    and-int/lit8 p3, p6, 0x8

    if-eqz p3, :cond_1

    .line 530
    move-object v5, v0

    goto :goto_1

    .line 526
    :cond_1
    move-object v5, p4

    :goto_1
    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v6, p5

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private final downloadWithRetrofit(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 51
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
            "J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    move-object/from16 v1, p6

    instance-of v2, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;

    if-eqz v2, :cond_0

    move-object v2, v1

    check-cast v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;

    iget v3, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    const/high16 v4, -0x80000000

    and-int/2addr v3, v4

    if-eqz v3, :cond_0

    iget v1, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    sub-int/2addr v1, v4

    iput v1, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    move-object v1, v2

    move-object/from16 v3, p0

    goto :goto_0

    :cond_0
    new-instance v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;

    move-object/from16 v3, p0

    invoke-direct {v2, v3, v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;-><init>(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lkotlin/coroutines/Continuation;)V

    move-object v1, v2

    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    :goto_0
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->result:Ljava/lang/Object;

    .local v2, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v12

    .line 299
    iget v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    const-string v13, "flow=ota src=phone stage=download event=cancelled"

    packed-switch v4, :pswitch_data_0

    move-object v12, v1

    move-object/from16 v26, v2

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v2    # "$result":Ljava/lang/Object;
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v2    # "$result":Ljava/lang/Object;
    :pswitch_0
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/DisposableHandle;

    .local v4, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :try_start_0
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-object v12, v1

    move-object/from16 v26, v2

    goto/16 :goto_29

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :pswitch_1
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/DisposableHandle;

    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :try_start_1
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object v12, v1

    move-object/from16 v26, v2

    goto/16 :goto_2e

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :pswitch_2
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/DisposableHandle;

    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlinx/coroutines/Job;

    .local v5, "currentJob":Lkotlinx/coroutines/Job;
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .local v7, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_start_2
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/util/concurrent/CancellationException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/net/SocketTimeoutException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object v12, v1

    move-object/from16 v26, v2

    goto/16 :goto_24

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :pswitch_3
    const/4 v4, 0x0

    .local v4, "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    const/4 v5, 0x0

    .local v5, "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$4:Ljava/lang/Object;

    check-cast v6, Ljava/io/Closeable;

    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    check-cast v7, Lkotlinx/coroutines/DisposableHandle;

    .local v7, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    iget-object v8, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    check-cast v8, Lkotlinx/coroutines/Job;

    .local v8, "currentJob":Lkotlinx/coroutines/Job;
    iget-object v9, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    check-cast v9, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .local v9, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    iget-object v10, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v10, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .local v10, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_start_3
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object/from16 v26, v2

    move-object v14, v9

    move-object/from16 v28, v13

    move-object v9, v7

    move-object v13, v10

    move-object v7, v12

    const/4 v10, 0x1

    move-object v12, v1

    goto/16 :goto_1a

    .line 374
    .end local v4    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .end local v5    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    :catchall_0
    move-exception v0

    move-object/from16 v26, v2

    move-object v4, v7

    move-object v5, v8

    move-object v14, v9

    move-object v7, v12

    move-object/from16 v28, v13

    move-object v12, v1

    move-object v13, v10

    const/4 v10, 0x1

    move-object v1, v0

    goto/16 :goto_22

    .line 299
    .end local v7    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v8    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v9    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :pswitch_4
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/DisposableHandle;

    .local v4, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlinx/coroutines/Job;

    .local v5, "currentJob":Lkotlinx/coroutines/Job;
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .restart local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .local v7, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_start_4
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/util/concurrent/CancellationException; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/net/SocketTimeoutException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    move-object/from16 v26, v2

    move-object v2, v12

    move-object/from16 v28, v13

    const/4 v3, 0x1

    goto/16 :goto_d

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :pswitch_5
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/DisposableHandle;

    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlinx/coroutines/Job;

    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .restart local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .restart local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_start_5
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/util/concurrent/CancellationException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/net/SocketTimeoutException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    move-object/from16 v26, v2

    move-object v2, v12

    move-object/from16 v28, v13

    const/16 v16, 0x1

    goto/16 :goto_c

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :pswitch_6
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/DisposableHandle;

    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlinx/coroutines/Job;

    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .restart local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .restart local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_start_6
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_6
    .catch Ljava/util/concurrent/CancellationException; {:try_start_6 .. :try_end_6} :catch_2
    .catch Ljava/net/SocketTimeoutException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    move-object/from16 v26, v2

    move-object v2, v12

    move-object/from16 v28, v13

    const/16 v16, 0x1

    goto/16 :goto_9

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :pswitch_7
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/DisposableHandle;

    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlinx/coroutines/Job;

    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .restart local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    .restart local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_start_7
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_7
    .catch Ljava/util/concurrent/CancellationException; {:try_start_7 .. :try_end_7} :catch_2
    .catch Ljava/net/SocketTimeoutException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_0
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    move-object/from16 v26, v2

    move-object/from16 v28, v13

    const/4 v3, 0x1

    move-object/from16 v49, v12

    move-object v12, v4

    move-object/from16 v4, v49

    goto/16 :goto_8

    .line 517
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catchall_1
    move-exception v0

    move-object v12, v1

    move-object/from16 v26, v2

    move-object v1, v0

    goto/16 :goto_31

    .line 508
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_0
    move-exception v0

    move-object/from16 v26, v2

    move-object v14, v6

    move-object v3, v12

    move-object/from16 v28, v13

    move-object v2, v0

    move-object v12, v1

    move-object v1, v4

    move-object v13, v7

    goto/16 :goto_28

    .line 491
    :catch_1
    move-exception v0

    move-object/from16 v26, v2

    move-object v14, v6

    move-object v3, v12

    move-object/from16 v28, v13

    move-object v2, v0

    move-object v12, v1

    move-object v1, v4

    move-object v13, v7

    goto/16 :goto_2a

    .line 489
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_2
    move-exception v0

    move-object v12, v1

    move-object/from16 v26, v2

    move-object v1, v0

    goto/16 :goto_30

    .line 299
    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :pswitch_8
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v10, p0

    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    move-object/from16 v8, p2

    .local v8, "path":Ljava/lang/String;
    move-wide/from16 v4, p4

    .local v4, "downloadedSize":J
    move-object/from16 v9, p1

    .local v9, "url":Ljava/lang/String;
    move-object/from16 v7, p3

    .line 300
    .local v7, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    const/4 v6, 0x0

    .line 682
    .local v6, "$i$f$currentCoroutineContext":I
    invoke-interface {v1}, Lkotlin/coroutines/Continuation;->getContext()Lkotlin/coroutines/CoroutineContext;

    move-result-object v15

    .line 300
    .end local v6    # "$i$f$currentCoroutineContext":I
    sget-object v6, Lkotlinx/coroutines/Job;->Key:Lkotlinx/coroutines/Job$Key;

    check-cast v6, Lkotlin/coroutines/CoroutineContext$Key;

    invoke-interface {v15, v6}, Lkotlin/coroutines/CoroutineContext;->get(Lkotlin/coroutines/CoroutineContext$Key;)Lkotlin/coroutines/CoroutineContext$Element;

    move-result-object v6

    check-cast v6, Lkotlinx/coroutines/Job;

    if-nez v6, :cond_1

    .end local v4    # "downloadedSize":J
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v8    # "path":Ljava/lang/String;
    .end local v9    # "url":Ljava/lang/String;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v4

    .restart local v4    # "downloadedSize":J
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v8    # "path":Ljava/lang/String;
    .restart local v9    # "url":Ljava/lang/String;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :cond_1
    move-object v15, v6

    .line 301
    .local v15, "currentJob":Lkotlinx/coroutines/Job;
    invoke-interface {v15}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v6

    if-nez v6, :cond_2

    sget-object v6, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v6

    .line 303
    :cond_2
    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 304
    .local v6, "outputFile":Ljava/io/File;
    const/16 v16, 0x0

    .line 306
    .local v16, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    sget-object v14, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v26, v2

    .end local v2    # "$result":Ljava/lang/Object;
    .local v26, "$result":Ljava/lang/Object;
    const-string v2, "downloadWithRetrofit \u5f00\u59cb\u4e0b\u8f7d outputFile size: "

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v27, v12

    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v11

    invoke-virtual {v2, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v14, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 308
    nop

    .line 309
    :try_start_8
    new-instance v2, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 312
    .local v2, "progress":Lkotlin/jvm/internal/Ref$IntRef;
    new-instance v11, Lokhttp3/Request$Builder;

    invoke-direct {v11}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {v11, v9}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v11

    move-object v12, v11

    .local v12, "$this$downloadWithRetrofit_u24lambda_u242":Lokhttp3/Request$Builder;
    const/4 v14, 0x0

    .line 313
    .local v14, "$i$a$-apply-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1":I
    sget-object v18, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual/range {v18 .. v18}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->xAgentHeaderOrNull()Ljava/lang/String;

    move-result-object v18
    :try_end_8
    .catch Ljava/util/concurrent/CancellationException; {:try_start_8 .. :try_end_8} :catch_32
    .catch Ljava/net/SocketTimeoutException; {:try_start_8 .. :try_end_8} :catch_31
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_30
    .catchall {:try_start_8 .. :try_end_8} :catchall_1f

    if-eqz v18, :cond_3

    move-object/from16 p1, v18

    .line 683
    .local p1, "it":Ljava/lang/String;
    const/16 v18, 0x0

    .line 313
    .local v18, "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1$1":I
    :try_start_9
    const-string v3, "X-Agent"

    move/from16 p2, v14

    move-object/from16 v14, p1

    .end local p1    # "it":Ljava/lang/String;
    .local v14, "it":Ljava/lang/String;
    .local p2, "$i$a$-apply-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1":I
    invoke-virtual {v12, v3, v14}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .end local v12    # "$this$downloadWithRetrofit_u24lambda_u242":Lokhttp3/Request$Builder;
    .end local v14    # "it":Ljava/lang/String;
    .end local v18    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1$1":I
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_1

    .line 517
    .end local v2    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v4    # "downloadedSize":J
    .end local v6    # "outputFile":Ljava/io/File;
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v8    # "path":Ljava/lang/String;
    .end local v9    # "url":Ljava/lang/String;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local p2    # "$i$a$-apply-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1":I
    :catchall_2
    move-exception v0

    move-object v12, v1

    move-object/from16 v4, v16

    move-object v1, v0

    goto/16 :goto_31

    .line 508
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_3
    move-exception v0

    move-object v2, v0

    move-object v12, v1

    move-object v14, v7

    move-object/from16 v28, v13

    move-object v5, v15

    move-object/from16 v1, v16

    move-object/from16 v3, v27

    move-object v13, v10

    goto/16 :goto_28

    .line 491
    :catch_4
    move-exception v0

    move-object v2, v0

    move-object v12, v1

    move-object v14, v7

    move-object/from16 v28, v13

    move-object v5, v15

    move-object/from16 v1, v16

    move-object/from16 v3, v27

    move-object v13, v10

    goto/16 :goto_2a

    .line 489
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_5
    move-exception v0

    move-object v12, v1

    move-object/from16 v4, v16

    move-object v1, v0

    goto/16 :goto_30

    .line 313
    .restart local v2    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v4    # "downloadedSize":J
    .restart local v6    # "outputFile":Ljava/io/File;
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v8    # "path":Ljava/lang/String;
    .restart local v9    # "url":Ljava/lang/String;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v12    # "$this$downloadWithRetrofit_u24lambda_u242":Lokhttp3/Request$Builder;
    .local v14, "$i$a$-apply-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1":I
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :cond_3
    move/from16 p2, v14

    .line 314
    .end local v12    # "$this$downloadWithRetrofit_u24lambda_u242":Lokhttp3/Request$Builder;
    .end local v14    # "$i$a$-apply-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1":I
    .restart local p2    # "$i$a$-apply-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1":I
    :goto_1
    nop

    .line 312
    .end local p2    # "$i$a$-apply-OtaServiceImpl$downloadWithRetrofit$requestBuilder$1":I
    move-object v3, v11

    .line 315
    .local v3, "requestBuilder":Lokhttp3/Request$Builder;
    const-wide/16 v11, 0x0

    cmp-long v14, v4, v11

    if-lez v14, :cond_4

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v14

    if-eqz v14, :cond_4

    .line 316
    const-string v14, "Range"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "bytes="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    const/16 v12, 0x2d

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v3, v14, v11}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 318
    sget-object v11, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "downloadWithRetrofit \u8bbe\u7f6eRange\u5934: bytes="

    invoke-virtual {v14, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    const/16 v14, 0x2d

    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v11, v12}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_9
    .catch Ljava/util/concurrent/CancellationException; {:try_start_9 .. :try_end_9} :catch_5
    .catch Ljava/net/SocketTimeoutException; {:try_start_9 .. :try_end_9} :catch_4
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 322
    :cond_4
    :try_start_a
    invoke-direct {v10}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getDownloadClient()Lokhttp3/OkHttpClient;

    move-result-object v11

    invoke-virtual {v3}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v12

    invoke-virtual {v11, v12}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v11

    move-object v3, v11

    .line 323
    .local v3, "call":Lokhttp3/Call;
    new-instance v11, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$2;

    invoke-direct {v11, v3}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$2;-><init>(Lokhttp3/Call;)V

    check-cast v11, Lkotlin/jvm/functions/Function1;

    invoke-interface {v15, v11}, Lkotlinx/coroutines/Job;->invokeOnCompletion(Lkotlin/jvm/functions/Function1;)Lkotlinx/coroutines/DisposableHandle;

    move-result-object v11
    :try_end_a
    .catch Ljava/util/concurrent/CancellationException; {:try_start_a .. :try_end_a} :catch_32
    .catch Ljava/net/SocketTimeoutException; {:try_start_a .. :try_end_a} :catch_31
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_30
    .catchall {:try_start_a .. :try_end_a} :catchall_1f

    move-object v12, v11

    .line 324
    .end local v16    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :try_start_b
    invoke-interface {v3}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v11

    move-object v3, v11

    .line 326
    .local v3, "response":Lokhttp3/Response;
    invoke-virtual {v3}, Lokhttp3/Response;->code()I

    move-result v11

    .line 328
    .local v11, "statusCode":I
    sget-object v14, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;
    :try_end_b
    .catch Ljava/util/concurrent/CancellationException; {:try_start_b .. :try_end_b} :catch_2f
    .catch Ljava/net/SocketTimeoutException; {:try_start_b .. :try_end_b} :catch_2e
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_2d
    .catchall {:try_start_b .. :try_end_b} :catchall_1e

    move-object/from16 v28, v13

    :try_start_c
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 p3, v2

    .end local v2    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .local p3, "progress":Lkotlin/jvm/internal/Ref$IntRef;
    const-string v2, "downloadWithRetrofit HTTP\u72b6\u6001\u7801: "

    invoke-virtual {v13, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v14, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_c
    .catch Ljava/util/concurrent/CancellationException; {:try_start_c .. :try_end_c} :catch_2f
    .catch Ljava/net/SocketTimeoutException; {:try_start_c .. :try_end_c} :catch_2c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_2b
    .catchall {:try_start_c .. :try_end_c} :catchall_1e

    .line 331
    const/16 v2, 0x1a0

    const-string v13, "Content-Range"

    if-ne v11, v2, :cond_d

    .line 333
    .end local v8    # "path":Ljava/lang/String;
    .end local v9    # "url":Ljava/lang/String;
    .end local v11    # "statusCode":I
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    nop

    .line 332
    :try_start_d
    invoke-virtual {v3, v13}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2
    :try_end_d
    .catch Ljava/util/concurrent/CancellationException; {:try_start_d .. :try_end_d} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_d .. :try_end_d} :catch_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_c
    .catchall {:try_start_d .. :try_end_d} :catchall_3

    .line 333
    if-eqz v2, :cond_5

    .line 332
    nop

    .line 333
    :try_start_e
    const-string v8, "*/"

    const-string v9, ""

    invoke-static {v2, v8, v9}, Lkotlin/text/StringsKt;->substringAfter(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_5

    invoke-static {v2}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v2
    :try_end_e
    .catch Ljava/util/concurrent/CancellationException; {:try_start_e .. :try_end_e} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_e .. :try_end_e} :catch_7
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_6
    .catchall {:try_start_e .. :try_end_e} :catchall_3

    goto :goto_2

    .line 508
    .end local v3    # "response":Lokhttp3/Response;
    .end local v4    # "downloadedSize":J
    .end local v6    # "outputFile":Ljava/io/File;
    :catch_6
    move-exception v0

    move-object v2, v0

    move-object v14, v7

    move-object v13, v10

    move-object v5, v15

    move-object/from16 v3, v27

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_28

    .line 491
    :catch_7
    move-exception v0

    move-object v2, v0

    move-object v14, v7

    move-object v13, v10

    move-object v5, v15

    move-object/from16 v3, v27

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_2a

    .line 333
    .restart local v3    # "response":Lokhttp3/Response;
    .restart local v4    # "downloadedSize":J
    .restart local v6    # "outputFile":Ljava/io/File;
    :cond_5
    const/4 v2, 0x0

    .line 332
    :goto_2
    nop

    .line 334
    .local v2, "remoteTotal":Ljava/lang/Long;
    :try_start_f
    invoke-virtual {v3}, Lokhttp3/Response;->close()V
    :try_end_f
    .catch Ljava/util/concurrent/CancellationException; {:try_start_f .. :try_end_f} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_f .. :try_end_f} :catch_d
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_c
    .catchall {:try_start_f .. :try_end_f} :catchall_3

    .line 335
    .end local v3    # "response":Lokhttp3/Response;
    if-eqz v2, :cond_6

    :try_start_10
    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v8

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v18

    cmp-long v3, v18, v8

    if-nez v3, :cond_6

    .line 336
    nop

    .end local v4    # "downloadedSize":J
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v8
    :try_end_10
    .catch Ljava/util/concurrent/CancellationException; {:try_start_10 .. :try_end_10} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_10 .. :try_end_10} :catch_7
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_6
    .catchall {:try_start_10 .. :try_end_10} :catchall_3

    cmp-long v3, v4, v8

    if-nez v3, :cond_6

    const/4 v3, 0x1

    goto :goto_3

    :cond_6
    const/4 v3, 0x0

    .line 335
    :goto_3
    nop

    .line 337
    .local v3, "complete":Z
    :try_start_11
    sget-object v4, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "flow=ota src=phone stage=download event=range_416 complete="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    if-eqz v3, :cond_7

    const/4 v8, 0x1

    goto :goto_4

    :cond_7
    const/4 v8, 0x0

    :goto_4
    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, " bytes="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v8

    invoke-virtual {v5, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_11
    .catch Ljava/util/concurrent/CancellationException; {:try_start_11 .. :try_end_11} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_11 .. :try_end_11} :catch_d
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_c
    .catchall {:try_start_11 .. :try_end_11} :catchall_3

    .line 338
    nop

    .line 339
    nop

    .line 340
    if-eqz v3, :cond_8

    const/4 v14, 0x1

    goto :goto_5

    .line 341
    :cond_8
    const/4 v14, -0x1

    .line 342
    :goto_5
    if-eqz v3, :cond_9

    :try_start_12
    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v4

    invoke-static {v4, v5}, Lkotlin/coroutines/jvm/internal/Boxing;->boxLong(J)Ljava/lang/Long;

    move-result-object v4
    :try_end_12
    .catch Ljava/util/concurrent/CancellationException; {:try_start_12 .. :try_end_12} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_12 .. :try_end_12} :catch_7
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_6
    .catchall {:try_start_12 .. :try_end_12} :catchall_3

    goto :goto_6

    :cond_9
    const/4 v4, 0x0

    .line 343
    .end local v6    # "outputFile":Ljava/io/File;
    :goto_6
    if-eqz v3, :cond_a

    goto :goto_7

    .end local v2    # "remoteTotal":Ljava/lang/Long;
    .end local v3    # "complete":Z
    :cond_a
    const/4 v2, 0x0

    .line 338
    :goto_7
    :try_start_13
    iput-object v10, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    iput-object v12, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;
    :try_end_13
    .catch Ljava/util/concurrent/CancellationException; {:try_start_13 .. :try_end_13} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_13 .. :try_end_13} :catch_d
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_c
    .catchall {:try_start_13 .. :try_end_13} :catchall_3

    const/4 v3, 0x1

    :try_start_14
    iput v3, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    move-object/from16 p1, v10

    move-object/from16 p2, v7

    move/from16 p3, v14

    move-object/from16 p4, v4

    move-object/from16 p5, v2

    move-object/from16 p6, v1

    invoke-direct/range {p1 .. p6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_14
    .catch Ljava/util/concurrent/CancellationException; {:try_start_14 .. :try_end_14} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_14 .. :try_end_14} :catch_b
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_c
    .catchall {:try_start_14 .. :try_end_14} :catchall_3

    move-object/from16 v4, v27

    if-ne v2, v4, :cond_b

    .line 299
    return-object v4

    .line 338
    :cond_b
    move-object v6, v7

    move-object v7, v10

    move-object v5, v15

    .line 345
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v7, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :goto_8
    :try_start_15
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_15
    .catch Ljava/util/concurrent/CancellationException; {:try_start_15 .. :try_end_15} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_15 .. :try_end_15} :catch_9
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_8
    .catchall {:try_start_15 .. :try_end_15} :catchall_3

    .line 517
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    nop

    .end local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v12, :cond_c

    invoke-interface {v12}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 345
    :cond_c
    return-object v2

    .line 517
    .restart local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catchall_3
    move-exception v0

    move-object v4, v12

    move-object v12, v1

    move-object v1, v0

    goto/16 :goto_31

    .line 508
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_8
    move-exception v0

    move-object v2, v0

    move-object v3, v4

    move-object v14, v6

    move-object v13, v7

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_28

    .line 491
    :catch_9
    move-exception v0

    move-object v2, v0

    move-object v3, v4

    move-object v14, v6

    move-object v13, v7

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_2a

    .line 489
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_a
    move-exception v0

    move-object v4, v12

    move-object v12, v1

    move-object v1, v0

    goto/16 :goto_30

    .line 491
    .local v7, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_b
    move-exception v0

    move-object/from16 v4, v27

    move-object v2, v0

    move-object v3, v4

    move-object v14, v7

    move-object v13, v10

    move-object v5, v15

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_2a

    .line 508
    :catch_c
    move-exception v0

    move-object/from16 v4, v27

    move-object v2, v0

    move-object v3, v4

    move-object v14, v7

    move-object v13, v10

    move-object v5, v15

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_28

    .line 491
    :catch_d
    move-exception v0

    move-object/from16 v4, v27

    const/4 v3, 0x1

    move-object v2, v0

    move-object v3, v4

    move-object v14, v7

    move-object v13, v10

    move-object v5, v15

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_2a

    .line 348
    .local v3, "response":Lokhttp3/Response;
    .restart local v4    # "downloadedSize":J
    .local v6, "outputFile":Ljava/io/File;
    .restart local v8    # "path":Ljava/lang/String;
    .restart local v9    # "url":Ljava/lang/String;
    .restart local v11    # "statusCode":I
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_d
    move-object/from16 v2, v27

    const/16 v16, 0x1

    const/16 v14, 0xc8

    if-ne v11, v14, :cond_10

    const-wide/16 v17, 0x0

    cmp-long v14, v4, v17

    if-lez v14, :cond_10

    .line 349
    .end local v11    # "statusCode":I
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :try_start_16
    sget-object v11, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v14, "\u670d\u52a1\u5668\u8fd4\u56de 200 \u4f46\u5df2\u5c1d\u8bd5\u65ad\u70b9\u7eed\u4f20\uff08downloadedSize="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string/jumbo v14, "\uff09\uff0c\u8bf4\u660e\u4e0d\u652f\u6301 Range\u3002\u5c06\u5220\u9664\u6587\u4ef6\u5e76\u91cd\u65b0\u4e0b\u8f7d\u3002"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    .end local v4    # "downloadedSize":J
    invoke-static {v11, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 351
    invoke-virtual {v3}, Lokhttp3/Response;->close()V

    .line 352
    .end local v3    # "response":Lokhttp3/Response;
    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 353
    nop

    .end local v6    # "outputFile":Ljava/io/File;
    iput-object v10, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    iput-object v12, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    const/4 v3, 0x2

    iput v3, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I
    :try_end_16
    .catch Ljava/util/concurrent/CancellationException; {:try_start_16 .. :try_end_16} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_16 .. :try_end_16} :catch_14
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_13
    .catchall {:try_start_16 .. :try_end_16} :catchall_3

    const-wide/16 v13, 0x0

    move-object v4, v10

    move-object v5, v9

    move-object v6, v8

    move-object v3, v7

    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v3, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    move-object/from16 v17, v8

    move-object/from16 v18, v9

    .end local v8    # "path":Ljava/lang/String;
    .end local v9    # "url":Ljava/lang/String;
    .local v17, "path":Ljava/lang/String;
    .local v18, "url":Ljava/lang/String;
    move-wide v8, v13

    move-object v14, v10

    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    move-object v10, v1

    :try_start_17
    invoke-direct/range {v4 .. v10}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadWithRetrofit(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v4
    :try_end_17
    .catch Ljava/util/concurrent/CancellationException; {:try_start_17 .. :try_end_17} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_17 .. :try_end_17} :catch_12
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_11
    .catchall {:try_start_17 .. :try_end_17} :catchall_3

    .end local v17    # "path":Ljava/lang/String;
    .end local v18    # "url":Ljava/lang/String;
    if-ne v4, v2, :cond_e

    .line 299
    return-object v2

    .line 353
    :cond_e
    move-object v6, v3

    move-object v4, v12

    move-object v7, v14

    move-object v5, v15

    .line 355
    .end local v3    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .local v4, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v7, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :goto_9
    :try_start_18
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_18
    .catch Ljava/util/concurrent/CancellationException; {:try_start_18 .. :try_end_18} :catch_10
    .catch Ljava/net/SocketTimeoutException; {:try_start_18 .. :try_end_18} :catch_f
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_e
    .catchall {:try_start_18 .. :try_end_18} :catchall_4

    .line 517
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    nop

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v4, :cond_f

    invoke-interface {v4}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 355
    :cond_f
    return-object v2

    .line 517
    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catchall_4
    move-exception v0

    move-object v12, v1

    move-object v1, v0

    goto/16 :goto_31

    .line 508
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_e
    move-exception v0

    move-object v12, v1

    move-object v3, v2

    move-object v1, v4

    move-object v14, v6

    move-object v13, v7

    move-object v2, v0

    goto/16 :goto_28

    .line 491
    :catch_f
    move-exception v0

    move-object v12, v1

    move-object v3, v2

    move-object v1, v4

    move-object v14, v6

    move-object v13, v7

    move-object v2, v0

    goto/16 :goto_2a

    .line 489
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_10
    move-exception v0

    move-object v12, v1

    move-object v1, v0

    goto/16 :goto_30

    .line 508
    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v3    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_11
    move-exception v0

    move-object v13, v14

    move-object v5, v15

    move-object v14, v3

    move-object v3, v2

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_28

    .line 491
    :catch_12
    move-exception v0

    move-object v13, v14

    move-object v5, v15

    move-object v14, v3

    move-object v3, v2

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    goto/16 :goto_2a

    .line 508
    .end local v3    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v7, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_13
    move-exception v0

    move-object v3, v7

    move-object v14, v10

    move-object v13, v14

    move-object v5, v15

    move-object v14, v3

    move-object v3, v2

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v3    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    goto/16 :goto_28

    .line 491
    .end local v3    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_14
    move-exception v0

    move-object v3, v7

    move-object v14, v10

    move-object v13, v14

    move-object v5, v15

    move-object v14, v3

    move-object v3, v2

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v3    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    goto/16 :goto_2a

    .line 348
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v3, "response":Lokhttp3/Response;
    .local v4, "downloadedSize":J
    .local v6, "outputFile":Ljava/io/File;
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v8    # "path":Ljava/lang/String;
    .restart local v9    # "url":Ljava/lang/String;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v11    # "statusCode":I
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_10
    move-object/from16 v17, v8

    move-object/from16 v18, v9

    move-object v14, v10

    move-object v10, v7

    .line 358
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v8    # "path":Ljava/lang/String;
    .end local v9    # "url":Ljava/lang/String;
    .local v10, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v17    # "path":Ljava/lang/String;
    .restart local v18    # "url":Ljava/lang/String;
    const/16 v7, 0xce

    if-ne v11, v7, :cond_14

    :try_start_19
    invoke-virtual {v3, v13}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v14, v7}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->contentRangeStart(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v7

    if-nez v7, :cond_11

    :goto_a
    goto :goto_b

    :cond_11
    invoke-virtual {v7}, Ljava/lang/Long;->longValue()J

    move-result-wide v7

    cmp-long v7, v7, v4

    if-eqz v7, :cond_14

    goto :goto_a

    .line 359
    .end local v11    # "statusCode":I
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :goto_b
    sget-object v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "flow=ota src=phone stage=download event=invalid_content_range offset="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    .end local v4    # "downloadedSize":J
    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 360
    invoke-virtual {v3}, Lokhttp3/Response;->close()V

    .line 361
    .end local v3    # "response":Lokhttp3/Response;
    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 362
    nop

    .end local v6    # "outputFile":Ljava/io/File;
    iput-object v14, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    iput-object v10, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    iput-object v12, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    const/4 v3, 0x3

    iput v3, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I
    :try_end_19
    .catch Ljava/util/concurrent/CancellationException; {:try_start_19 .. :try_end_19} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_19 .. :try_end_19} :catch_16
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_15
    .catchall {:try_start_19 .. :try_end_19} :catchall_3

    const-wide/16 v8, 0x0

    move-object v4, v14

    move-object/from16 v5, v18

    move-object/from16 v6, v17

    move-object v7, v10

    move-object v13, v10

    .end local v10    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    move-object v10, v1

    :try_start_1a
    invoke-direct/range {v4 .. v10}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadWithRetrofit(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3
    :try_end_1a
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1a .. :try_end_1a} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_1a .. :try_end_1a} :catch_17
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_18
    .catchall {:try_start_1a .. :try_end_1a} :catchall_3

    .end local v17    # "path":Ljava/lang/String;
    .end local v18    # "url":Ljava/lang/String;
    if-ne v3, v2, :cond_12

    .line 299
    return-object v2

    .line 362
    :cond_12
    move-object v4, v12

    move-object v6, v13

    move-object v7, v14

    move-object v5, v15

    .line 363
    .end local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .local v4, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v7, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :goto_c
    :try_start_1b
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1b
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1b .. :try_end_1b} :catch_10
    .catch Ljava/net/SocketTimeoutException; {:try_start_1b .. :try_end_1b} :catch_f
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1b} :catch_e
    .catchall {:try_start_1b .. :try_end_1b} :catchall_4

    .line 517
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    nop

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v4, :cond_13

    invoke-interface {v4}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 363
    :cond_13
    return-object v2

    .line 508
    .restart local v10    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_15
    move-exception v0

    move-object v13, v10

    move-object v3, v2

    move-object v5, v15

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object/from16 v50, v14

    move-object v14, v13

    move-object/from16 v13, v50

    .end local v10    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_28

    .line 491
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :catch_16
    move-exception v0

    move-object v13, v10

    move-object v3, v2

    move-object v5, v15

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object/from16 v50, v14

    move-object v14, v13

    move-object/from16 v13, v50

    .end local v10    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_2a

    .line 358
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v3    # "response":Lokhttp3/Response;
    .local v4, "downloadedSize":J
    .local v6, "outputFile":Ljava/io/File;
    .restart local v10    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v11    # "statusCode":I
    .restart local v17    # "path":Ljava/lang/String;
    .restart local v18    # "url":Ljava/lang/String;
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_14
    move-object v13, v10

    .line 366
    .end local v10    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v17    # "path":Ljava/lang/String;
    .end local v18    # "url":Ljava/lang/String;
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :try_start_1c
    invoke-virtual {v3}, Lokhttp3/Response;->isSuccessful()Z

    move-result v7
    :try_end_1c
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1c .. :try_end_1c} :catch_2f
    .catch Ljava/net/SocketTimeoutException; {:try_start_1c .. :try_end_1c} :catch_2a
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_29
    .catchall {:try_start_1c .. :try_end_1c} :catchall_1e

    if-eqz v7, :cond_28

    .line 367
    :try_start_1d
    invoke-virtual {v3}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v7
    :try_end_1d
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1d .. :try_end_1d} :catch_22
    .catch Ljava/net/SocketTimeoutException; {:try_start_1d .. :try_end_1d} :catch_21
    .catch Ljava/lang/Exception; {:try_start_1d .. :try_end_1d} :catch_20
    .catchall {:try_start_1d .. :try_end_1d} :catchall_1c

    .line 368
    .local v7, "responseBody":Lokhttp3/ResponseBody;
    if-nez v7, :cond_17

    .line 369
    .end local v4    # "downloadedSize":J
    .end local v6    # "outputFile":Ljava/io/File;
    .end local v7    # "responseBody":Lokhttp3/ResponseBody;
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :try_start_1e
    invoke-virtual {v3}, Lokhttp3/Response;->close()V

    .line 370
    .end local v3    # "response":Lokhttp3/Response;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "flow=ota src=phone stage=download event=empty_body code="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .end local v11    # "statusCode":I
    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 371
    iput-object v14, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    iput-object v13, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    iput-object v12, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    const/4 v3, 0x4

    iput v3, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I
    :try_end_1e
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1e .. :try_end_1e} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_1e .. :try_end_1e} :catch_19
    .catch Ljava/lang/Exception; {:try_start_1e .. :try_end_1e} :catch_18
    .catchall {:try_start_1e .. :try_end_1e} :catchall_3

    const/4 v6, -0x1

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/16 v10, 0xc

    const/4 v11, 0x0

    move-object v4, v14

    move-object v5, v13

    move-object v9, v1

    move/from16 v3, v16

    :try_start_1f
    invoke-static/range {v4 .. v11}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult$default(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v4
    :try_end_1f
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1f .. :try_end_1f} :catch_a
    .catch Ljava/net/SocketTimeoutException; {:try_start_1f .. :try_end_1f} :catch_17
    .catch Ljava/lang/Exception; {:try_start_1f .. :try_end_1f} :catch_18
    .catchall {:try_start_1f .. :try_end_1f} :catchall_3

    if-ne v4, v2, :cond_15

    .line 299
    return-object v2

    .line 371
    :cond_15
    move-object v4, v12

    move-object v6, v13

    move-object v7, v14

    move-object v5, v15

    .line 372
    .end local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .local v4, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v7, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :goto_d
    :try_start_20
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_20
    .catch Ljava/util/concurrent/CancellationException; {:try_start_20 .. :try_end_20} :catch_10
    .catch Ljava/net/SocketTimeoutException; {:try_start_20 .. :try_end_20} :catch_f
    .catch Ljava/lang/Exception; {:try_start_20 .. :try_end_20} :catch_e
    .catchall {:try_start_20 .. :try_end_20} :catchall_4

    .line 517
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    nop

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v4, :cond_16

    invoke-interface {v4}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 372
    :cond_16
    return-object v2

    .line 491
    .restart local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_17
    move-exception v0

    goto :goto_e

    .line 508
    :catch_18
    move-exception v0

    move-object v3, v2

    move-object v5, v15

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object/from16 v50, v14

    move-object v14, v13

    move-object/from16 v13, v50

    goto/16 :goto_28

    .line 491
    :catch_19
    move-exception v0

    move/from16 v3, v16

    :goto_e
    move-object v3, v2

    move-object v5, v15

    move-object v2, v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object/from16 v50, v14

    move-object v14, v13

    move-object/from16 v13, v50

    goto/16 :goto_2a

    .line 374
    .restart local v3    # "response":Lokhttp3/Response;
    .local v4, "downloadedSize":J
    .local v6, "outputFile":Ljava/io/File;
    .local v7, "responseBody":Lokhttp3/ResponseBody;
    .restart local v11    # "statusCode":I
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_17
    move/from16 v10, v16

    :try_start_21
    move-object v8, v7

    check-cast v8, Ljava/io/Closeable;
    :try_end_21
    .catch Ljava/util/concurrent/CancellationException; {:try_start_21 .. :try_end_21} :catch_22
    .catch Ljava/net/SocketTimeoutException; {:try_start_21 .. :try_end_21} :catch_1f
    .catch Ljava/lang/Exception; {:try_start_21 .. :try_end_21} :catch_20
    .catchall {:try_start_21 .. :try_end_21} :catchall_1c

    .end local v7    # "responseBody":Lokhttp3/ResponseBody;
    :try_start_22
    move-object v7, v8

    check-cast v7, Lokhttp3/ResponseBody;

    .local v7, "body":Lokhttp3/ResponseBody;
    const/4 v9, 0x0

    .line 375
    .local v9, "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    invoke-virtual {v7}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v16

    move-object/from16 p5, v16

    .line 377
    .local p5, "inputStream":Ljava/io/InputStream;
    sget-object v16, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_1a

    :try_start_23
    const-string v10, "response"

    invoke-static {v3, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v7}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v18

    move-object/from16 v17, v3

    move-wide/from16 v20, v4

    move/from16 v22, v11

    invoke-direct/range {v16 .. v22}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->calculateTotalSize(Lokhttp3/Response;JJI)J

    move-result-wide v16

    move-wide/from16 v10, v16

    .line 379
    .end local v3    # "response":Lokhttp3/Response;
    .end local v11    # "statusCode":I
    .local v10, "totalBytes":J
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    move/from16 v29, v9

    .end local v9    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .local v29, "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_23
    .catchall {:try_start_23 .. :try_end_23} :catchall_19

    move-object/from16 v30, v2

    :try_start_24
    const-string v2, "downloadWithRetrofit \u603b\u5927\u5c0f\u8ba1\u7b97: contentLength="

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2
    :try_end_24
    .catchall {:try_start_24 .. :try_end_24} :catchall_18

    move-object/from16 v31, v8

    :try_start_25
    invoke-virtual {v7}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v8

    invoke-virtual {v2, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, ", downloadedSize="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, ", totalBytes="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .end local v7    # "body":Lokhttp3/ResponseBody;
    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 382
    new-instance v2, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    .local v2, "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    iput-wide v4, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 383
    const/4 v3, 0x0

    .local v3, "lastProgress":I
    const/4 v3, -0x1

    .line 384
    const-wide/16 v7, 0x0

    .local v7, "lastUpdateTime":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v16

    move-wide/from16 v7, v16

    .line 385
    const-wide/16 v16, 0x0

    .line 386
    .local v16, "totalBytesRead":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v18

    move-wide/from16 v32, v18

    .line 387
    .local v32, "startTime":J
    new-instance v9, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v9}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 389
    .local v9, "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    move/from16 p6, v3

    .end local v3    # "lastProgress":I
    .local p6, "lastProgress":I
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    move-wide/from16 v18, v7

    .end local v7    # "lastUpdateTime":J
    .local v18, "lastUpdateTime":J
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "downloadWithRetrofit \u5f00\u59cb\u4e0b\u8f7d\uff0c\u6587\u4ef6\u5f53\u524d\u5927\u5c0f: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    move-object/from16 v34, v9

    .end local v9    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v34, "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v8

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string/jumbo v8, "\u5b57\u8282, \u76ee\u6807\u603b\u5927\u5c0f: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 390
    nop

    .line 389
    invoke-virtual {v7, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 390
    const-string/jumbo v8, "\u5b57\u8282, \u5df2\u4e0b\u8f7d: "

    .line 389
    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 390
    iget-wide v8, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 389
    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 390
    const-string/jumbo v8, "\u5b57\u8282"

    .line 389
    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v3, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 392
    new-instance v3, Ljava/io/RandomAccessFile;

    const-string/jumbo v7, "rw"

    invoke-direct {v3, v6, v7}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    check-cast v3, Ljava/io/Closeable;
    :try_end_25
    .catchall {:try_start_25 .. :try_end_25} :catchall_17

    :try_start_26
    move-object v7, v3

    check-cast v7, Ljava/io/RandomAccessFile;
    :try_end_26
    .catchall {:try_start_26 .. :try_end_26} :catchall_14

    .local v7, "outputFileRAF":Ljava/io/RandomAccessFile;
    const/4 v8, 0x0

    .line 393
    .local v8, "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    move/from16 v35, v8

    const-wide/16 v8, 0x0

    .end local v8    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    .local v35, "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    cmp-long v20, v4, v8

    if-nez v20, :cond_18

    :try_start_27
    invoke-virtual {v7, v8, v9}, Ljava/io/RandomAccessFile;->setLength(J)V
    :try_end_27
    .catchall {:try_start_27 .. :try_end_27} :catchall_5

    goto :goto_f

    .line 392
    .end local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v4    # "downloadedSize":J
    .end local v6    # "outputFile":Ljava/io/File;
    .end local v7    # "outputFileRAF":Ljava/io/RandomAccessFile;
    .end local v10    # "totalBytes":J
    .end local v16    # "totalBytesRead":J
    .end local v18    # "lastUpdateTime":J
    .end local v32    # "startTime":J
    .end local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v35    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .end local p5    # "inputStream":Ljava/io/InputStream;
    .end local p6    # "lastProgress":I
    :catchall_5
    move-exception v0

    move-object v9, v12

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    const/4 v10, 0x1

    move-object v12, v1

    move-object v1, v0

    move-object/from16 v49, v14

    move-object v14, v13

    move-object/from16 v13, v49

    goto/16 :goto_1e

    .line 394
    .restart local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v4    # "downloadedSize":J
    .restart local v6    # "outputFile":Ljava/io/File;
    .restart local v7    # "outputFileRAF":Ljava/io/RandomAccessFile;
    .restart local v10    # "totalBytes":J
    .restart local v16    # "totalBytesRead":J
    .restart local v18    # "lastUpdateTime":J
    .restart local v32    # "startTime":J
    .restart local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v35    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local p5    # "inputStream":Ljava/io/InputStream;
    .restart local p6    # "lastProgress":I
    :cond_18
    :goto_f
    :try_start_28
    invoke-virtual {v7, v4, v5}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 395
    const v8, 0x8000

    new-array v8, v8, [B

    .line 396
    .local v8, "buffer":[B
    new-instance v9, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v9}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 398
    .local v9, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v20
    :try_end_28
    .catchall {:try_start_28 .. :try_end_28} :catchall_14

    .line 399
    .local v20, "lastSpeedTime":J
    move-wide/from16 v22, v4

    move-wide/from16 v4, v22

    move-wide/from16 v22, v20

    move-wide/from16 v20, v16

    move-wide/from16 v16, v4

    move/from16 v4, p6

    .line 402
    .end local p6    # "lastProgress":I
    .local v4, "lastProgress":I
    .local v16, "lastSpeedBytes":J
    .local v20, "totalBytesRead":J
    .local v22, "lastSpeedTime":J
    :goto_10
    move-object/from16 v5, p5

    move-object/from16 v36, v12

    .end local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local p5    # "inputStream":Ljava/io/InputStream;
    .local v5, "inputStream":Ljava/io/InputStream;
    .local v36, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :try_start_29
    invoke-virtual {v5, v8}, Ljava/io/InputStream;->read([B)I

    move-result v12

    move/from16 p5, v12

    .line 683
    .local p5, "it":I
    const/16 v24, 0x0

    .line 402
    .local v24, "$i$a$-also-OtaServiceImpl$downloadWithRetrofit$3$1$1":I
    move-object/from16 p6, v5

    move/from16 v5, p5

    .end local p5    # "it":I
    .local v5, "it":I
    .local p6, "inputStream":Ljava/io/InputStream;
    iput v5, v9, Lkotlin/jvm/internal/Ref$IntRef;->element:I
    :try_end_29
    .catchall {:try_start_29 .. :try_end_29} :catchall_13

    .end local v5    # "it":I
    .end local v24    # "$i$a$-also-OtaServiceImpl$downloadWithRetrofit$3$1$1":I
    const-string v5, " KB/s"

    move-object/from16 v37, v1

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v37, "$continuation":Lkotlin/coroutines/Continuation;
    const-string v1, "format(this, *args)"

    move-object/from16 v38, v14

    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v38, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    const-string v14, "%.2f"

    move-object/from16 p5, v3

    const/4 v3, -0x1

    if-eq v12, v3, :cond_1f

    .line 403
    :try_start_2a
    invoke-interface {v15}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v3

    if-eqz v3, :cond_1e

    .line 405
    iget v3, v9, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    const/4 v12, 0x0

    invoke-virtual {v7, v8, v12, v3}, Ljava/io/RandomAccessFile;->write([BII)V
    :try_end_2a
    .catchall {:try_start_2a .. :try_end_2a} :catchall_7

    .line 406
    move-object/from16 v39, v13

    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v39, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :try_start_2b
    iget-wide v12, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    iget v3, v9, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    move/from16 v24, v4

    .end local v4    # "lastProgress":I
    .local v24, "lastProgress":I
    int-to-long v3, v3

    add-long/2addr v12, v3

    iput-wide v12, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 407
    iget v3, v9, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    int-to-long v3, v3

    add-long v20, v20, v3

    .line 410
    const-wide/32 v3, 0x200000

    cmp-long v3, v20, v3

    if-ltz v3, :cond_1a

    .line 411
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v3

    const/4 v12, 0x0

    invoke-virtual {v3, v12}, Ljava/nio/channels/FileChannel;->force(Z)V

    .line 412
    const-wide/16 v3, 0x0

    .line 415
    .end local v20    # "totalBytesRead":J
    .local v3, "totalBytesRead":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v20

    .line 416
    .local v20, "now":J
    iget-wide v12, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    sub-long v12, v12, v16

    .line 417
    .end local v16    # "lastSpeedBytes":J
    .local v12, "deltaBytes":J
    move-wide/from16 v40, v3

    .end local v3    # "totalBytesRead":J
    .local v40, "totalBytesRead":J
    sub-long v3, v20, v22

    .line 419
    .end local v22    # "lastSpeedTime":J
    .local v3, "deltaTime":J
    const-wide/16 v16, 0x0

    cmp-long v22, v3, v16

    if-lez v22, :cond_19

    cmp-long v22, v12, v16

    if-lez v22, :cond_19

    .line 420
    move-object/from16 v42, v8

    .end local v8    # "buffer":[B
    .local v42, "buffer":[B
    long-to-float v8, v12

    const/high16 v16, 0x447a0000    # 1000.0f

    mul-float v8, v8, v16

    move-wide/from16 v16, v12

    .end local v12    # "deltaBytes":J
    .local v16, "deltaBytes":J
    long-to-float v12, v3

    div-float/2addr v8, v12

    const/high16 v12, 0x44800000    # 1024.0f

    div-float/2addr v8, v12

    .line 421
    .end local v3    # "deltaTime":J
    .end local v16    # "deltaBytes":J
    .local v8, "speedKBps":F
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "\u4e0b\u8f7d\u901f\u5ea6: "

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v8}, Lkotlin/coroutines/jvm/internal/Boxing;->boxFloat(F)Ljava/lang/Float;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    const/4 v13, 0x1

    invoke-static {v12, v13}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v12

    invoke-static {v14, v12}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v3, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_11

    .line 419
    .end local v42    # "buffer":[B
    .restart local v3    # "deltaTime":J
    .local v8, "buffer":[B
    .restart local v12    # "deltaBytes":J
    :cond_19
    move-object/from16 v42, v8

    move-wide/from16 v16, v12

    .line 425
    .end local v3    # "deltaTime":J
    .end local v8    # "buffer":[B
    .end local v12    # "deltaBytes":J
    .restart local v42    # "buffer":[B
    :goto_11
    iget-wide v3, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 426
    .local v3, "lastSpeedBytes":J
    move-wide/from16 v12, v20

    .local v12, "lastSpeedTime":J
    goto :goto_12

    .line 410
    .end local v3    # "lastSpeedBytes":J
    .end local v12    # "lastSpeedTime":J
    .end local v40    # "totalBytesRead":J
    .end local v42    # "buffer":[B
    .restart local v8    # "buffer":[B
    .local v16, "lastSpeedBytes":J
    .local v20, "totalBytesRead":J
    .restart local v22    # "lastSpeedTime":J
    :cond_1a
    move-object/from16 v42, v8

    .end local v8    # "buffer":[B
    .restart local v42    # "buffer":[B
    move-wide/from16 v3, v16

    move-wide/from16 v40, v20

    move-wide/from16 v12, v22

    .line 430
    .end local v16    # "lastSpeedBytes":J
    .end local v20    # "totalBytesRead":J
    .end local v22    # "lastSpeedTime":J
    .restart local v3    # "lastSpeedBytes":J
    .restart local v12    # "lastSpeedTime":J
    .restart local v40    # "totalBytesRead":J
    :goto_12
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v16

    move-wide/from16 v43, v16

    .line 431
    .local v43, "currentTime":J
    sub-long v16, v43, v18

    const-wide/16 v20, 0x12c

    cmp-long v1, v16, v20

    if-ltz v1, :cond_1c

    .line 432
    const-wide/16 v16, 0x0

    cmp-long v1, v10, v16

    if-lez v1, :cond_1b

    .line 435
    move-wide/from16 v45, v3

    .end local v3    # "lastSpeedBytes":J
    .local v45, "lastSpeedBytes":J
    iget-wide v3, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    invoke-static {v3, v4, v10, v11}, Lcom/rokid/security/phone/sdk/server/ota/OtaDownloadDeliveryKt;->streamingProgress(JJ)I

    move-result v1

    goto :goto_13

    .line 436
    .end local v45    # "lastSpeedBytes":J
    .restart local v3    # "lastSpeedBytes":J
    :cond_1b
    move-wide/from16 v45, v3

    .end local v3    # "lastSpeedBytes":J
    .restart local v45    # "lastSpeedBytes":J
    const/4 v1, 0x0

    .line 432
    :goto_13
    move-object/from16 v8, p3

    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .local v8, "progress":Lkotlin/jvm/internal/Ref$IntRef;
    iput v1, v8, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .line 438
    iget v1, v8, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    move/from16 v3, v24

    .end local v24    # "lastProgress":I
    .local v3, "lastProgress":I
    if-eq v1, v3, :cond_1d

    .line 439
    iget v1, v8, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    move v4, v1

    .line 440
    .end local v3    # "lastProgress":I
    .restart local v4    # "lastProgress":I
    move-wide/from16 v47, v43

    .line 441
    .end local v18    # "lastUpdateTime":J
    .local v47, "lastUpdateTime":J
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$3$1$2;

    const/16 v24, 0x0

    move-object/from16 v16, v3

    move-object/from16 v17, v15

    move-object/from16 v18, v8

    move-object/from16 v19, v2

    move-wide/from16 v20, v10

    move-object/from16 v22, v9

    move-object/from16 v23, v39

    invoke-direct/range {v16 .. v24}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$3$1$2;-><init>(Lkotlinx/coroutines/Job;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/jvm/internal/Ref$IntRef;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v19, v3

    check-cast v19, Lkotlin/jvm/functions/Function2;

    const/16 v20, 0x3

    const/16 v21, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    move-object/from16 v16, v1

    invoke-static/range {v16 .. v21}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;
    :try_end_2b
    .catchall {:try_start_2b .. :try_end_2b} :catchall_6

    move-object/from16 v3, p5

    move-object/from16 p5, p6

    move-object/from16 p3, v8

    move-wide/from16 v22, v12

    move-object/from16 v12, v36

    move-object/from16 v1, v37

    move-object/from16 v14, v38

    move-object/from16 v13, v39

    move-wide/from16 v20, v40

    move-object/from16 v8, v42

    move-wide/from16 v16, v45

    move-wide/from16 v18, v47

    goto/16 :goto_10

    .line 431
    .end local v4    # "lastProgress":I
    .end local v8    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v45    # "lastSpeedBytes":J
    .end local v47    # "lastUpdateTime":J
    .local v3, "lastSpeedBytes":J
    .restart local v18    # "lastUpdateTime":J
    .restart local v24    # "lastProgress":I
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_1c
    move-object/from16 v8, p3

    move-wide/from16 v45, v3

    move/from16 v3, v24

    .line 402
    .end local v24    # "lastProgress":I
    .end local v43    # "currentTime":J
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .local v3, "lastProgress":I
    .restart local v8    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v45    # "lastSpeedBytes":J
    :cond_1d
    move v4, v3

    move-object/from16 p3, v8

    move-wide/from16 v22, v12

    move-object/from16 v12, v36

    move-object/from16 v1, v37

    move-object/from16 v14, v38

    move-object/from16 v13, v39

    move-wide/from16 v20, v40

    move-object/from16 v8, v42

    move-wide/from16 v16, v45

    move-object/from16 v3, p5

    move-object/from16 p5, p6

    goto/16 :goto_10

    .line 392
    .end local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "lastProgress":I
    .end local v6    # "outputFile":Ljava/io/File;
    .end local v7    # "outputFileRAF":Ljava/io/RandomAccessFile;
    .end local v8    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v10    # "totalBytes":J
    .end local v12    # "lastSpeedTime":J
    .end local v18    # "lastUpdateTime":J
    .end local v32    # "startTime":J
    .end local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v35    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    .end local v40    # "totalBytesRead":J
    .end local v42    # "buffer":[B
    .end local v45    # "lastSpeedBytes":J
    .end local p6    # "inputStream":Ljava/io/InputStream;
    :catchall_6
    move-exception v0

    move-object/from16 v3, p5

    move-object v1, v0

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    const/4 v10, 0x1

    goto/16 :goto_1e

    .line 403
    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v4    # "lastProgress":I
    .restart local v6    # "outputFile":Ljava/io/File;
    .restart local v7    # "outputFileRAF":Ljava/io/RandomAccessFile;
    .local v8, "buffer":[B
    .restart local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v10    # "totalBytes":J
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v16    # "lastSpeedBytes":J
    .restart local v18    # "lastUpdateTime":J
    .restart local v20    # "totalBytesRead":J
    .restart local v22    # "lastSpeedTime":J
    .restart local v32    # "startTime":J
    .restart local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v35    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local p6    # "inputStream":Ljava/io/InputStream;
    :cond_1e
    move v3, v4

    move-object/from16 v42, v8

    move-object/from16 v39, v13

    move-object/from16 v8, p3

    .end local v4    # "lastProgress":I
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v3    # "lastProgress":I
    .local v8, "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v42    # "buffer":[B
    goto :goto_14

    .line 392
    .end local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "lastProgress":I
    .end local v6    # "outputFile":Ljava/io/File;
    .end local v7    # "outputFileRAF":Ljava/io/RandomAccessFile;
    .end local v8    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v10    # "totalBytes":J
    .end local v16    # "lastSpeedBytes":J
    .end local v18    # "lastUpdateTime":J
    .end local v20    # "totalBytesRead":J
    .end local v22    # "lastSpeedTime":J
    .end local v32    # "startTime":J
    .end local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v35    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v42    # "buffer":[B
    .end local p6    # "inputStream":Ljava/io/InputStream;
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :catchall_7
    move-exception v0

    move-object/from16 v39, v13

    move-object/from16 v3, p5

    move-object v1, v0

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    const/4 v10, 0x1

    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_1e

    .line 402
    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v4    # "lastProgress":I
    .restart local v6    # "outputFile":Ljava/io/File;
    .restart local v7    # "outputFileRAF":Ljava/io/RandomAccessFile;
    .local v8, "buffer":[B
    .restart local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v10    # "totalBytes":J
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v16    # "lastSpeedBytes":J
    .restart local v18    # "lastUpdateTime":J
    .restart local v20    # "totalBytesRead":J
    .restart local v22    # "lastSpeedTime":J
    .restart local v32    # "startTime":J
    .restart local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v35    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local p6    # "inputStream":Ljava/io/InputStream;
    :cond_1f
    move v3, v4

    move-object/from16 v42, v8

    move-object/from16 v39, v13

    move-object/from16 v8, p3

    .line 453
    .end local v4    # "lastProgress":I
    .end local v8    # "buffer":[B
    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v16    # "lastSpeedBytes":J
    .end local v18    # "lastUpdateTime":J
    .end local v20    # "totalBytesRead":J
    .end local v22    # "lastSpeedTime":J
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .end local p6    # "inputStream":Ljava/io/InputStream;
    .restart local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :goto_14
    :try_start_2c
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v3
    :try_end_2c
    .catchall {:try_start_2c .. :try_end_2c} :catchall_12

    const/4 v4, 0x1

    :try_start_2d
    invoke-virtual {v3, v4}, Ljava/nio/channels/FileChannel;->force(Z)V
    :try_end_2d
    .catchall {:try_start_2d .. :try_end_2d} :catchall_11

    .line 456
    .end local v7    # "outputFileRAF":Ljava/io/RandomAccessFile;
    :try_start_2e
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sub-long v3, v3, v32

    .line 457
    .end local v32    # "startTime":J
    .local v3, "totalTime":J
    sget-object v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "\u4e0b\u8f7d\u5b8c\u6210\uff0c\u603b\u8017\u65f6: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "ms, \u5e73\u5747\u901f\u5ea6: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v12

    long-to-double v12, v12

    const-wide v16, 0x408f400000000000L    # 1000.0

    mul-double v12, v12, v16

    move-wide/from16 v16, v10

    .end local v10    # "totalBytes":J
    .local v16, "totalBytes":J
    long-to-double v9, v3

    div-double/2addr v12, v9

    const/16 v9, 0x400

    int-to-double v9, v9

    div-double/2addr v12, v9

    invoke-static {v12, v13}, Lkotlin/coroutines/jvm/internal/Boxing;->boxDouble(D)Ljava/lang/Double;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9
    :try_end_2e
    .catchall {:try_start_2e .. :try_end_2e} :catchall_12

    const/4 v10, 0x1

    :try_start_2f
    invoke-static {v9, v10}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v9
    :try_end_2f
    .catchall {:try_start_2f .. :try_end_2f} :catchall_10

    :try_start_30
    invoke-static {v14, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .end local v3    # "totalTime":J
    .end local v6    # "outputFile":Ljava/io/File;
    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v7, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_30
    .catchall {:try_start_30 .. :try_end_30} :catchall_12

    .line 459
    const-wide/16 v3, 0x0

    cmp-long v1, v16, v3

    if-lez v1, :cond_21

    :try_start_31
    iget-wide v3, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J
    :try_end_31
    .catchall {:try_start_31 .. :try_end_31} :catchall_6

    cmp-long v1, v3, v16

    if-nez v1, :cond_20

    goto :goto_15

    :cond_20
    const/4 v11, 0x0

    goto :goto_16

    :cond_21
    :goto_15
    const/4 v11, 0x1

    :goto_16
    move v1, v11

    .line 460
    .local v1, "complete":Z
    nop

    .line 461
    :try_start_32
    invoke-interface {v15}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v3
    :try_end_32
    .catchall {:try_start_32 .. :try_end_32} :catchall_12

    if-eqz v3, :cond_22

    if-eqz v1, :cond_22

    .line 462
    .end local v1    # "complete":Z
    const/4 v1, 0x1

    :try_start_33
    invoke-static {v1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v3

    move-object/from16 v4, v34

    .end local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v4, "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    iput-object v3, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;
    :try_end_33
    .catchall {:try_start_33 .. :try_end_33} :catchall_6

    move-wide/from16 v5, v16

    goto :goto_17

    .line 461
    .end local v4    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v1    # "complete":Z
    .restart local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    :cond_22
    move-object/from16 v4, v34

    .line 465
    .end local v1    # "complete":Z
    .end local v34    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v4    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    :try_start_34
    invoke-interface {v15}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v1
    :try_end_34
    .catchall {:try_start_34 .. :try_end_34} :catchall_12

    const-string v3, " total="

    if-eqz v1, :cond_23

    .line 466
    :try_start_35
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "flow=ota src=phone stage=download event=incomplete bytes="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-wide v6, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-wide/from16 v5, v16

    .end local v16    # "totalBytes":J
    .local v5, "totalBytes":J
    invoke-virtual {v3, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 467
    const/4 v1, -0x1

    invoke-static {v1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v1

    iput-object v1, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;
    :try_end_35
    .catchall {:try_start_35 .. :try_end_35} :catchall_6

    goto :goto_17

    .line 471
    .end local v5    # "totalBytes":J
    .restart local v16    # "totalBytes":J
    :cond_23
    move-wide/from16 v5, v16

    .end local v16    # "totalBytes":J
    .restart local v5    # "totalBytes":J
    :try_start_36
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "flow=ota src=phone stage=download event=cancelled bytes="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-wide v8, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 474
    :goto_17
    nop

    .end local v35    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_36
    .catchall {:try_start_36 .. :try_end_36} :catchall_12

    .line 392
    move-object/from16 v3, p5

    const/4 v1, 0x0

    :try_start_37
    invoke-static {v3, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 475
    iget-object v1, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .end local v4    # "terminalStatus":Lkotlin/jvm/internal/Ref$ObjectRef;
    if-eqz v1, :cond_27

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v1

    .local v1, "status":I
    const/4 v3, 0x0

    .line 476
    .local v3, "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    sget-object v4, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_end_37
    .catchall {:try_start_37 .. :try_end_37} :catchall_f

    .line 477
    nop

    .line 478
    nop

    .line 479
    const/4 v7, 0x1

    if-ne v1, v7, :cond_24

    :try_start_38
    iget-wide v7, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    invoke-static {v7, v8}, Lkotlin/coroutines/jvm/internal/Boxing;->boxLong(J)Ljava/lang/Long;

    move-result-object v7
    :try_end_38
    .catchall {:try_start_38 .. :try_end_38} :catchall_8

    goto :goto_18

    .line 374
    .end local v1    # "status":I
    .end local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    .end local v5    # "totalBytes":J
    .end local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    :catchall_8
    move-exception v0

    move-object v1, v0

    move-object v5, v15

    move-object/from16 v7, v30

    move-object/from16 v6, v31

    move-object/from16 v4, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    const/4 v10, 0x1

    goto/16 :goto_22

    .line 479
    .restart local v1    # "status":I
    .restart local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v3    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    .restart local v5    # "totalBytes":J
    .restart local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    :cond_24
    const/4 v7, 0x0

    .line 480
    .end local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    :goto_18
    const/4 v10, 0x1

    if-ne v1, v10, :cond_25

    :try_start_39
    invoke-static {v5, v6}, Lkotlin/coroutines/jvm/internal/Boxing;->boxLong(J)Ljava/lang/Long;

    move-result-object v2
    :try_end_39
    .catchall {:try_start_39 .. :try_end_39} :catchall_9

    goto :goto_19

    .line 374
    .end local v1    # "status":I
    .end local v3    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    .end local v5    # "totalBytes":J
    .end local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    :catchall_9
    move-exception v0

    move-object v1, v0

    move-object v5, v15

    move-object/from16 v7, v30

    move-object/from16 v6, v31

    move-object/from16 v4, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    goto/16 :goto_22

    .line 480
    .restart local v3    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    .restart local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    :cond_25
    const/4 v2, 0x0

    .line 476
    :goto_19
    move-object/from16 v12, v37

    move-object/from16 v13, v38

    .end local v37    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v38    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :try_start_3a
    iput-object v13, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;
    :try_end_3a
    .catchall {:try_start_3a .. :try_end_3a} :catchall_e

    move-object/from16 v14, v39

    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :try_start_3b
    iput-object v14, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v15, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;
    :try_end_3b
    .catchall {:try_start_3b .. :try_end_3b} :catchall_d

    move-object/from16 v9, v36

    .end local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v9, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :try_start_3c
    iput-object v9, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;
    :try_end_3c
    .catchall {:try_start_3c .. :try_end_3c} :catchall_c

    move-object/from16 v8, v31

    :try_start_3d
    iput-object v8, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$4:Ljava/lang/Object;

    const/4 v5, 0x5

    iput v5, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    move-object/from16 p1, v4

    move-object/from16 p2, v14

    move/from16 p3, v1

    move-object/from16 p4, v7

    move-object/from16 p5, v2

    move-object/from16 p6, v12

    invoke-direct/range {p1 .. p6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1
    :try_end_3d
    .catchall {:try_start_3d .. :try_end_3d} :catchall_b

    move-object/from16 v7, v30

    if-ne v1, v7, :cond_26

    .line 299
    return-object v7

    .line 476
    :cond_26
    move v5, v3

    move-object v6, v8

    move-object v8, v15

    move/from16 v4, v29

    .line 482
    .end local v3    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .local v4, "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .local v5, "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    .local v8, "currentJob":Lkotlinx/coroutines/Job;
    :goto_1a
    nop

    .line 475
    .end local v5    # "$i$a$-let-OtaServiceImpl$downloadWithRetrofit$3$2":I
    :try_start_3e
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3e
    .catchall {:try_start_3e .. :try_end_3e} :catchall_a

    move-object v5, v8

    move-object v4, v9

    move-object v8, v6

    move-object v6, v14

    goto :goto_1b

    .line 374
    .end local v4    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    :catchall_a
    move-exception v0

    move-object v1, v0

    move-object v5, v8

    move-object v4, v9

    goto/16 :goto_22

    .end local v8    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catchall_b
    move-exception v0

    move-object/from16 v7, v30

    goto/16 :goto_1f

    :catchall_c
    move-exception v0

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    goto/16 :goto_1f

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catchall_d
    move-exception v0

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object v1, v0

    move-object v6, v8

    move-object v4, v9

    move-object v5, v15

    .end local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    goto/16 :goto_22

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :catchall_e
    move-exception v0

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object/from16 v14, v39

    move-object v1, v0

    move-object v6, v8

    move-object v4, v9

    move-object v5, v15

    .end local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_22

    .line 475
    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .local v5, "totalBytes":J
    .restart local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .restart local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v37    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v38    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :cond_27
    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    const/4 v10, 0x1

    .end local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v37    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v38    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    move-object v4, v9

    move-object v6, v14

    move-object v5, v15

    .line 374
    .end local v2    # "currentDownloaded":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .local v4, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v5, "currentJob":Lkotlinx/coroutines/Job;
    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :goto_1b
    const/4 v1, 0x0

    :try_start_3f
    invoke-static {v8, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_3f
    .catch Ljava/util/concurrent/CancellationException; {:try_start_3f .. :try_end_3f} :catch_1e
    .catch Ljava/net/SocketTimeoutException; {:try_start_3f .. :try_end_3f} :catch_1b
    .catch Ljava/lang/Exception; {:try_start_3f .. :try_end_3f} :catch_1a
    .catchall {:try_start_3f .. :try_end_3f} :catchall_21

    goto/16 :goto_25

    .line 508
    :catch_1a
    move-exception v0

    move-object v2, v0

    move-object v1, v4

    move-object v14, v6

    move-object v3, v7

    goto/16 :goto_28

    .line 491
    :catch_1b
    move-exception v0

    move-object v2, v0

    move-object v1, v4

    move-object v14, v6

    move-object v3, v7

    goto/16 :goto_2a

    .line 374
    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v37    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v38    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :catchall_f
    move-exception v0

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    const/4 v10, 0x1

    move-object v1, v0

    move-object v6, v8

    move-object v4, v9

    move-object v5, v15

    .end local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v37    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v38    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_22

    .line 392
    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .restart local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v37    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v38    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :catchall_10
    move-exception v0

    move-object/from16 v3, p5

    goto :goto_1c

    :catchall_11
    move-exception v0

    move-object/from16 v3, p5

    move v10, v4

    :goto_1c
    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    goto :goto_1d

    :catchall_12
    move-exception v0

    move-object/from16 v3, p5

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    move-object/from16 v12, v37

    move-object/from16 v13, v38

    move-object/from16 v14, v39

    const/4 v10, 0x1

    :goto_1d
    move-object v1, v0

    .end local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v37    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v38    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v39    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto :goto_1e

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catchall_13
    move-exception v0

    move-object v12, v1

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    move-object/from16 v9, v36

    const/4 v10, 0x1

    move-object/from16 v49, v14

    move-object v14, v13

    move-object/from16 v13, v49

    move-object v1, v0

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v36    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto :goto_1e

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catchall_14
    move-exception v0

    move-object v9, v12

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    const/4 v10, 0x1

    move-object v12, v1

    move-object/from16 v49, v14

    move-object v14, v13

    move-object/from16 v13, v49

    move-object v1, v0

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v26    # "$result":Ljava/lang/Object;
    .end local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    :goto_1e
    :try_start_40
    throw v1
    :try_end_40
    .catchall {:try_start_40 .. :try_end_40} :catchall_15

    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v26    # "$result":Ljava/lang/Object;
    .restart local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    :catchall_15
    move-exception v0

    move-object v2, v0

    :try_start_41
    invoke-static {v3, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v26    # "$result":Ljava/lang/Object;
    throw v2
    :try_end_41
    .catchall {:try_start_41 .. :try_end_41} :catchall_16

    .line 374
    .end local v29    # "$i$a$-use-OtaServiceImpl$downloadWithRetrofit$3":I
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v26    # "$result":Ljava/lang/Object;
    :catchall_16
    move-exception v0

    :goto_1f
    move-object v1, v0

    move-object v6, v8

    move-object v4, v9

    move-object v5, v15

    goto :goto_22

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catchall_17
    move-exception v0

    move-object v9, v12

    move-object/from16 v7, v30

    move-object/from16 v8, v31

    goto :goto_20

    :catchall_18
    move-exception v0

    move-object v9, v12

    move-object/from16 v7, v30

    goto :goto_20

    :catchall_19
    move-exception v0

    move-object v7, v2

    move-object v9, v12

    :goto_20
    const/4 v10, 0x1

    goto :goto_21

    :catchall_1a
    move-exception v0

    move-object v7, v2

    move-object v9, v12

    :goto_21
    move-object v12, v1

    move-object/from16 v49, v14

    move-object v14, v13

    move-object/from16 v13, v49

    move-object v1, v0

    move-object v6, v8

    move-object v4, v9

    move-object v5, v15

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v12    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v26    # "$result":Ljava/lang/Object;
    :goto_22
    :try_start_42
    throw v1
    :try_end_42
    .catchall {:try_start_42 .. :try_end_42} :catchall_1b

    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v26    # "$result":Ljava/lang/Object;
    :catchall_1b
    move-exception v0

    move-object v2, v0

    :try_start_43
    invoke-static {v6, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v26    # "$result":Ljava/lang/Object;
    throw v2
    :try_end_43
    .catch Ljava/util/concurrent/CancellationException; {:try_start_43 .. :try_end_43} :catch_1e
    .catch Ljava/net/SocketTimeoutException; {:try_start_43 .. :try_end_43} :catch_1d
    .catch Ljava/lang/Exception; {:try_start_43 .. :try_end_43} :catch_1c
    .catchall {:try_start_43 .. :try_end_43} :catchall_21

    .line 508
    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v26    # "$result":Ljava/lang/Object;
    :catch_1c
    move-exception v0

    move-object v2, v0

    move-object v1, v4

    move-object v3, v7

    goto/16 :goto_28

    .line 491
    :catch_1d
    move-exception v0

    move-object v2, v0

    move-object v1, v4

    move-object v3, v7

    goto/16 :goto_2a

    .line 489
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :catch_1e
    move-exception v0

    move-object v1, v0

    goto/16 :goto_30

    .line 491
    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_1f
    move-exception v0

    move-object v7, v2

    move-object v9, v12

    goto :goto_23

    .line 517
    .end local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catchall_1c
    move-exception v0

    move-object v9, v12

    move-object v12, v1

    move-object v1, v0

    move-object v4, v9

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    goto/16 :goto_31

    .line 508
    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v13    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v14    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_20
    move-exception v0

    move-object v7, v2

    move-object v9, v12

    move-object v12, v1

    move-object/from16 v49, v14

    move-object v14, v13

    move-object/from16 v13, v49

    move-object v2, v0

    move-object v3, v7

    move-object v1, v9

    move-object v5, v15

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_28

    .line 491
    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_21
    move-exception v0

    move-object v7, v2

    move-object v9, v12

    move/from16 v10, v16

    :goto_23
    move-object v12, v1

    move-object/from16 v49, v14

    move-object v14, v13

    move-object/from16 v13, v49

    move-object v2, v0

    move-object v3, v7

    move-object v1, v9

    move-object v5, v15

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_2a

    .line 489
    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_22
    move-exception v0

    move-object v9, v12

    move-object v12, v1

    move-object v1, v0

    move-object v4, v9

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    goto/16 :goto_30

    .line 366
    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v3, "response":Lokhttp3/Response;
    .local v4, "downloadedSize":J
    .local v6, "outputFile":Ljava/io/File;
    .restart local v11    # "statusCode":I
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_28
    move-object/from16 v8, p3

    move-object v7, v2

    move-object v9, v12

    move/from16 v10, v16

    move-object v12, v1

    move-object/from16 v49, v14

    move-object v14, v13

    move-object/from16 v13, v49

    .line 485
    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v4    # "downloadedSize":J
    .end local v6    # "outputFile":Ljava/io/File;
    .end local p3    # "progress":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :try_start_44
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u4e0b\u8f7d\u5931\u8d25\uff0cHTTP\u72b6\u6001\u7801: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .end local v11    # "statusCode":I
    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 486
    invoke-virtual {v3}, Lokhttp3/Response;->close()V

    .line 487
    .end local v3    # "response":Lokhttp3/Response;
    iput-object v13, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    iput-object v14, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v15, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    iput-object v9, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    const/4 v1, 0x6

    iput v1, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I
    :try_end_44
    .catch Ljava/util/concurrent/CancellationException; {:try_start_44 .. :try_end_44} :catch_28
    .catch Ljava/net/SocketTimeoutException; {:try_start_44 .. :try_end_44} :catch_27
    .catch Ljava/lang/Exception; {:try_start_44 .. :try_end_44} :catch_26
    .catchall {:try_start_44 .. :try_end_44} :catchall_1d

    const/4 v6, -0x1

    const/4 v1, 0x0

    const/4 v8, 0x0

    const/16 v2, 0xc

    const/4 v11, 0x0

    move-object v4, v13

    move-object v5, v14

    move-object v3, v7

    move-object v7, v1

    move-object v1, v9

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    move-object v9, v12

    move v10, v2

    :try_start_45
    invoke-static/range {v4 .. v11}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult$default(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v2
    :try_end_45
    .catch Ljava/util/concurrent/CancellationException; {:try_start_45 .. :try_end_45} :catch_25
    .catch Ljava/net/SocketTimeoutException; {:try_start_45 .. :try_end_45} :catch_24
    .catch Ljava/lang/Exception; {:try_start_45 .. :try_end_45} :catch_23
    .catchall {:try_start_45 .. :try_end_45} :catchall_20

    if-ne v2, v3, :cond_29

    .line 299
    return-object v3

    .line 487
    :cond_29
    move-object v4, v1

    move-object v7, v13

    move-object v6, v14

    move-object v5, v15

    .line 517
    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .local v4, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v7, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :goto_24
    nop

    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v7    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :goto_25
    nop

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v4, :cond_35

    goto/16 :goto_2f

    .line 508
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_23
    move-exception v0

    move-object v2, v0

    move-object v5, v15

    goto/16 :goto_28

    .line 491
    :catch_24
    move-exception v0

    move-object v2, v0

    move-object v5, v15

    goto/16 :goto_2a

    .line 489
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_25
    move-exception v0

    move-object v4, v1

    move-object v1, v0

    goto/16 :goto_30

    .line 517
    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catchall_1d
    move-exception v0

    move-object v1, v9

    move-object v4, v1

    move-object v1, v0

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    goto/16 :goto_31

    .line 508
    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_26
    move-exception v0

    move-object v3, v7

    move-object v1, v9

    move-object v2, v0

    move-object v5, v15

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    goto/16 :goto_28

    .line 491
    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_27
    move-exception v0

    move-object v3, v7

    move-object v1, v9

    move-object v2, v0

    move-object v5, v15

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    goto/16 :goto_2a

    .line 489
    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_28
    move-exception v0

    move-object v1, v9

    move-object v4, v1

    move-object v1, v0

    .end local v9    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    goto/16 :goto_30

    .line 508
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_29
    move-exception v0

    move-object v3, v2

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object/from16 v50, v14

    move-object v14, v13

    move-object/from16 v13, v50

    move-object v2, v0

    move-object v5, v15

    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_28

    .line 491
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v13, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v14, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    :catch_2a
    move-exception v0

    move-object v3, v2

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object/from16 v50, v14

    move-object v14, v13

    move-object/from16 v13, v50

    move-object v2, v0

    move-object v5, v15

    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .local v13, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v14, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_2a

    .line 508
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .local v7, "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v10, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_2b
    move-exception v0

    move-object v14, v7

    move-object v13, v10

    move-object/from16 v3, v27

    goto :goto_26

    .line 491
    :catch_2c
    move-exception v0

    move-object v14, v7

    move-object v13, v10

    move-object/from16 v3, v27

    goto :goto_27

    .line 517
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catchall_1e
    move-exception v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object v4, v1

    move-object v1, v0

    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    goto/16 :goto_31

    .line 508
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_2d
    move-exception v0

    move-object v14, v7

    move-object/from16 v28, v13

    move-object/from16 v3, v27

    move-object v13, v10

    :goto_26
    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object v2, v0

    move-object v5, v15

    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto :goto_28

    .line 491
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_2e
    move-exception v0

    move-object v14, v7

    move-object/from16 v28, v13

    move-object/from16 v3, v27

    move-object v13, v10

    :goto_27
    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object v2, v0

    move-object v5, v15

    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    goto/16 :goto_2a

    .line 489
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .local v12, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_2f
    move-exception v0

    move-object/from16 v49, v12

    move-object v12, v1

    move-object/from16 v1, v49

    move-object v4, v1

    move-object v1, v0

    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v12, "$continuation":Lkotlin/coroutines/Continuation;
    goto/16 :goto_30

    .line 517
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .local v16, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catchall_1f
    move-exception v0

    move-object v12, v1

    move-object v1, v0

    move-object/from16 v4, v16

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    goto/16 :goto_31

    .line 508
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    :catch_30
    move-exception v0

    move-object v12, v1

    move-object v14, v7

    move-object/from16 v28, v13

    move-object/from16 v3, v27

    move-object v13, v10

    move-object v2, v0

    move-object v5, v15

    move-object/from16 v1, v16

    .line 509
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v16    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v2, "e":Ljava/lang/Exception;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :goto_28
    :try_start_46
    invoke-interface {v5}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-nez v4, :cond_2b

    .line 510
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    filled-new-array/range {v28 .. v28}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 511
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_46
    .catchall {:try_start_46 .. :try_end_46} :catchall_20

    .line 517
    .end local v2    # "e":Ljava/lang/Exception;
    nop

    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v1, :cond_2a

    invoke-interface {v1}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 511
    :cond_2a
    return-object v3

    .line 513
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v2    # "e":Ljava/lang/Exception;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :cond_2b
    :try_start_47
    sget-object v4, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    const-string v5, "downloadWithRetrofit \u4e0b\u8f7d\u5f02\u5e38 1 "

    filled-new-array {v5, v2}, [Ljava/lang/Object;

    move-result-object v5

    .end local v2    # "e":Ljava/lang/Exception;
    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 515
    iput-object v1, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    const/4 v2, 0x0

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$4:Ljava/lang/Object;

    const/16 v2, 0x8

    iput v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    const/4 v6, -0x1

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/16 v10, 0xc

    const/4 v11, 0x0

    move-object v4, v13

    move-object v5, v14

    move-object v9, v12

    invoke-static/range {v4 .. v11}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult$default(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    if-ne v2, v3, :cond_2c

    .line 299
    return-object v3

    .line 515
    :cond_2c
    move-object v4, v1

    .line 517
    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :goto_29
    nop

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v4, :cond_35

    goto/16 :goto_2f

    .line 491
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .restart local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v16    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_31
    move-exception v0

    move-object v12, v1

    move-object v14, v7

    move-object/from16 v28, v13

    move-object/from16 v3, v27

    move-object v13, v10

    move-object v2, v0

    move-object v5, v15

    move-object/from16 v1, v16

    .line 492
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .end local v10    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v15    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v16    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v1, "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v2, "e":Ljava/net/SocketTimeoutException;
    .restart local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :goto_2a
    invoke-interface {v5}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-nez v4, :cond_2e

    .line 493
    .end local v5    # "currentJob":Lkotlinx/coroutines/Job;
    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    filled-new-array/range {v28 .. v28}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 494
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_47
    .catchall {:try_start_47 .. :try_end_47} :catchall_20

    .line 517
    .end local v2    # "e":Ljava/net/SocketTimeoutException;
    nop

    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v1, :cond_2d

    invoke-interface {v1}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 494
    :cond_2d
    return-object v3

    .line 496
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v2    # "e":Ljava/net/SocketTimeoutException;
    .restart local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .restart local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :cond_2e
    :try_start_48
    sget-object v4, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    const-string v5, "downloadWithRetrofit \u4e0b\u8f7d\u8d85\u65f6\u5f02\u5e38"

    filled-new-array {v5, v2}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 499
    nop

    .line 500
    invoke-virtual {v2}, Ljava/net/SocketTimeoutException;->getMessage()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_2f

    check-cast v4, Ljava/lang/CharSequence;

    const-string v5, "connect"

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x1

    invoke-static {v4, v5, v6}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v4

    if-ne v4, v6, :cond_30

    move v11, v6

    goto :goto_2b

    :cond_2f
    const/4 v6, 0x1

    :cond_30
    const/4 v11, 0x0

    :goto_2b
    if-eqz v11, :cond_31

    const-string/jumbo v4, "\u8fde\u63a5\u8d85\u65f6"

    goto :goto_2d

    .line 501
    :cond_31
    invoke-virtual {v2}, Ljava/net/SocketTimeoutException;->getMessage()Ljava/lang/String;

    move-result-object v4

    .end local v2    # "e":Ljava/net/SocketTimeoutException;
    if-eqz v4, :cond_32

    check-cast v4, Ljava/lang/CharSequence;

    const-string v2, "read"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v4, v2, v6}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v2

    if-ne v2, v6, :cond_32

    move/from16 v25, v6

    goto :goto_2c

    :cond_32
    const/16 v25, 0x0

    :goto_2c
    if-eqz v25, :cond_33

    const-string/jumbo v4, "\u8bfb\u53d6\u8d85\u65f6"

    goto :goto_2d

    .line 502
    :cond_33
    const-string/jumbo v4, "\u7f51\u7edc\u8d85\u65f6"

    .line 499
    :goto_2d
    move-object v2, v4

    .line 505
    .local v2, "timeoutType":Ljava/lang/String;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u8d85\u65f6\u7c7b\u578b: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    .end local v2    # "timeoutType":Ljava/lang/String;
    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 507
    iput-object v1, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$0:Ljava/lang/Object;

    const/4 v2, 0x0

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$1:Ljava/lang/Object;

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$2:Ljava/lang/Object;

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$3:Ljava/lang/Object;

    iput-object v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->L$4:Ljava/lang/Object;

    const/4 v2, 0x7

    iput v2, v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$downloadWithRetrofit$1;->label:I

    const/4 v6, -0x1

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/16 v10, 0xc

    const/4 v11, 0x0

    move-object v4, v13

    move-object v5, v14

    move-object v9, v12

    invoke-static/range {v4 .. v11}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->dispatchDownloadResult$default(Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;ILjava/lang/Long;Ljava/lang/Long;Lkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v2
    :try_end_48
    .catchall {:try_start_48 .. :try_end_48} :catchall_20

    .end local v13    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
    .end local v14    # "listener":Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    if-ne v2, v3, :cond_34

    .line 299
    return-object v3

    .line 507
    :cond_34
    move-object v4, v1

    .line 517
    .end local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :goto_2e
    nop

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    if-eqz v4, :cond_35

    :goto_2f
    invoke-interface {v4}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 518
    :cond_35
    nop

    .line 519
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    .line 517
    .restart local v1    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catchall_20
    move-exception v0

    move-object v4, v1

    move-object v1, v0

    goto :goto_31

    .line 489
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v16    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :catch_32
    move-exception v0

    move-object v12, v1

    move-object v1, v0

    move-object/from16 v4, v16

    .line 490
    .end local v16    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .local v1, "e":Ljava/util/concurrent/CancellationException;
    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    :goto_30
    nop

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .end local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v26    # "$result":Ljava/lang/Object;
    :try_start_49
    throw v1
    :try_end_49
    .catchall {:try_start_49 .. :try_end_49} :catchall_21

    .line 517
    .end local v1    # "e":Ljava/util/concurrent/CancellationException;
    .restart local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    .restart local v12    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v26    # "$result":Ljava/lang/Object;
    :catchall_21
    move-exception v0

    move-object v1, v0

    .end local v4    # "cancellationHandle":Lkotlinx/coroutines/DisposableHandle;
    :goto_31
    if-eqz v4, :cond_36

    invoke-interface {v4}, Lkotlinx/coroutines/DisposableHandle;->dispose()V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    :cond_36
    throw v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final getDownloadClient()Lokhttp3/OkHttpClient;
    .locals 1

    .line 50
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadClient$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/OkHttpClient;

    return-object v0
.end method


# virtual methods
.method public cancelDownload()V
    .locals 3

    .line 678
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 679
    :cond_0
    return-void
.end method

.method public checkUpdate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .locals 3
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "osType"    # Ljava/lang/String;
    .param p3, "cpuType"    # Ljava/lang/String;
    .param p4, "deviceId"    # Ljava/lang/String;
    .param p5, "deviceTypeId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
            ">;"
        }
    .end annotation

    const-string/jumbo v0, "version"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "osType"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "cpuType"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "deviceId"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "deviceTypeId"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 260
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "checkUpdate:"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 262
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-lez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    if-eqz v0, :cond_1

    .line 263
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->setVersion(Ljava/lang/String;)V

    .line 265
    :cond_1
    move-object v0, p4

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_2

    move v0, v1

    goto :goto_1

    :cond_2
    move v0, v2

    :goto_1
    if-eqz v0, :cond_3

    .line 266
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    invoke-virtual {v0, p4}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->setDevice_id(Ljava/lang/String;)V

    .line 268
    :cond_3
    move-object v0, p5

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_4

    goto :goto_2

    :cond_4
    move v1, v2

    :goto_2
    if-eqz v1, :cond_5

    .line 269
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    invoke-virtual {v0, p5}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->setDeviceTypeId(Ljava/lang/String;)V

    .line 272
    :cond_5
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->mOtaRepository:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->otaCheck(Lcom/rokid/security/sdk/base/common/ota/SystemInfo;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v0

    return-object v0
.end method

.method public final getDownloadJob()Lkotlinx/coroutines/Job;
    .locals 1

    .line 45
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public final getMOtaRepository()Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;
    .locals 1

    .line 43
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->mOtaRepository:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;

    return-object v0
.end method

.method public final getSystemInfo()Lcom/rokid/security/sdk/base/common/ota/SystemInfo;
    .locals 1

    .line 42
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    return-object v0
.end method

.method public final getTAG()Ljava/lang/String;
    .locals 1

    .line 47
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public otaDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
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

    .line 594
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "otaDownload: "

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

    .line 595
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 596
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;

    invoke-direct {v0, p1, p3, p2, v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;-><init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v6, v0

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    .line 675
    return-void
.end method

.method public otaDownloadWithResume(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;J)V
    .locals 18
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "path"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    .param p4, "downloadedSize"    # J

    move-object/from16 v7, p2

    const-string/jumbo v0, "url"

    move-object/from16 v8, p1

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "path"

    invoke-static {v7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    move-object/from16 v9, p3

    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 281
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "otaDownloadWithResume: \u4ece "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-wide/from16 v10, p4

    invoke-virtual {v1, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " \u5b57\u8282\u5f00\u59cb\u4e0b\u8f7d, path: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 283
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 284
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v12

    new-instance v13, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;

    const/4 v6, 0x0

    move-object v0, v13

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-wide/from16 v4, p4

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownloadWithResume$1;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;JLkotlin/coroutines/Continuation;)V

    move-object v15, v13

    check-cast v15, Lkotlin/jvm/functions/Function2;

    const/16 v16, 0x3

    const/16 v17, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    invoke-static/range {v12 .. v17}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    .line 294
    return-void
.end method

.method public final setDownloadJob(Lkotlinx/coroutines/Job;)V
    .locals 0
    .param p1, "<set-?>"    # Lkotlinx/coroutines/Job;

    .line 45
    sput-object p1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->downloadJob:Lkotlinx/coroutines/Job;

    return-void
.end method

.method public final setMOtaRepository(Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    sput-object p1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->mOtaRepository:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;

    return-void
.end method

.method public final setSystemInfo(Lcom/rokid/security/sdk/base/common/ota/SystemInfo;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    sput-object p1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->systemInfo:Lcom/rokid/security/sdk/base/common/ota/SystemInfo;

    return-void
.end method

.method public final setTAG(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    sput-object p1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->TAG:Ljava/lang/String;

    return-void
.end method
