.class public final Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;
.super Ljava/lang/Object;
.source "UserTokenFailureInterceptor.kt"

# interfaces
.implements Lokhttp3/Interceptor;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0016J\u0010\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\tH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0080T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;",
        "Lokhttp3/Interceptor;",
        "()V",
        "DEFER_LOCAL_INVALIDATION_HEADER",
        "",
        "MAX_ERROR_BODY_BYTES",
        "",
        "USER_AUTH_HEADER",
        "intercept",
        "Lokhttp3/Response;",
        "chain",
        "Lokhttp3/Interceptor$Chain;",
        "mayContainJson",
        "",
        "response",
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
.field public static final DEFER_LOCAL_INVALIDATION_HEADER:Ljava/lang/String; = "X-Rokid-Defer-Local-Token-Invalidation"

.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

.field private static final MAX_ERROR_BODY_BYTES:J = 0x1000L

.field private static final USER_AUTH_HEADER:Ljava/lang/String; = "x-user-authorization"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final mayContainJson(Lokhttp3/Response;)Z
    .locals 6
    .param p1, "response"    # Lokhttp3/Response;

    .line 38
    invoke-virtual {p1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->contentType()Lokhttp3/MediaType;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lokhttp3/MediaType;->toString()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v2, "this as java.lang.String).toLowerCase(Locale.ROOT)"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    if-nez v0, :cond_1

    const-string v0, ""

    .line 39
    .local v0, "contentType":Ljava/lang/String;
    :cond_1
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const-string v3, "json"

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-static {v2, v3, v5, v4, v1}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    const/4 v5, 0x1

    :cond_3
    return v5
.end method


# virtual methods
.method public intercept(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 12
    .param p1, "chain"    # Lokhttp3/Interceptor$Chain;

    const-string v0, "chain"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    invoke-interface {p1}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v0

    .line 16
    .local v0, "request":Lokhttp3/Request;
    const-string v1, "X-Rokid-Defer-Local-Token-Invalidation"

    invoke-virtual {v0, v1}, Lokhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "1"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    .line 17
    .local v2, "deferLocalInvalidation":Z
    if-eqz v2, :cond_0

    .line 18
    invoke-virtual {v0}, Lokhttp3/Request;->newBuilder()Lokhttp3/Request$Builder;

    move-result-object v3

    invoke-virtual {v3, v1}, Lokhttp3/Request$Builder;->removeHeader(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v1

    goto :goto_0

    .line 19
    :cond_0
    move-object v1, v0

    .line 17
    :goto_0
    nop

    .line 20
    .local v1, "networkRequest":Lokhttp3/Request;
    invoke-interface {p1, v1}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v3

    .line 21
    .local v3, "response":Lokhttp3/Response;
    const-string/jumbo v4, "x-user-authorization"

    invoke-virtual {v0, v4}, Lokhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1

    const-string v4, ""

    .line 22
    .local v4, "expectedUserToken":Ljava/lang/String;
    :cond_1
    move-object v5, v4

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    const-string v6, "response"

    if-nez v5, :cond_6

    invoke-static {v3, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, v3}, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->mayContainJson(Lokhttp3/Response;)Z

    move-result v5

    if-nez v5, :cond_2

    goto :goto_3

    .line 24
    :cond_2
    :try_start_0
    sget-object v5, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v5, p0

    check-cast v5, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    .local v5, "$this$intercept_u24lambda_u240":Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;
    const/4 v6, 0x0

    .line 25
    .local v6, "$i$a$-runCatching-UserTokenFailureInterceptor$intercept$responseCode$1":I
    const-wide/16 v7, 0x1000

    invoke-virtual {v3, v7, v8}, Lokhttp3/Response;->peekBody(J)Lokhttp3/ResponseBody;

    move-result-object v7

    invoke-virtual {v7}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v7

    .line 26
    .local v7, "snapshot":Ljava/lang/String;
    sget-object v8, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->INSTANCE:Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;

    const-string/jumbo v9, "snapshot"

    invoke-static {v7, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v8, v7}, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->parse(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v8

    .line 24
    .end local v5    # "$this$intercept_u24lambda_u240":Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;
    .end local v6    # "$i$a$-runCatching-UserTokenFailureInterceptor$intercept$responseCode$1":I
    .end local v7    # "snapshot":Ljava/lang/String;
    invoke-static {v8}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v5

    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v5}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v5

    invoke-static {v5}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 27
    :goto_1
    invoke-static {v5}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    const/4 v5, 0x0

    :cond_3
    check-cast v5, Ljava/lang/Integer;

    .line 24
    move-object v11, v5

    .line 28
    .local v11, "responseCode":Ljava/lang/Integer;
    if-nez v11, :cond_4

    goto :goto_2

    :cond_4
    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const v6, 0xc389

    if-ne v5, v6, :cond_5

    if-nez v2, :cond_5

    .line 29
    sget-object v5, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    .line 30
    nop

    .line 31
    nop

    .line 29
    const/4 v9, 0x4

    const/4 v10, 0x0

    const-string v7, "http_response"

    const/4 v8, 0x0

    move-object v6, v4

    invoke-static/range {v5 .. v10}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->notify$default(Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)V

    .line 34
    :cond_5
    :goto_2
    return-object v3

    .line 22
    .end local v11    # "responseCode":Ljava/lang/Integer;
    :cond_6
    :goto_3
    invoke-static {v3, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v3
.end method
