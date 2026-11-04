.class public Lcom/amazonaws/services/s3/internal/S3ExecutionContext;
.super Lcom/amazonaws/http/ExecutionContext;
.source "S3ExecutionContext.java"


# instance fields
.field private signer:Lcom/amazonaws/auth/Signer;


# direct methods
.method public constructor <init>(Ljava/util/List;ZLcom/amazonaws/AmazonWebServiceClient;)V
    .locals 0
    .param p2, "isMetricEnabled"    # Z
    .param p3, "awsClient"    # Lcom/amazonaws/AmazonWebServiceClient;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/handlers/RequestHandler2;",
            ">;Z",
            "Lcom/amazonaws/AmazonWebServiceClient;",
            ")V"
        }
    .end annotation

    .line 40
    .local p1, "requestHandler2s":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/http/ExecutionContext;-><init>(Ljava/util/List;ZLcom/amazonaws/AmazonWebServiceClient;)V

    .line 41
    return-void
.end method


# virtual methods
.method public getSignerByURI(Ljava/net/URI;)Lcom/amazonaws/auth/Signer;
    .locals 1
    .param p1, "uri"    # Ljava/net/URI;

    .line 52
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/S3ExecutionContext;->signer:Lcom/amazonaws/auth/Signer;

    return-object v0
.end method

.method public setSigner(Lcom/amazonaws/auth/Signer;)V
    .locals 0
    .param p1, "signer"    # Lcom/amazonaws/auth/Signer;

    .line 45
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/S3ExecutionContext;->signer:Lcom/amazonaws/auth/Signer;

    .line 46
    return-void
.end method
