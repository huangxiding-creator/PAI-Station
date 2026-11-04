.class public Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler;
.super Ljava/lang/Object;
.source "S3RequesterChargedHeaderHandler.java"

# interfaces
.implements Lcom/amazonaws/services/s3/internal/HeaderHandler;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T::",
        "Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/amazonaws/services/s3/internal/HeaderHandler<",
        "TT;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    .local p0, "this":Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler;, "Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public handle(Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;Lcom/amazonaws/http/HttpResponse;)V
    .locals 2
    .param p2, "response"    # Lcom/amazonaws/http/HttpResponse;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/amazonaws/http/HttpResponse;",
            ")V"
        }
    .end annotation

    .line 37
    .local p0, "this":Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler;, "Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler<TT;>;"
    .local p1, "result":Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;, "TT;"
    nop

    .line 38
    invoke-virtual {p2}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v0

    const-string/jumbo v1, "x-amz-request-charged"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 37
    :goto_0
    invoke-interface {p1, v0}, Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;->setRequesterCharged(Z)V

    .line 39
    return-void
.end method

.method public bridge synthetic handle(Ljava/lang/Object;Lcom/amazonaws/http/HttpResponse;)V
    .locals 0

    .line 26
    .local p0, "this":Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler;, "Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler<TT;>;"
    check-cast p1, Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;

    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/services/s3/internal/S3RequesterChargedHeaderHandler;->handle(Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;Lcom/amazonaws/http/HttpResponse;)V

    return-void
.end method
