.class public Lio/minio/messages/ObjectLockConfiguration;
.super Ljava/lang/Object;
.source "ObjectLockConfiguration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ObjectLockConfiguration"
    strict = false
.end annotation


# instance fields
.field private objectLockEnabled:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ObjectLockEnabled"
    .end annotation
.end field

.field private rule:Lio/minio/messages/Rule;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Rule"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    const-string v0, "Enabled"

    iput-object v0, p0, Lio/minio/messages/ObjectLockConfiguration;->objectLockEnabled:Ljava/lang/String;

    .line 39
    return-void
.end method

.method public constructor <init>(Lio/minio/messages/RetentionMode;Lio/minio/messages/RetentionDuration;)V
    .locals 1
    .param p1, "mode"    # Lio/minio/messages/RetentionMode;
    .param p2, "duration"    # Lio/minio/messages/RetentionDuration;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    const-string v0, "Enabled"

    iput-object v0, p0, Lio/minio/messages/ObjectLockConfiguration;->objectLockEnabled:Ljava/lang/String;

    .line 44
    new-instance v0, Lio/minio/messages/Rule;

    invoke-direct {v0, p1, p2}, Lio/minio/messages/Rule;-><init>(Lio/minio/messages/RetentionMode;Lio/minio/messages/RetentionDuration;)V

    iput-object v0, p0, Lio/minio/messages/ObjectLockConfiguration;->rule:Lio/minio/messages/Rule;

    .line 45
    return-void
.end method


# virtual methods
.method public duration()Lio/minio/messages/RetentionDuration;
    .locals 1

    .line 54
    iget-object v0, p0, Lio/minio/messages/ObjectLockConfiguration;->rule:Lio/minio/messages/Rule;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/messages/ObjectLockConfiguration;->rule:Lio/minio/messages/Rule;

    invoke-virtual {v0}, Lio/minio/messages/Rule;->duration()Lio/minio/messages/RetentionDuration;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public mode()Lio/minio/messages/RetentionMode;
    .locals 1

    .line 49
    iget-object v0, p0, Lio/minio/messages/ObjectLockConfiguration;->rule:Lio/minio/messages/Rule;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/messages/ObjectLockConfiguration;->rule:Lio/minio/messages/Rule;

    invoke-virtual {v0}, Lio/minio/messages/Rule;->mode()Lio/minio/messages/RetentionMode;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method
