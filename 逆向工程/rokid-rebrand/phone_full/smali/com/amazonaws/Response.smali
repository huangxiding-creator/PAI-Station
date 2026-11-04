.class public final Lcom/amazonaws/Response;
.super Ljava/lang/Object;
.source "Response.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private final httpResponse:Lcom/amazonaws/http/HttpResponse;

.field private final response:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Object;Lcom/amazonaws/http/HttpResponse;)V
    .locals 0
    .param p2, "httpResponse"    # Lcom/amazonaws/http/HttpResponse;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/amazonaws/http/HttpResponse;",
            ")V"
        }
    .end annotation

    .line 35
    .local p0, "this":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TT;>;"
    .local p1, "response":Ljava/lang/Object;, "TT;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object p1, p0, Lcom/amazonaws/Response;->response:Ljava/lang/Object;

    .line 37
    iput-object p2, p0, Lcom/amazonaws/Response;->httpResponse:Lcom/amazonaws/http/HttpResponse;

    .line 38
    return-void
.end method


# virtual methods
.method public getAwsResponse()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .line 41
    .local p0, "this":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/Response;->response:Ljava/lang/Object;

    return-object v0
.end method

.method public getHttpResponse()Lcom/amazonaws/http/HttpResponse;
    .locals 1

    .line 45
    .local p0, "this":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/Response;->httpResponse:Lcom/amazonaws/http/HttpResponse;

    return-object v0
.end method
