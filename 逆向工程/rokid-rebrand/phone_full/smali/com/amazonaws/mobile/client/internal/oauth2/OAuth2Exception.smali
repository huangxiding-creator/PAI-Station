.class public Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;
.super Ljava/lang/RuntimeException;
.source "OAuth2Exception.java"


# instance fields
.field error:Ljava/lang/String;

.field errorDescription:Ljava/lang/String;

.field errorUri:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "error"    # Ljava/lang/String;
    .param p3, "errorDescription"    # Ljava/lang/String;
    .param p4, "errorUri"    # Ljava/lang/String;

    .line 8
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .line 9
    iput-object p2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;->error:Ljava/lang/String;

    .line 10
    iput-object p3, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;->errorDescription:Ljava/lang/String;

    .line 11
    iput-object p4, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;->errorUri:Ljava/lang/String;

    .line 12
    return-void
.end method


# virtual methods
.method public getError()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;->error:Ljava/lang/String;

    return-object v0
.end method

.method public getErrorDescription()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;->errorDescription:Ljava/lang/String;

    return-object v0
.end method

.method public getErrorUri()Ljava/lang/String;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;->errorUri:Ljava/lang/String;

    return-object v0
.end method
