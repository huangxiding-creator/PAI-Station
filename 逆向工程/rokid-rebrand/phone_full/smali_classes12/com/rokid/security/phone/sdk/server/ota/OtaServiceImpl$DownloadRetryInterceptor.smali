.class final Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;
.super Ljava/lang/Object;
.source "OtaServiceImpl.kt"

# interfaces
.implements Lokhttp3/Interceptor;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "DownloadRetryInterceptor"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u0002\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J \u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00062\u0006\u0010\u0008\u001a\u00020\tH\u0002J\u0010\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0016J \u0010\u000e\u001a\u00020\t2\u0006\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0011\u001a\u00020\u0006H\u0002J\u0010\u0010\u0012\u001a\u00020\t2\u0006\u0010\u0005\u001a\u00020\u0006H\u0002\u00a8\u0006\u0013"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;",
        "Lokhttp3/Interceptor;",
        "()V",
        "calculateWaitTime",
        "",
        "retryCount",
        "",
        "statusCode",
        "isRangeRequest",
        "",
        "intercept",
        "Lokhttp3/Response;",
        "chain",
        "Lokhttp3/Interceptor$Chain;",
        "shouldRetryOnException",
        "e",
        "Ljava/io/IOException;",
        "maxRetry",
        "shouldRetryOnServerError",
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


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 83
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final calculateWaitTime(IIZ)J
    .locals 8
    .param p1, "retryCount"    # I
    .param p2, "statusCode"    # I
    .param p3, "isRangeRequest"    # Z

    .line 221
    nop

    .line 223
    const/16 v0, 0x1f4

    const/4 v1, 0x0

    if-gt v0, p2, :cond_0

    const/16 v0, 0x258

    if-ge p2, v0, :cond_0

    const/4 v1, 0x1

    :cond_0
    const-wide/16 v2, 0x7d0

    if-eqz v1, :cond_1

    int-to-long v0, p1

    mul-long/2addr v0, v2

    const-wide/16 v2, 0x1f40

    add-long/2addr v0, v2

    goto :goto_0

    .line 226
    :cond_1
    const/16 v0, 0x198

    const-wide/16 v4, 0x1388

    if-ne p2, v0, :cond_2

    move-wide v0, v4

    goto :goto_0

    .line 229
    :cond_2
    const/16 v0, 0x1ad

    if-ne p2, v0, :cond_3

    const-wide/16 v0, 0x2710

    goto :goto_0

    .line 232
    :cond_3
    const/4 v0, 0x2

    if-ge p1, v0, :cond_4

    add-int/lit8 v0, p1, 0x1

    int-to-long v0, v0

    mul-long/2addr v0, v2

    goto :goto_0

    .line 235
    :cond_4
    const/4 v0, 0x5

    if-ge p1, v0, :cond_5

    int-to-long v0, p1

    mul-long/2addr v0, v2

    add-long/2addr v0, v4

    goto :goto_0

    .line 238
    :cond_5
    const-wide/16 v0, 0x3a98

    .line 221
    :goto_0
    nop

    .line 242
    .local v0, "baseWait":J
    if-eqz p3, :cond_6

    long-to-double v2, v0

    const-wide v4, 0x3fe999999999999aL    # 0.8

    mul-double/2addr v2, v4

    double-to-long v2, v2

    goto :goto_1

    :cond_6
    move-wide v2, v0

    .line 245
    .local v2, "adjustedWait":J
    :goto_1
    if-eqz p3, :cond_7

    const-wide/16 v4, 0x7530

    goto :goto_2

    :cond_7
    const-wide/32 v4, 0xea60

    .line 247
    .local v4, "maxWait":J
    :goto_2
    invoke-static {v2, v3, v4, v5}, Lkotlin/ranges/RangesKt;->coerceAtMost(JJ)J

    move-result-wide v6

    return-wide v6
.end method

