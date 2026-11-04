.class public final Lcom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor;
.super Ljava/lang/Object;
.source "RetrofitClient.kt"

# interfaces
.implements Lokhttp3/Interceptor;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/net/RetrofitClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ProgressInterceptor"
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRetrofitClient.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RetrofitClient.kt\ncom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,384:1\n1#2:385\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001e\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0010\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u0008H\u0016R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor;",
        "Lokhttp3/Interceptor;",
        "listener",
        "Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;",
        "(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)V",
        "intercept",
        "Lokhttp3/Response;",
        "chain",
        "Lokhttp3/Interceptor$Chain;",
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


# instance fields
.field private final listener:Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;


# direct methods
.method public constructor <init>(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 203
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor;->listener:Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    return-void
.end method


# virtual methods
.method public intercept(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 8
    .param p1, "chain"    # Lokhttp3/Interceptor$Chain;

    const-string v0, "chain"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 205
    invoke-interface {p1}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v0

    .line 206
    .local v0, "request":Lokhttp3/Request;
    invoke-interface {p1, v0}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v1

    .line 207
    .local v1, "response":Lokhttp3/Response;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ProgressInterceptor-->"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "ProgressInterceptor"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 208
    invoke-virtual {v1}, Lokhttp3/Response;->newBuilder()Lokhttp3/Response$Builder;

    move-result-object v2

    .line 209
    invoke-virtual {v1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 385
    nop

    .local v3, "it":Lokhttp3/ResponseBody;
    const/4 v4, 0x0

    .line 209
    .local v4, "$i$a$-let-RetrofitClient$ProgressInterceptor$intercept$1":I
    new-instance v5, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;

    iget-object v6, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor;->listener:Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v7

    invoke-direct {v5, v3, v6, v7}, Lcom/rokid/security/phone/sdk/base/utils/net/ProgressResponseBody;-><init>(Lokhttp3/ResponseBody;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;Lkotlinx/coroutines/CoroutineScope;)V

    .end local v3    # "it":Lokhttp3/ResponseBody;
    .end local v4    # "$i$a$-let-RetrofitClient$ProgressInterceptor$intercept$1":I
    goto :goto_0

    :cond_0
    const/4 v5, 0x0

    :goto_0
    check-cast v5, Lokhttp3/ResponseBody;

    invoke-virtual {v2, v5}, Lokhttp3/Response$Builder;->body(Lokhttp3/ResponseBody;)Lokhttp3/Response$Builder;

    move-result-object v2

    .line 210
    invoke-virtual {v2}, Lokhttp3/Response$Builder;->build()Lokhttp3/Response;

    move-result-object v2

    const-string v3, "response.newBuilder()\n  \u2026\n                .build()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 208
    return-object v2
.end method
