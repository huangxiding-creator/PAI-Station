.class public Lio/minio/messages/Source;
.super Ljava/lang/Object;
.source "Source.java"


# instance fields
.field private host:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private port:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private userAgent:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public host()Ljava/lang/String;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/messages/Source;->host:Ljava/lang/String;

    return-object v0
.end method

.method public port()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lio/minio/messages/Source;->port:Ljava/lang/String;

    return-object v0
.end method

.method public userAgent()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/Source;->userAgent:Ljava/lang/String;

    return-object v0
.end method
