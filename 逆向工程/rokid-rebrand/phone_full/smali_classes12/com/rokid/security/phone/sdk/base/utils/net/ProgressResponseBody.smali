.class public final Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;
.super Lokhttp3/ResponseBody;
.source "ProgressResponseBody.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00004\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0018\u00002\u00020\u0001B\u001d\u0012\u0006\u0010\u0002\u001a\u00020\u0001\u0012\u0006\u0010\u0003\u001a\u00020\u0004\u0012\u0006\u0010\u0005\u001a\u00020\u0006\u00a2\u0006\u0002\u0010\u0007J\u0008\u0010\n\u001a\u00020\u000bH\u0016J\n\u0010\u000c\u001a\u0004\u0018\u00010\rH\u0016J\u0010\u0010\u000e\u001a\u00020\t2\u0006\u0010\u000f\u001a\u00020\u0010H\u0002J\u0008\u0010\u000f\u001a\u00020\tH\u0016R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;",
        "Lokhttp3/ResponseBody;",
        "originalBody",
        "listener",
        "Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;",
        "scope",
        "Lkotlinx/coroutines/CoroutineScope;",
        "(Lokhttp3/ResponseBody;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;Lkotlinx/coroutines/CoroutineScope;)V",
        "bufferedSource",
        "Lokio/BufferedSource;",
        "contentLength",
        "",
        "contentType",
        "Lokhttp3/MediaType;",
        "createSource",
        "source",
        "Lokio/Source;",
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


# instance fields
.field private bufferedSource:Lokio/BufferedSource;

.field private final listener:Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

.field private final originalBody:Lokhttp3/ResponseBody;

.field private final scope:Lkotlinx/coroutines/CoroutineScope;


# direct methods
.method public constructor <init>(Lokhttp3/ResponseBody;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;Lkotlinx/coroutines/CoroutineScope;)V
    .locals 1
    .param p1, "originalBody"    # Lokhttp3/ResponseBody;
    .param p2, "listener"    # Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;
    .param p3, "scope"    # Lkotlinx/coroutines/CoroutineScope;

    const-string v0, "originalBody"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "scope"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    invoke-direct {p0}, Lokhttp3/ResponseBody;-><init>()V

    .line 23
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->originalBody:Lokhttp3/ResponseBody;

    .line 24
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->listener:Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    .line 25
    iput-object p3, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->scope:Lkotlinx/coroutines/CoroutineScope;

    .line 22
    return-void
.end method

.method public static final synthetic access$getListener$p(Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;)Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    .line 22
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->listener:Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    return-object v0
.end method

.method public static final synthetic access$getScope$p(Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;)Lkotlinx/coroutines/CoroutineScope;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    .line 22
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->scope:Lkotlinx/coroutines/CoroutineScope;

    return-object v0
.end method

.method private final createSource(Lokio/Source;)Lokio/BufferedSource;
    .locals 3
    .param p1, "source"    # Lokio/Source;

    .line 43
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;

    invoke-direct {v0, p1, p0}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;-><init>(Lokio/Source;Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;)V

    .line 75
    .local v0, "progressSource":Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody$createSource$progressSource$1;
    move-object v1, v0

    check-cast v1, Lokio/Source;

    invoke-static {v1}, Lokio/Okio;->buffer(Lokio/Source;)Lokio/BufferedSource;

    move-result-object v1

    const-string v2, "buffer(progressSource)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v1
.end method


# virtual methods
.method public contentLength()J
    .locals 2

    .line 32
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->originalBody:Lokhttp3/ResponseBody;

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v0

    return-wide v0
.end method

.method public contentType()Lokhttp3/MediaType;
    .locals 1

    .line 31
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->originalBody:Lokhttp3/ResponseBody;

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->contentType()Lokhttp3/MediaType;

    move-result-object v0

    return-object v0
.end method

.method public source()Lokio/BufferedSource;
    .locals 2

    .line 35
    const-string/jumbo v0, "source->"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ProgressResponseBody"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 36
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->bufferedSource:Lokio/BufferedSource;

    if-nez v0, :cond_0

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->originalBody:Lokhttp3/ResponseBody;

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->source()Lokio/BufferedSource;

    move-result-object v0

    const-string v1, "originalBody.source()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Lokio/Source;

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->createSource(Lokio/Source;)Lokio/BufferedSource;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->bufferedSource:Lokio/BufferedSource;

    .line 39
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;->bufferedSource:Lokio/BufferedSource;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    return-object v0
.end method
