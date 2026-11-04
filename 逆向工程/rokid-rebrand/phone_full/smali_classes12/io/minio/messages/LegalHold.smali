.class public Lio/minio/messages/LegalHold;
.super Ljava/lang/Object;
.source "LegalHold.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "LegalHold"
    strict = false
.end annotation


# instance fields
.field private status:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Z)V
    .locals 1
    .param p1, "status"    # Z

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    if-eqz p1, :cond_0

    .line 41
    const-string v0, "ON"

    iput-object v0, p0, Lio/minio/messages/LegalHold;->status:Ljava/lang/String;

    goto :goto_0

    .line 43
    :cond_0
    const-string v0, "OFF"

    iput-object v0, p0, Lio/minio/messages/LegalHold;->status:Ljava/lang/String;

    .line 45
    :goto_0
    return-void
.end method


# virtual methods
.method public status()Z
    .locals 2

    .line 49
    iget-object v0, p0, Lio/minio/messages/LegalHold;->status:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/messages/LegalHold;->status:Ljava/lang/String;

    const-string v1, "ON"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
