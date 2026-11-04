.class public final Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;
.super Ljava/lang/Object;
.source "MinioCoreUtil.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\\\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0018\u0010\u0013\u001a\u00020\u00142\u0006\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u0017\u001a\u00020\u0016H\u0002J\u0089\u0001\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u00042\u0006\u0010\u001b\u001a\u00020\u00042\u0006\u0010\u001c\u001a\u00020\u00042\u0006\u0010\u001d\u001a\u00020\u00042\u001e\u0010\u001e\u001a\u001a\u0012\u0004\u0012\u00020\u0016\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020 0\u001f26\u0010!\u001a2\u0012\u0013\u0012\u00110\u0014\u00a2\u0006\u000c\u0008#\u0012\u0008\u0008$\u0012\u0004\u0008\u0008(%\u0012\u0013\u0012\u00110\u0004\u00a2\u0006\u000c\u0008#\u0012\u0008\u0008$\u0012\u0004\u0008\u0008(&\u0012\u0004\u0012\u00020 0\"H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\'J\u0083\u0001\u0010(\u001a\u00020 2\u0006\u0010)\u001a\u00020*2\u0006\u0010\u001d\u001a\u00020\u00042\u001e\u0010\u001e\u001a\u001a\u0012\u0004\u0012\u00020\u0016\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020 0\u001f26\u0010!\u001a2\u0012\u0013\u0012\u00110\u0014\u00a2\u0006\u000c\u0008#\u0012\u0008\u0008$\u0012\u0004\u0008\u0008(%\u0012\u0013\u0012\u00110\u0004\u00a2\u0006\u000c\u0008#\u0012\u0008\u0008$\u0012\u0004\u0008\u0008(&\u0012\u0004\u0012\u00020 0\"2\u0008\u0008\u0002\u0010+\u001a\u00020\u0019H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010,R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0005\u001a\u00020\u0006X\u0086.\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008\"\u0004\u0008\t\u0010\nR\u001a\u0010\u000b\u001a\u00020\u000cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u000e\"\u0004\u0008\u000f\u0010\u0010R\u000e\u0010\u0011\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006-"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;",
        "",
        "()V",
        "TAG",
        "",
        "client",
        "Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;",
        "getClient",
        "()Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;",
        "setClient",
        "(Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;)V",
        "executor",
        "Ljava/util/concurrent/ExecutorService;",
        "getExecutor",
        "()Ljava/util/concurrent/ExecutorService;",
        "setExecutor",
        "(Ljava/util/concurrent/ExecutorService;)V",
        "okHttpClient",
        "Lokhttp3/OkHttpClient;",
        "calculateTotalParts",
        "",
        "fileSize",
        "",
        "partSize",
        "startUploadFile",
        "",
        "bucketName",
        "objectName",
        "region",
        "filePath",
        "onUploadComplate",
        "Lkotlin/Function3;",
        "",
        "onUploadFail",
        "Lkotlin/Function2;",
        "Lkotlin/ParameterName;",
        "name",
        "code",
        "errMsg",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "uploadFile",
        "ossInitInfo",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
        "isLog",
        "(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

.field private static final TAG:Ljava/lang/String;

.field public static client:Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

.field private static executor:Ljava/util/concurrent/ExecutorService;

.field private static okHttpClient:Lokhttp3/OkHttpClient;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    .line 21
    const-string v0, "MinioCoreUtil"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->TAG:Ljava/lang/String;

    .line 24
    const/4 v0, 0x3

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    const-string v1, "newFixedThreadPool(3)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->executor:Ljava/util/concurrent/ExecutorService;

    .line 25
    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;->getInstance()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getMinioClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->okHttpClient:Lokhttp3/OkHttpClient;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 20
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method private final calculateTotalParts(JJ)I
    .locals 4
    .param p1, "fileSize"    # J
    .param p3, "partSize"    # J

    .line 170
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    add-long v0, p1, p3

    const-wide/16 v2, 0x1

    sub-long/2addr v0, v2

    div-long/2addr v0, p3

    long-to-int v0, v0

    :goto_0
    return v0
.end method

