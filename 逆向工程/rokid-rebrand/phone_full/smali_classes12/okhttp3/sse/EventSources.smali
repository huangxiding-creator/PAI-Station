.class public final Lokhttp3/sse/EventSources;
.super Ljava/lang/Object;
.source "EventSources.java"


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static createFactory(Lokhttp3/OkHttpClient;)Lokhttp3/sse/EventSource$Factory;
    .locals 1
    .param p0, "client"    # Lokhttp3/OkHttpClient;

    .line 25
    new-instance v0, Lokhttp3/sse/EventSources$1;

    invoke-direct {v0, p0}, Lokhttp3/sse/EventSources$1;-><init>(Lokhttp3/OkHttpClient;)V

    return-object v0
.end method

.method public static processResponse(Lokhttp3/Response;Lokhttp3/sse/EventSourceListener;)V
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;
    .param p1, "listener"    # Lokhttp3/sse/EventSourceListener;

    .line 35
    new-instance v0, Lokhttp3/internal/sse/RealEventSource;

    invoke-virtual {p0}, Lokhttp3/Response;->request()Lokhttp3/Request;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Lokhttp3/internal/sse/RealEventSource;-><init>(Lokhttp3/Request;Lokhttp3/sse/EventSourceListener;)V

    .line 36
    .local v0, "eventSource":Lokhttp3/internal/sse/RealEventSource;
    invoke-virtual {v0, p0}, Lokhttp3/internal/sse/RealEventSource;->processResponse(Lokhttp3/Response;)V

    .line 37
    return-void
.end method
