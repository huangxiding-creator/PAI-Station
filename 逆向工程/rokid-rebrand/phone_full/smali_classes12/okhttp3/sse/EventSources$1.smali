.class Lokhttp3/sse/EventSources$1;
.super Ljava/lang/Object;
.source "EventSources.java"

# interfaces
.implements Lokhttp3/sse/EventSource$Factory;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lokhttp3/sse/EventSources;->createFactory(Lokhttp3/OkHttpClient;)Lokhttp3/sse/EventSource$Factory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$client:Lokhttp3/OkHttpClient;


# direct methods
.method constructor <init>(Lokhttp3/OkHttpClient;)V
    .locals 0

    .line 25
    iput-object p1, p0, Lokhttp3/sse/EventSources$1;->val$client:Lokhttp3/OkHttpClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public newEventSource(Lokhttp3/Request;Lokhttp3/sse/EventSourceListener;)Lokhttp3/sse/EventSource;
    .locals 2
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "listener"    # Lokhttp3/sse/EventSourceListener;

    .line 27
    new-instance v0, Lokhttp3/internal/sse/RealEventSource;

    invoke-direct {v0, p1, p2}, Lokhttp3/internal/sse/RealEventSource;-><init>(Lokhttp3/Request;Lokhttp3/sse/EventSourceListener;)V

    .line 28
    .local v0, "eventSource":Lokhttp3/internal/sse/RealEventSource;
    iget-object v1, p0, Lokhttp3/sse/EventSources$1;->val$client:Lokhttp3/OkHttpClient;

    invoke-virtual {v0, v1}, Lokhttp3/internal/sse/RealEventSource;->connect(Lokhttp3/OkHttpClient;)V

    .line 29
    return-object v0
.end method
