.class public final Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;
.super Ljava/lang/Object;
.source "MinioHttpLoggingInterceptor.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMinioHttpLoggingInterceptor.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MinioHttpLoggingInterceptor.kt\ncom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n*L\n1#1,102:1\n1#2:103\n1#2:114\n11653#3,9:104\n13579#3:113\n13580#3:115\n11662#3:116\n*S KotlinDebug\n*F\n+ 1 MinioHttpLoggingInterceptor.kt\ncom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor\n*L\n78#1:114\n78#1:104,9\n78#1:113\n78#1:115\n78#1:116\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000P\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0011\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\t\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\r\u001a\u00020\u000eJ\u0018\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u0014H\u0002J\u0010\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u0011\u001a\u00020\u0012H\u0002J\u0018\u0010\u0017\u001a\u00020\u00162\u0006\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0007H\u0002J\u0010\u0010\u001b\u001a\u00020\t2\u0006\u0010\u001c\u001a\u00020\tH\u0002J\u0010\u0010\u001d\u001a\u00020\t2\u0006\u0010\u001e\u001a\u00020\tH\u0002J\u0018\u0010\u001f\u001a\u00020\t2\u0006\u0010 \u001a\u00020\t2\u0006\u0010!\u001a\u00020\u0004H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082T\u00a2\u0006\u0002\n\u0000R\u0016\u0010\n\u001a\u0008\u0012\u0004\u0012\u00020\t0\u000bX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000c\u00a8\u0006\""
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;",
        "",
        "()V",
        "MAX_FALLBACK_XML_LEN",
        "",
        "MAX_FIELD_LEN",
        "PEEK_BODY_BYTES",
        "",
        "TAG",
        "",
        "XML_KEY_TAGS",
        "",
        "[Ljava/lang/String;",
        "create",
        "Lokhttp3/Interceptor;",
        "isLikelyBinaryUpload",
        "",
        "request",
        "Lokhttp3/Request;",
        "body",
        "Lokhttp3/RequestBody;",
        "logRequest",
        "",
        "logResponse",
        "response",
        "Lokhttp3/Response;",
        "tookMs",
        "redactUrl",
        "url",
        "summarizeXml",
        "xml",
        "truncate",
        "value",
        "max",
        "sdk-common-ability_release"
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

.field private static final MAX_FALLBACK_XML_LEN:I = 0x118

.field private static final MAX_FIELD_LEN:I = 0x60

.field private static final PEEK_BODY_BYTES:J = 0x1000L

.field private static final TAG:Ljava/lang/String; = "MinioOkHttp"

