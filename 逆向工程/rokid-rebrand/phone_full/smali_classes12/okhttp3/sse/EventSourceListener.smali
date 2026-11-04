.class public abstract Lokhttp3/sse/EventSourceListener;
.super Ljava/lang/Object;
.source "EventSourceListener.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed(Lokhttp3/sse/EventSource;)V
    .locals 0
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;

    .line 41
    return-void
.end method

.method public onEvent(Lokhttp3/sse/EventSource;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;
    .param p2, "id"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p3, "type"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p4, "data"    # Ljava/lang/String;

    .line 34
    return-void
.end method

.method public onFailure(Lokhttp3/sse/EventSource;Ljava/lang/Throwable;Lokhttp3/Response;)V
    .locals 0
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;
    .param p2, "t"    # Ljava/lang/Throwable;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p3, "response"    # Lokhttp3/Response;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 49
    return-void
.end method

.method public onOpen(Lokhttp3/sse/EventSource;Lokhttp3/Response;)V
    .locals 0
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;
    .param p2, "response"    # Lokhttp3/Response;

    .line 27
    return-void
.end method
