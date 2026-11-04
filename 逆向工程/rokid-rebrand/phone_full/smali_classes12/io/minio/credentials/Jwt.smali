.class public Lio/minio/credentials/Jwt;
.super Ljava/lang/Object;
.source "Jwt.java"


# instance fields
.field private final expiry:I
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "expires_in"
    .end annotation
.end field

.field private final token:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "access_token"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;I)V
    .locals 1
    .param p1, "token"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "expiry"    # I

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    invoke-static {p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/credentials/Jwt;->token:Ljava/lang/String;

    .line 37
    iput p2, p0, Lio/minio/credentials/Jwt;->expiry:I

    .line 38
    return-void
.end method


# virtual methods
.method public expiry()I
    .locals 1

    .line 45
    iget v0, p0, Lio/minio/credentials/Jwt;->expiry:I

    return v0
.end method

.method public token()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lio/minio/credentials/Jwt;->token:Ljava/lang/String;

    return-object v0
.end method