.method public static synthetic uploadFile$default(Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;ZLkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 7

    .line 26
    and-int/lit8 p7, p7, 0x10

    if-eqz p7, :cond_0

    const/4 p5, 0x0

    :cond_0
    move v5, p5

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->uploadFile(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final getClient()Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;
    .locals 1

    .line 23
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->client:Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    const-string v0, "client"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public final getExecutor()Ljava/util/concurrent/ExecutorService;
    .locals 1

    .line 24
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->executor:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method public final setClient(Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    sput-object p1, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->client:Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

    return-void
.end method

.method public final setExecutor(Ljava/util/concurrent/ExecutorService;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/util/concurrent/ExecutorService;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    sput-object p1, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->executor:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method public final startUploadFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 10
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "filePath"    # Ljava/lang/String;
    .param p5, "onUploadComplate"    # Lkotlin/jvm/functions/Function3;
    .param p6, "onUploadFail"    # Lkotlin/jvm/functions/Function2;
    .param p7, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function3<",
            "-",
            "Ljava/lang/Long;",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 59
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v9, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;

    const/4 v8, 0x0

    move-object v1, v9

    move-object v2, p4

    move-object/from16 v3, p6

    move-object v4, p2

    move-object v5, p1

    move-object v6, p3

    move-object v7, p5

    invoke-direct/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;-><init>(Ljava/lang/String;Lkotlin/jvm/functions/Function2;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/jvm/functions/Function2;

    move-object/from16 v1, p7

    invoke-static {v0, v9, v1}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    .line 164
    return-object v0
.end method

.method public final uploadFile(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 11
    .param p1, "ossInitInfo"    # Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "onUploadComplate"    # Lkotlin/jvm/functions/Function3;
    .param p4, "onUploadFail"    # Lkotlin/jvm/functions/Function2;
    .param p5, "isLog"    # Z
    .param p6, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function3<",
            "-",
            "Ljava/lang/Long;",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;Z",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 27
    move-object v8, p2

    new-instance v0, Lio/minio/credentials/StaticProvider;

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getAccessKeyId()Ljava/lang/String;

    move-result-object v1

    .line 28
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getAccessKeySecret()Ljava/lang/String;

    move-result-object v2

    .line 29
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getSecurityToken()Ljava/lang/String;

    move-result-object v3

    .line 27
    invoke-direct {v0, v1, v2, v3}, Lio/minio/credentials/StaticProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object v9, v0

    .line 30
    .local v9, "provider":Lio/minio/credentials/StaticProvider;
    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

    .line 32
    invoke-static {}, Lio/minio/MinioAsyncClient;->builder()Lio/minio/MinioAsyncClient$Builder;

    move-result-object v1

    .line 33
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getEndpoint()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lio/minio/MinioAsyncClient$Builder;->endpoint(Ljava/lang/String;)Lio/minio/MinioAsyncClient$Builder;

    move-result-object v1

    .line 34
    move-object v2, v9

    check-cast v2, Lio/minio/credentials/Provider;

    invoke-virtual {v1, v2}, Lio/minio/MinioAsyncClient$Builder;->credentialsProvider(Lio/minio/credentials/Provider;)Lio/minio/MinioAsyncClient$Builder;

    move-result-object v1

    .line 35
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->okHttpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v1, v2}, Lio/minio/MinioAsyncClient$Builder;->httpClient(Lokhttp3/OkHttpClient;)Lio/minio/MinioAsyncClient$Builder;

    move-result-object v1

    .line 36
    invoke-virtual {v1}, Lio/minio/MinioAsyncClient$Builder;->build()Lio/minio/MinioAsyncClient;

    move-result-object v1

    .line 30
    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;-><init>(Lio/minio/MinioAsyncClient;)V

    move-object v10, p0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->setClient(Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;)V

    .line 39
    const-string/jumbo v0, "this as java.lang.String).substring(startIndex)"

    if-eqz p5, :cond_0

    .line 40
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v2, v8

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v6, 0x6

    const/4 v7, 0x0

    const-string v3, "/"

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {p2, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v2, v0

    goto :goto_0

    .line 42
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p2}, Lcom/rokid/utils/MD5Util;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v2, v8

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v6, 0x6

    const/4 v7, 0x0

    const-string v3, "."

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v2

    invoke-virtual {p2, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v2, v0

    .line 39
    :goto_0
    nop

    .line 45
    .local v2, "objectKey":Ljava/lang/String;
    nop

    .line 46
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getBucket()Ljava/lang/String;

    move-result-object v1

    .line 47
    nop

    .line 48
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getRegion()Ljava/lang/String;

    move-result-object v3

    .line 45
    move-object v0, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    move-object/from16 v7, p6

    invoke-virtual/range {v0 .. v7}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->startUploadFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    if-ne v0, v1, :cond_1

    return-object v0

    :cond_1
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 50
    return-object v0
.end method
