.class public Lcom/amazonaws/services/s3/internal/DeleteObjectTaggingHeaderHandler;
.super Ljava/lang/Object;
.source "DeleteObjectTaggingHeaderHandler.java"

# interfaces
.implements Lcom/amazonaws/services/s3/internal/HeaderHandler;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/amazonaws/services/s3/internal/HeaderHandler<",
        "Lcom/amazonaws/services/s3/model/DeleteObjectTaggingResult;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public handle(Lcom/amazonaws/services/s3/model/DeleteObjectTaggingResult;Lcom/amazonaws/http/HttpResponse;)V
    .locals 2
    .param p1, "result"    # Lcom/amazonaws/services/s3/model/DeleteObjectTaggingResult;
    .param p2, "response"    # Lcom/amazonaws/http/HttpResponse;

    .line 28
    invoke-virtual {p2}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v0

    const-string/jumbo v1, "x-amz-version-id"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/amazonaws/services/s3/model/DeleteObjectTaggingResult;->setVersionId(Ljava/lang/String;)V

    .line 29
    return-void
.end method

.method public bridge synthetic handle(Ljava/lang/Object;Lcom/amazonaws/http/HttpResponse;)V
    .locals 0

    .line 25
    check-cast p1, Lcom/amazonaws/services/s3/model/DeleteObjectTaggingResult;

    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/services/s3/internal/DeleteObjectTaggingHeaderHandler;->handle(Lcom/amazonaws/services/s3/model/DeleteObjectTaggingResult;Lcom/amazonaws/http/HttpResponse;)V

    return-void
.end method