.field private static final XML_KEY_TAGS:[Ljava/lang/String;


# direct methods
.method public static synthetic $r8$lambda$pkLYi0MwFI4AlgoQN-QEcNcsoAs(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->create$lambda$0(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

    .line 18
    nop

    .line 19
    const/16 v0, 0x8

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "UploadId"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "Key"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "Bucket"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "ETag"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "Location"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "Code"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "Message"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "RequestId"

    aput-object v2, v0, v1

    .line 18
    sput-object v0, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->XML_KEY_TAGS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final create$lambda$0(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 8
    .param p0, "chain"    # Lokhttp3/Interceptor$Chain;

    .line 23
    invoke-interface {p0}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v0

    .line 24
    .local v0, "request":Lokhttp3/Request;
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v1

    .line 25
    .local v1, "startNs":J
    sget-object v3, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

    const-string v4, "request"

    invoke-static {v0, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v3, v0}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->logRequest(Lokhttp3/Request;)V

    .line 26
    invoke-interface {p0, v0}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v3

    .line 27
    .local v3, "response":Lokhttp3/Response;
    sget-object v4, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

    const-string v5, "response"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v5, Ljava/util/concurrent/TimeUnit;->NANOSECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v6

    sub-long/2addr v6, v1

    invoke-virtual {v5, v6, v7}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v5

    invoke-direct {v4, v3, v5, v6}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->logResponse(Lokhttp3/Response;J)V

    .line 28
    return-object v3
.end method

.method private final isLikelyBinaryUpload(Lokhttp3/Request;Lokhttp3/RequestBody;)Z
    .locals 7
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "body"    # Lokhttp3/RequestBody;

    .line 67
    invoke-virtual {p1}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v0

    const-string v1, "request.method()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "this as java.lang.String).toUpperCase(Locale.ROOT)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    .local v0, "method":Ljava/lang/String;
    const-string v1, "PUT"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_0

    const-string v2, "POST"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    return v3

    .line 69
    :cond_0
    invoke-virtual {p1}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v2

    .line 70
    .local v2, "path":Ljava/lang/String;
    const-string v4, "path"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    const-string/jumbo v5, "uploadId="

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v6, 0x1

    invoke-static {v4, v5, v6}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    return v6

    .line 71
    :cond_1
    invoke-virtual {p2}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lokhttp3/MediaType;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_2
    const/4 v1, 0x0

    :goto_0
    if-nez v1, :cond_3

    const-string v1, ""

    .line 72
    .local v1, "type":Ljava/lang/String;
    :cond_3
    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    const-string v5, "octet-stream"

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v4, v5, v6}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v4

    if-nez v4, :cond_4

    .line 73
    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    const-string v5, "image/"

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v4, v5, v6}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v4

    if-nez v4, :cond_4

    .line 74
    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    const-string/jumbo v5, "video/"

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v4, v5, v6}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v4

    if-eqz v4, :cond_5

    :cond_4
    move v3, v6

    .line 72
    :cond_5
    return v3
.end method

.method private final logRequest(Lokhttp3/Request;)V
    .locals 8
    .param p1, "request"    # Lokhttp3/Request;

    .line 32
    invoke-virtual {p1}, Lokhttp3/Request;->body()Lokhttp3/RequestBody;

    move-result-object v0

    .line 33
    .local v0, "body":Lokhttp3/RequestBody;
    nop

    .line 34
    if-nez v0, :cond_0

    const-string v1, "no body"

    goto/16 :goto_0

    .line 35
    :cond_0
    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-gez v1, :cond_1

    const-string v1, "body (chunked)"

    goto/16 :goto_0

    .line 36
    :cond_1
    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v1

    cmp-long v1, v1, v3

    if-nez v1, :cond_2

    const-string v1, "empty body"

    goto/16 :goto_0

    .line 37
    :cond_2
    invoke-direct {p0, p1, v0}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->isLikelyBinaryUpload(Lokhttp3/Request;Lokhttp3/RequestBody;)Z

    move-result v1

    const-string v2, "body omitted size="

    const-string v3, " type="

    if-eqz v1, :cond_3

    .line 38
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    .line 39
    :cond_3
    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v4

    const-wide/16 v6, 0x1000

    cmp-long v1, v4, v6

    if-lez v1, :cond_4

    .line 40
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    .line 41
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "body size="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 33
    :goto_0
    nop

    .line 43
    .local v1, "bodyDesc":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "--> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v4

    invoke-virtual {v4}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "request.url().toString()"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, v4}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->redactUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "MinioOkHttp"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 44
    return-void
.end method