.method private final shouldRetryOnException(Ljava/io/IOException;II)Z
    .locals 5
    .param p1, "e"    # Ljava/io/IOException;
    .param p2, "retryCount"    # I
    .param p3, "maxRetry"    # I

    .line 190
    const/4 v0, 0x0

    if-lt p2, p3, :cond_0

    return v0

    .line 192
    :cond_0
    nop

    .line 193
    instance-of v1, p1, Ljavax/net/ssl/SSLException;

    const-string v2, "DownloadRetryInterceptor"

    if-eqz v1, :cond_1

    .line 194
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v1

    const-string v3, "SSL\u5f02\u5e38\uff0c\u4e0d\u91cd\u8bd5"

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 195
    goto :goto_0

    .line 197
    :cond_1
    instance-of v1, p1, Ljava/net/UnknownHostException;

    if-eqz v1, :cond_2

    .line 198
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v3, "\u57df\u540d\u89e3\u6790\u5931\u8d25\uff0c\u4e0d\u91cd\u8bd5"

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 199
    goto :goto_0

    .line 201
    :cond_2
    instance-of v1, p1, Ljava/net/ConnectException;

    const/4 v3, 0x1

    if-eqz v1, :cond_3

    .line 202
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u8fde\u63a5\u5f02\u5e38\uff0c\u8fdb\u884c\u91cd\u8bd5"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 203
    move v0, v3

    goto :goto_0

    .line 205
    :cond_3
    instance-of v1, p1, Ljava/net/SocketTimeoutException;

    if-eqz v1, :cond_4

    .line 206
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v4, "\u8d85\u65f6\u5f02\u5e38\uff0c\u8fdb\u884c\u91cd\u8bd5"

    filled-new-array {v2, v4}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 207
    const/4 v1, 0x3

    if-ge p2, v1, :cond_5

    move v0, v3

    goto :goto_0

    .line 210
    :cond_4
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u5176\u4ed6IO\u5f02\u5e38\uff0c\u8fdb\u884c\u91cd\u8bd5"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 211
    move v0, v3

    .line 192
    :cond_5
    :goto_0
    return v0
.end method

.method private final shouldRetryOnServerError(I)Z
    .locals 1
    .param p1, "retryCount"    # I

    .line 255
    const/4 v0, 0x5

    if-ge p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method


