.class public Lcom/alibaba/sdk/android/oss/network/ExecutionContext;
.super Ljava/lang/Object;
.source "ExecutionContext.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<Request:",
        "Lcom/alibaba/sdk/android/oss/model/OSSRequest;",
        "Result:",
        "Lcom/alibaba/sdk/android/oss/model/OSSResult;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private applicationContext:Landroid/content/Context;

.field private cancellationHandler:Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

.field private client:Lokhttp3/OkHttpClient;

.field private completedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

.field private progressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

.field private request:Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TRequest;"
        }
    .end annotation
.end field

.field private retryCallback:Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;


# direct methods
.method public constructor <init>(Lokhttp3/OkHttpClient;Lcom/alibaba/sdk/android/oss/model/OSSRequest;)V
    .locals 1
    .param p1, "client"    # Lokhttp3/OkHttpClient;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lokhttp3/OkHttpClient;",
            "TRequest;)V"
        }
    .end annotation

    .line 29
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    .local p2, "request":Lcom/alibaba/sdk/android/oss/model/OSSRequest;, "TRequest;"
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;-><init>(Lokhttp3/OkHttpClient;Lcom/alibaba/sdk/android/oss/model/OSSRequest;Landroid/content/Context;)V

    .line 30
    return-void
.end method

.method public constructor <init>(Lokhttp3/OkHttpClient;Lcom/alibaba/sdk/android/oss/model/OSSRequest;Landroid/content/Context;)V
    .locals 1
    .param p1, "client"    # Lokhttp3/OkHttpClient;
    .param p3, "applicationContext"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lokhttp3/OkHttpClient;",
            "TRequest;",
            "Landroid/content/Context;",
            ")V"
        }
    .end annotation

    .line 32
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    .local p2, "request":Lcom/alibaba/sdk/android/oss/model/OSSRequest;, "TRequest;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    new-instance v0, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->cancellationHandler:Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    .line 33
    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->setClient(Lokhttp3/OkHttpClient;)V

    .line 34
    invoke-virtual {p0, p2}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->setRequest(Lcom/alibaba/sdk/android/oss/model/OSSRequest;)V

    .line 35
    iput-object p3, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->applicationContext:Landroid/content/Context;

    .line 36
    return-void
.end method


# virtual methods
.method public getApplicationContext()Landroid/content/Context;
    .locals 1

    .line 39
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->applicationContext:Landroid/content/Context;

    return-object v0
.end method

.method public getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;
    .locals 1

    .line 59
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->cancellationHandler:Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    return-object v0
.end method

.method public getClient()Lokhttp3/OkHttpClient;
    .locals 1

    .line 51
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->client:Lokhttp3/OkHttpClient;

    return-object v0
.end method

.method public getCompletedCallback()Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<",
            "TRequest;TResult;>;"
        }
    .end annotation

    .line 63
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->completedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    return-object v0
.end method

.method public getProgressCallback()Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    .locals 1

    .line 71
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->progressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    return-object v0
.end method

.method public getRequest()Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TRequest;"
        }
    .end annotation

    .line 43
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->request:Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    return-object v0
.end method

.method public getRetryCallback()Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;
    .locals 1

    .line 79
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->retryCallback:Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;

    return-object v0
.end method

.method public setClient(Lokhttp3/OkHttpClient;)V
    .locals 0
    .param p1, "client"    # Lokhttp3/OkHttpClient;

    .line 55
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->client:Lokhttp3/OkHttpClient;

    .line 56
    return-void
.end method

.method public setCompletedCallback(Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<",
            "TRequest;TResult;>;)V"
        }
    .end annotation

    .line 67
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    .local p1, "completedCallback":Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;, "Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback<TRequest;TResult;>;"
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->completedCallback:Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    .line 68
    return-void
.end method

.method public setProgressCallback(Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;)V
    .locals 0
    .param p1, "progressCallback"    # Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    .line 75
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->progressCallback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    .line 76
    return-void
.end method

.method public setRequest(Lcom/alibaba/sdk/android/oss/model/OSSRequest;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TRequest;)V"
        }
    .end annotation

    .line 47
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    .local p1, "request":Lcom/alibaba/sdk/android/oss/model/OSSRequest;, "TRequest;"
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->request:Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    .line 48
    return-void
.end method

.method public setRetryCallback(Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;)V
    .locals 0
    .param p1, "retryCallback"    # Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;

    .line 83
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ExecutionContext;, "Lcom/alibaba/sdk/android/oss/network/ExecutionContext<TRequest;TResult;>;"
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->retryCallback:Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;

    .line 84
    return-void
.end method