.method private final logResponse(Lokhttp3/Response;J)V
    .locals 8
    .param p1, "response"    # Lokhttp3/Response;
    .param p2, "tookMs"    # J

    .line 47
    invoke-virtual {p1}, Lokhttp3/Response;->request()Lokhttp3/Request;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v0

    .line 48
    .local v0, "path":Ljava/lang/String;
    :try_start_0
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v1, p0

    check-cast v1, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

    .line 103
    .local v1, "$this$logResponse_u24lambda_u241":Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;
    const/4 v2, 0x0

    .line 48
    .local v2, "$i$a$-runCatching-MinioHttpLoggingInterceptor$logResponse$peek$1":I
    const-wide/16 v3, 0x1000

    invoke-virtual {p1, v3, v4}, Lokhttp3/Response;->peekBody(J)Lokhttp3/ResponseBody;

    move-result-object v3

    .end local v1    # "$this$logResponse_u24lambda_u241":Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;
    .end local v2    # "$i$a$-runCatching-MinioHttpLoggingInterceptor$logResponse$peek$1":I
    invoke-static {v3}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    :goto_0
    invoke-static {v1}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    move-object v1, v3

    :cond_0
    check-cast v1, Lokhttp3/ResponseBody;

    .line 49
    .local v1, "peek":Lokhttp3/ResponseBody;
    nop

    .line 50
    if-nez v1, :cond_1

    const-string v2, "peek failed"

    goto :goto_2

    .line 51
    :cond_1
    invoke-virtual {v1}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v2, v4, v6

    if-nez v2, :cond_2

    const-string v2, "empty body"

    goto :goto_2

    .line 53
    :cond_2
    invoke-virtual {v1}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v2

    const-string v4, "peek.string()"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    .line 54
    .local v2, "snippet":Ljava/lang/String;
    nop

    .line 55
    const-string v4, "<?xml"

    const/4 v5, 0x0

    const/4 v6, 0x2

    invoke-static {v2, v4, v5, v6, v3}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_4

    const-string v4, "<"

    invoke-static {v2, v4, v5, v6, v3}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_1

    .line 56
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "body "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "B (non-xml)"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object v2, v3

    goto :goto_2

    .line 55
    :cond_4
    :goto_1
    invoke-direct {p0, v2}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->summarizeXml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    move-object v2, v3

    .line 49
    .end local v2    # "snippet":Ljava/lang/String;
    :goto_2
    nop

    .line 60
    .local v2, "summary":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<-- "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Lokhttp3/Response;->code()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x20

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "ms) "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "MinioOkHttp"

    invoke-static {v4, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 61
    return-void
.end method

.method private final redactUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "url"    # Ljava/lang/String;

    .line 97
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    new-instance v1, Lkotlin/text/Regex;

    const-string v2, "([?&])(X-Amz-[^=]+)=[^&]*"

    sget-object v3, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v1, v2, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    sget-object v2, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor$redactUrl$1;->INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor$redactUrl$1;

    check-cast v2, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v1, v0, v2}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Lkotlin/jvm/functions/Function1;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private final summarizeXml(Ljava/lang/String;)Ljava/lang/String;
    .locals 25
    .param p1, "xml"    # Ljava/lang/String;

    .line 78
    sget-object v0, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->XML_KEY_TAGS:[Ljava/lang/String;

    .local v0, "$this$mapNotNull$iv":[Ljava/lang/Object;
    const/4 v1, 0x0

    .line 104
    .local v1, "$i$f$mapNotNull":I
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/Collection;

    .local v2, "destination$iv$iv":Ljava/util/Collection;
    move-object v3, v0

    .local v3, "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 112
    .local v4, "$i$f$mapNotNullTo":I
    move-object v5, v3

    .local v5, "$this$forEach$iv$iv$iv":[Ljava/lang/Object;
    const/4 v6, 0x0

    .line 113
    .local v6, "$i$f$forEach":I
    array-length v7, v5

    const/4 v9, 0x0

    :goto_0
    if-ge v9, v7, :cond_4

    aget-object v11, v5, v9

    .local v11, "element$iv$iv$iv":Ljava/lang/Object;
    move-object v12, v11

    .local v12, "element$iv$iv":Ljava/lang/Object;
    const/4 v13, 0x0

    .line 112
    .local v13, "$i$a$-forEach-ArraysKt___ArraysKt$mapNotNullTo$1$iv$iv":I
    move-object v14, v12

    .local v14, "tag":Ljava/lang/String;
    const/4 v15, 0x0

    .line 79
    .local v15, "$i$a$-mapNotNull-MinioHttpLoggingInterceptor$summarizeXml$fields$1":I
    new-instance v10, Lkotlin/text/Regex;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v0

    .end local v0    # "$this$mapNotNull$iv":[Ljava/lang/Object;
    .local v18, "$this$mapNotNull$iv":[Ljava/lang/Object;
    const/16 v0, 0x3c

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v8, ">([^<]*)</"

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v8, 0x3e

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v8, Lkotlin/text/RegexOption;->IGNORE_CASE:Lkotlin/text/RegexOption;

    invoke-direct {v10, v0, v8}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;Lkotlin/text/RegexOption;)V

    move-object v0, v10

    .line 80
    .local v0, "regex":Lkotlin/text/Regex;
    move-object/from16 v8, p1

    check-cast v8, Ljava/lang/CharSequence;

    const/4 v10, 0x2

    move/from16 v19, v1

    .end local v1    # "$i$f$mapNotNull":I
    .local v19, "$i$f$mapNotNull":I
    const/4 v1, 0x0

    move-object/from16 v20, v3

    const/4 v3, 0x0

    .end local v3    # "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    .local v20, "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    invoke-static {v0, v8, v3, v10, v1}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v8

    if-eqz v8, :cond_2

    invoke-interface {v8}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v8

    if-eqz v8, :cond_2

    const/4 v10, 0x1

    invoke-static {v8, v10}, Lkotlin/collections/CollectionsKt;->getOrNull(Ljava/util/List;I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    if-eqz v8, :cond_2

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v8}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v8

    if-eqz v8, :cond_2

    move-object v10, v8

    .line 103
    .local v10, "it":Ljava/lang/String;
    const/16 v17, 0x0

    .line 80
    .local v17, "$i$a$-takeIf-MinioHttpLoggingInterceptor$summarizeXml$fields$1$1":I
    move-object/from16 v21, v10

    check-cast v21, Ljava/lang/CharSequence;

    invoke-interface/range {v21 .. v21}, Ljava/lang/CharSequence;->length()I

    move-result v21

    if-lez v21, :cond_0

    const/16 v16, 0x1

    goto :goto_1

    :cond_0
    move/from16 v16, v3

    .end local v10    # "it":Ljava/lang/String;
    .end local v17    # "$i$a$-takeIf-MinioHttpLoggingInterceptor$summarizeXml$fields$1$1":I
    :goto_1
    if-eqz v16, :cond_1

    goto :goto_2

    :cond_1
    move-object v8, v1

    .line 81
    :goto_2
    if-eqz v8, :cond_2

    .line 80
    nop

    .line 81
    move-object v1, v8

    .line 103
    .local v1, "it":Ljava/lang/String;
    const/4 v8, 0x0

    .line 81
    .local v8, "$i$a$-let-MinioHttpLoggingInterceptor$summarizeXml$fields$1$2":I
    sget-object v10, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

    const/16 v3, 0x60

    invoke-direct {v10, v1, v3}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->truncate(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v14, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    .end local v1    # "it":Ljava/lang/String;
    .end local v8    # "$i$a$-let-MinioHttpLoggingInterceptor$summarizeXml$fields$1$2":I
    goto :goto_3

    .line 80
    :cond_2
    nop

    .line 81
    :goto_3
    nop

    .line 112
    .end local v0    # "regex":Lkotlin/text/Regex;
    .end local v14    # "tag":Ljava/lang/String;
    .end local v15    # "$i$a$-mapNotNull-MinioHttpLoggingInterceptor$summarizeXml$fields$1":I
    if-eqz v1, :cond_3

    move-object v0, v1

    .line 114
    .local v0, "it$iv$iv":Ljava/lang/Object;
    const/4 v1, 0x0

    .line 112
    .local v1, "$i$a$-let-ArraysKt___ArraysKt$mapNotNullTo$1$1$iv$iv":I
    invoke-interface {v2, v0}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .line 113
    .end local v0    # "it$iv$iv":Ljava/lang/Object;
    .end local v1    # "$i$a$-let-ArraysKt___ArraysKt$mapNotNullTo$1$1$iv$iv":I
    .end local v12    # "element$iv$iv":Ljava/lang/Object;
    .end local v13    # "$i$a$-forEach-ArraysKt___ArraysKt$mapNotNullTo$1$iv$iv":I
    :cond_3
    nop

    .end local v11    # "element$iv$iv$iv":Ljava/lang/Object;
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v0, v18

    move/from16 v1, v19

    move-object/from16 v3, v20

    goto/16 :goto_0

    .line 115
    .end local v18    # "$this$mapNotNull$iv":[Ljava/lang/Object;
    .end local v19    # "$i$f$mapNotNull":I
    .end local v20    # "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    .local v0, "$this$mapNotNull$iv":[Ljava/lang/Object;
    .local v1, "$i$f$mapNotNull":I
    .restart local v3    # "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    :cond_4
    move-object/from16 v18, v0

    move/from16 v19, v1

    move-object/from16 v20, v3

    .line 116
    .end local v0    # "$this$mapNotNull$iv":[Ljava/lang/Object;
    .end local v1    # "$i$f$mapNotNull":I
    .end local v3    # "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    .end local v5    # "$this$forEach$iv$iv$iv":[Ljava/lang/Object;
    .end local v6    # "$i$f$forEach":I
    .restart local v18    # "$this$mapNotNull$iv":[Ljava/lang/Object;
    .restart local v19    # "$i$f$mapNotNull":I
    .restart local v20    # "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    nop

    .end local v2    # "destination$iv$iv":Ljava/util/Collection;
    .end local v4    # "$i$f$mapNotNullTo":I
    .end local v20    # "$this$mapNotNullTo$iv$iv":[Ljava/lang/Object;
    move-object v0, v2

    check-cast v0, Ljava/util/List;

    .line 104
    nop

    .line 78
    .end local v18    # "$this$mapNotNull$iv":[Ljava/lang/Object;
    .end local v19    # "$i$f$mapNotNull":I
    nop

    .line 83
    .local v0, "fields":Ljava/util/List;
    move-object v1, v0

    check-cast v1, Ljava/util/Collection;

    invoke-interface {v1}, Ljava/util/Collection;->isEmpty()Z

    move-result v1

    const/4 v2, 0x1

    xor-int/2addr v1, v2

    if-eqz v1, :cond_5

    .line 84
    move-object v2, v0

    check-cast v2, Ljava/lang/Iterable;

    const-string v1, ", "

    move-object v3, v1

    check-cast v3, Ljava/lang/CharSequence;

    sget-object v1, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor$summarizeXml$1;->INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor$summarizeXml$1;

    move-object v8, v1

    check-cast v8, Lkotlin/jvm/functions/Function1;

    const/16 v9, 0x1e

    const/4 v10, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v2 .. v10}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 86
    :cond_5
    const/16 v23, 0x4

    const/16 v24, 0x0

    const-string v20, "\n"

    const-string v21, ""

    const/16 v22, 0x0

    move-object/from16 v19, p1

    invoke-static/range {v19 .. v24}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v5, 0x4

    const/4 v6, 0x0

    const-string v2, "\r"

    const-string v3, ""

    const/4 v4, 0x0

    invoke-static/range {v1 .. v6}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 87
    .local v1, "compact":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "xmlLen="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " head="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x118

    move-object/from16 v4, p0

    invoke-direct {v4, v1, v3}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->truncate(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private final truncate(Ljava/lang/String;I)Ljava/lang/String;
    .locals 3
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "max"    # I

    .line 91
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-gt v0, p2, :cond_0

    return-object p1

    .line 92
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {p1, v1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "this as java.lang.String\u2026ing(startIndex, endIndex)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x2026

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final create()Lokhttp3/Interceptor;
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor$$ExternalSyntheticLambda0;-><init>()V

    .line 29
    return-object v0
.end method