# virtual methods
.method public intercept(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 16
    .param p1, "chain"    # Lokhttp3/Interceptor$Chain;

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    const-string/jumbo v3, "\u7b49\u5f85"

    const-string v4, "DownloadRetryInterceptor"

    const-string v0, "chain"

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 85
    invoke-interface/range {p1 .. p1}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v5

    .line 86
    .local v5, "request":Lokhttp3/Request;
    const/4 v0, 0x0

    .line 89
    .local v0, "lastException":Ljava/io/IOException;
    const-string v6, "Range"

    invoke-virtual {v5, v6}, Lokhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_0

    const/4 v6, 0x1

    goto :goto_0

    :cond_0
    const/4 v6, 0x0

    .line 94
    .local v6, "isRangeRequest":Z
    :goto_0
    if-eqz v6, :cond_1

    const/4 v9, 0x5

    goto :goto_1

    :cond_1
    const/16 v9, 0x8

    .line 96
    .local v9, "maxRetry":I
    :goto_1
    const/4 v10, 0x0

    .local v10, "retryCount":I
    if-gt v10, v9, :cond_f

    move v11, v10

    move-object v10, v0

    .line 97
    .end local v0    # "lastException":Ljava/io/IOException;
    .local v10, "lastException":Ljava/io/IOException;
    .local v11, "retryCount":I
    :goto_2
    nop

    .line 98
    :try_start_0
    invoke-interface {v2, v5}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v0

    .line 101
    .local v0, "response":Lokhttp3/Response;
    sget-object v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v12

    .line 102
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v14, "\u8bf7\u6c42\u7ed3\u679c: status="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ", isRange="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 103
    nop

    .line 102
    invoke-virtual {v13, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 103
    const-string v14, ", retryCount="

    .line 102
    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 104
    nop

    .line 102
    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const/16 v14, 0x2f

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 104
    nop

    .line 102
    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    filled-new-array {v4, v13}, [Ljava/lang/Object;

    move-result-object v13

    .line 101
    invoke-static {v12, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 107
    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v12
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 108
    const/16 v13, 0x1a0

    const-string v14, "response"

    if-ne v12, v13, :cond_2

    .line 109
    :try_start_1
    sget-object v12, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v12

    const-string/jumbo v13, "\u6587\u4ef6\u5df2\u5b8c\u5168\u4e0b\u8f7d\uff0c\u54cd\u5e94\u7801\uff1a416"

    filled-new-array {v4, v13}, [Ljava/lang/Object;

    move-result-object v13

    invoke-static {v12, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 110
    invoke-static {v0, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0

    .line 113
    :cond_2
    const/16 v13, 0xc8

    if-ne v12, v13, :cond_3

    :goto_3
    const/4 v13, 0x1

    goto :goto_4

    :cond_3
    const/16 v13, 0xce

    if-ne v12, v13, :cond_4

    goto :goto_3

    :cond_4
    const/4 v13, 0x0

    :goto_4
    const-string v15, "ms\u540e\u91cd\u8bd5"

    if-eqz v13, :cond_5

    .line 114
    :try_start_2
    invoke-virtual {v0}, Lokhttp3/Response;->isSuccessful()Z

    move-result v12

    if-eqz v12, :cond_a

    .line 115
    invoke-static {v0, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    return-object v0

    .line 119
    :cond_5
    const/16 v13, 0x1f4

    if-gt v13, v12, :cond_6

    const/16 v13, 0x258

    if-ge v12, v13, :cond_6

    const/4 v13, 0x1

    goto :goto_5

    :cond_6
    const/4 v13, 0x0

    :goto_5
    const-string/jumbo v7, "\uff0c\u7b49\u5f85"

    if-eqz v13, :cond_7

    .line 120
    if-ge v11, v9, :cond_a

    :try_start_3
    invoke-direct {v1, v11}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;->shouldRetryOnServerError(I)Z

    move-result v12

    if-eqz v12, :cond_a

    .line 121
    invoke-virtual {v0}, Lokhttp3/Response;->close()V

    .line 122
    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v12

    invoke-direct {v1, v11, v12, v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;->calculateWaitTime(IIZ)J

    move-result-wide v12

    .line 123
    .local v12, "waitTime":J
    sget-object v14, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v14}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v14

    .line 124
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u670d\u52a1\u5668\u9519\u8bef "

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v8

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v4, v2}, [Ljava/lang/Object;

    move-result-object v2

    .line 123
    invoke-static {v14, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    invoke-static {v12, v13}, Ljava/lang/Thread;->sleep(J)V

    .line 126
    goto/16 :goto_8

    .line 130
    .end local v12    # "waitTime":J
    :cond_7
    const/16 v2, 0x198

    if-ne v12, v2, :cond_8

    :goto_6
    const/4 v2, 0x1

    goto :goto_7

    :cond_8
    const/16 v2, 0x1ad

    if-ne v12, v2, :cond_9

    goto :goto_6

    :cond_9
    const/4 v2, 0x0

    :goto_7
    if-eqz v2, :cond_a

    .line 131
    if-ge v11, v9, :cond_a

    .line 132
    invoke-virtual {v0}, Lokhttp3/Response;->close()V

    .line 133
    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v2

    invoke-direct {v1, v11, v2, v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;->calculateWaitTime(IIZ)J

    move-result-wide v12

    .line 134
    .restart local v12    # "waitTime":J
    sget-object v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v2

    .line 135
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v14, "\u5ba2\u6237\u7aef\u9519\u8bef "

    invoke-virtual {v8, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v14

    invoke-virtual {v8, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v4, v7}, [Ljava/lang/Object;

    move-result-object v7

    .line 134
    invoke-static {v2, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 136
    invoke-static {v12, v13}, Ljava/lang/Thread;->sleep(J)V

    .line 137
    goto/16 :goto_8

    .line 143
    .end local v12    # "waitTime":J
    :cond_a
    if-ne v11, v9, :cond_b

    .line 144
    invoke-static {v0, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0

    .line 146
    :cond_b
    invoke-virtual {v0}, Lokhttp3/Response;->close()V

    .line 147
    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v2

    invoke-direct {v1, v11, v2, v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;->calculateWaitTime(IIZ)J

    move-result-wide v7

    .line 148
    .local v7, "waitTime":J
    sget-object v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v2

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    filled-new-array {v4, v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v2, v12}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 149
    invoke-static {v7, v8}, Ljava/lang/Thread;->sleep(J)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    .end local v0    # "response":Lokhttp3/Response;
    .end local v7    # "waitTime":J
    goto/16 :goto_8

    .line 152
    :catch_0
    move-exception v0

    move-object v2, v0

    .line 153
    .local v2, "e":Ljava/io/IOException;
    move-object v7, v2

    .line 156
    .end local v10    # "lastException":Ljava/io/IOException;
    .local v7, "lastException":Ljava/io/IOException;
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v0

    .line 157
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v10, 0x7b2c

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v8

    add-int/lit8 v10, v11, 0x1

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string/jumbo v10, "\u6b21\u5c1d\u8bd5\u5931\u8d25: "

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v10, " - "

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v4, v8}, [Ljava/lang/Object;

    move-result-object v8

    .line 156
    invoke-static {v0, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 160
    invoke-direct {v1, v2, v11, v9}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;->shouldRetryOnException(Ljava/io/IOException;II)Z

    move-result v0

    if-eqz v0, :cond_e

    .line 165
    if-eq v11, v9, :cond_d

    .line 170
    const/4 v0, -0x1

    invoke-direct {v1, v11, v0, v6}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$DownloadRetryInterceptor;->calculateWaitTime(IIZ)J

    move-result-wide v12

    .line 171
    .restart local v12    # "waitTime":J
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v0

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v10, "ms\u540e\u8fdb\u884c\u7b2c"

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    add-int/lit8 v10, v11, 0x2

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string/jumbo v10, "\u6b21\u91cd\u8bd5"

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v4, v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v0, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 174
    nop

    .line 175
    const-wide/32 v14, 0x1d4c0

    :try_start_4
    invoke-static {v12, v13, v14, v15}, Lkotlin/ranges/RangesKt;->coerceAtMost(JJ)J

    move-result-wide v14

    invoke-static {v14, v15}, Ljava/lang/Thread;->sleep(J)V
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_1

    move-object v10, v7

    .line 96
    .end local v2    # "e":Ljava/io/IOException;
    .end local v7    # "lastException":Ljava/io/IOException;
    .end local v12    # "waitTime":J
    .restart local v10    # "lastException":Ljava/io/IOException;
    :goto_8
    if-eq v11, v9, :cond_c

    add-int/lit8 v11, v11, 0x1

    move-object/from16 v2, p1

    goto/16 :goto_2

    :cond_c
    move-object v0, v10

    goto :goto_9

    .line 176
    .end local v10    # "lastException":Ljava/io/IOException;
    .restart local v2    # "e":Ljava/io/IOException;
    .restart local v7    # "lastException":Ljava/io/IOException;
    .restart local v12    # "waitTime":J
    :catch_1
    move-exception v0

    .line 177
    .local v0, "ie":Ljava/lang/InterruptedException;
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Thread;->interrupt()V

    .line 178
    throw v2

    .line 166
    .end local v0    # "ie":Ljava/lang/InterruptedException;
    .end local v12    # "waitTime":J
    :cond_d
    throw v2

    .line 161
    :cond_e
    throw v2

    .line 183
    .end local v2    # "e":Ljava/io/IOException;
    .end local v7    # "lastException":Ljava/io/IOException;
    .end local v11    # "retryCount":I
    .local v0, "lastException":Ljava/io/IOException;
    :cond_f
    :goto_9
    if-eqz v0, :cond_10

    move-object v2, v0

    check-cast v2, Ljava/lang/Throwable;

    goto :goto_a

    :cond_10
    new-instance v2, Ljava/io/IOException;

    const-string/jumbo v3, "\u4e0b\u8f7d\u5931\u8d25\uff0c\u8d85\u8fc7\u6700\u5927\u91cd\u8bd5\u6b21\u6570"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    check-cast v2, Ljava/lang/Throwable;

    :goto_a
    throw v2
.end method
